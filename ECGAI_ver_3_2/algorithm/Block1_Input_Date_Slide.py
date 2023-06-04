import torch
import numpy as np
import random
from utils.dataset import Loader
import torch.nn as nn


def prepare_data():
    device = torch.device('cpu')

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

    pad = nn.ConstantPad1d(padding=5, value=1)

    loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=test_size)
    # 取测试集的第0个数据(1,3600),并将其降维为(3600)，再转化为int32类型
    data = loader.test_dataset[0][0].squeeze()
    pad_data = pad(data)
    pad_data[pad_data > 0] = 1
    pad_data[pad_data <= 0] = 0  # 3600 to 3610
    tensor = pad_data.to(torch.int32)  # 1.0/0.0 to 1/0

    return tensor


import os


def Slide_data_save(tensor, filename):
    tensor[tensor == -1] = 0
    indices = []
    for i in range(0, tensor.shape[0] - 6, 1):
        indices.append(i)

    # Get the data in each convolution window
    data = []
    # tensor = tensor.reshape(1, 3610)
    for i in indices:
        data.append(tensor[i:i + 7].tolist())

    # Save the data to a txt file
    with open('temp.txt', 'w') as f:
        for d in data:
            f.write(str(d) + '\n')

    with open('temp.txt', "r") as f:
        lines = f.readlines()

    # 去除每行两侧的方括号和换行符，合并为一个字符串
    new_lines = ["".join(line.strip()[1:-1].split(",")).replace(" ", "") for line in lines]
    folder_path = os.path.abspath(os.path.join(os.getcwd(), ".", "Compare", "Block2_Slide_Data"))

    # 如果文件夹不存在，则创建它
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    file_path = os.path.join(folder_path, filename)
    # 将新的字符串写入文件
    with open(file_path, "w") as f:
        f.write("\n".join(new_lines))


if __name__ == "__main__":
    tensor = prepare_data()
    Slide_data_save(tensor, 'input.txt')
