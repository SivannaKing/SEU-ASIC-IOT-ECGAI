import torch
import torch.nn as nn
from utils.OP import WeightOperation
from utils.dataset import Loader


device = torch.device('cpu')
import numpy as np
import random
import os



def get_ecg_data():
    classes_num = 5
    test_size = 0.2
    if classes_num == 17:
        batch_size = 64
        lr = 0.002
        seed = 142
    else:
        batch_size = 512
        lr = 0.02
        seed = 101  # 211

    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)

    loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=test_size)
    pad = nn.ConstantPad1d(padding=5, value=1)
    data = loader.test_dataset[0][0]
    pad_data = pad(data)
    final_data = torch.sign(pad_data).to(device)
    return final_data

def get_weight_data():
    model_best = torch.load(f'./models/ECG_Net_for_5_91.28%.pth', map_location=torch.device('cpu'))

    weightOperation = WeightOperation(model_best)
    weightOperation.WeightBinarize()

    return model_best.block1.conv.weight.data.to(device)

def get_conv_data(ecg_data, weight):
    return nn.functional.conv1d(ecg_data, weight, bias=None, stride=2)

def write_to_txt(conv_result, filename, I):

    # Assuming your tensor is named 'conv_result'
    channel_0 = conv_result[I, :].to('cpu')  # Extract the 0th channel
    zero_tensor = torch.zeros(9).to('cpu')
    channel_0 = torch.cat((channel_0, zero_tensor))
    # Convert to binary and then to hexadecimal
    # binary_values = np.vectorize(lambda x: format(np.int16(x) & 0xf, '04b'))(channel_0)
    # hex_values = np.vectorize(lambda x: hex(int(x, 2)))(binary_values)
    hex_values = np.vectorize(lambda x: format(int(np.int16(x) & 0xf), 'x'))(channel_0)

    # Reshape into groups of 8
    hex_values = hex_values.reshape((-1, 8))
    #去掉空格
    # hex_values = np.apply_along_axis(lambda x: ''.join(x), 1, hex_values)
    # Save to file
    with open('temp.txt', 'w') as f:
        for row in hex_values:
            f.write(' '.join(row) + '\n')

    with open('temp.txt', "r") as f:
        lines = f.readlines()

    # 去除每行两侧的方括号和换行符，合并为一个字符串
    new_lines = ["".join(line.strip()).replace(" ", "") for line in lines]

    # 将新的字符串写入文件
    with open(filename, "w") as f:
        f.write("\n".join(new_lines))
    os.remove('temp.txt')




if __name__ == '__main__':
    ecg_data = get_ecg_data()
    weight_data = get_weight_data()
    conv_data = get_conv_data(ecg_data, weight_data)
    folder_path = os.path.abspath(os.path.join(os.getcwd(), ".", "Compare","Block1_Output_Channel_Com"))
    for i in range(8):
        write_to_txt(conv_data.to(torch.int32), filename=f'{folder_path}/Output_channel_{i}_py.txt', I=i)
        # clean_txt_without_space(old_filename=f'{folder_path}/Output_channel_{i}_py.txt', new_filename=f'New_Output_channel_{i}_py.txt')




