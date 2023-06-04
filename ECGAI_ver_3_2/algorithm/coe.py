import torch
import numpy as np
import random
from utils.dataset import Loader
import torch.nn as nn

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
    seed = 101  #211


random.seed(seed)
np.random.seed(seed)
torch.manual_seed(seed)
torch.cuda.manual_seed(seed)

pad = nn.ConstantPad1d(padding=5, value=1)

loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=test_size)
#取测试集的第0个数据(1,3600),并将其降维为(3600)，再转化为int32类型
#采取新策略:每行存储32个1bit数据，这样的话先要补齐3610不够的部分:
data = loader.test_dataset[0][0].squeeze()
pad_data = pad(data)   #3600 --3610
padding_size = (32 - len(pad_data) % 32) % 32  #要再在尾巴补这么多个数才能被32整除
zero_tensor = torch.zeros(padding_size)

new_data = torch.cat((pad_data, zero_tensor))

new_data[new_data > 0] = 1
new_data[new_data <= 0] = 0
data = new_data.to(torch.int32)
# labels, train_loader, test_loader = loader.loader()


def array_to_coe(arr, filename):
    with open('filename', 'w') as f:
        f.write('memory_initialization_radix=2;\n')
        f.write('memory_initialization_vector=\n')

        # 写入每个值
        for i in range(arr.shape[0]):
            row = ''.join(str(int(x)) for x in arr[i])
            f.write(row + ',\n')


# arr = torch.randint(0, 2, (113, 32))
array_to_coe(data, 'ecg_data.coe')