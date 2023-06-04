import torch
import torch.nn as nn
import torch.optim as optim
from torchvision.ops.focal_loss import sigmoid_focal_loss
from utils.model import ECG_XNOR_Full_Bin, ECG_XNOR_Full_Ori
from utils.OP import WeightOperation
from utils.dataset import Loader
from utils.engine import train
from utils.save_model import save_model

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
import numpy as np
import random
import os

# 110:92.97  170:92.97
classes_num = 5
test_size = 0.2
if classes_num == 5:
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
labels, train_loader, test_loader = loader.loader()

import re


def array_to_txt(arr, filename):
    with open(filename, 'w') as f:
        # 写入每个值
        for i in range(arr.shape[0]):
            row = ''.join(str(int(x)) for x in arr[i])
            # 在每8位后面插入"_"
            # row = re.sub("(.{7})", "\\1_", row)
            f.write(row + '\n')

def folder_txt_to_coe(input_folder, output_folder):
    for filename in os.listdir(input_folder):
        if filename.endswith(".txt"):
            with open(os.path.join(input_folder, filename), "r") as txt_file:
                data = txt_file.read()
                data = data.replace("_", "")
                data = data.replace("\n", "")
                coe_filename = filename.replace(".txt", ".coe")
                with open(os.path.join(output_folder, coe_filename), "w") as coe_file:
                    coe_file.write("memory_initialization_radix=2;\nmemory_initialization_vector=\n")
                    for i in range(0, len(data), 28):
                        coe_file.write(data[i:i+28] + ",\n")
                    coe_file.write(";")

if __name__ == "__main__":
    model_best = torch.load(f'./models/ECG_Net_for_{classes_num}_91.60%.pth')
    weightOperation = WeightOperation(model_best)
    weightOperation.WeightBinarize()

    conv_weight_path = os.path.abspath(os.path.join(os.getcwd(), "Data", "9160", "Conv_Weight"))
    conv_coe_path = os.path.abspath(os.path.join(os.getcwd(), "Data", "9160", "Conv_Weight_Coe"))
    for i in range(1,7):
        weight = model_best.state_dict()[f"block{i}.conv.weight"]
        weight[weight == 1] = 1
        weight[weight == -1] = 0
        # weight = weight.reshape(-1)
        weight = weight.reshape((-1, 28))
        array_to_txt(weight, f"{conv_weight_path}/block{i}_weight.txt")


    folder_txt_to_coe(conv_weight_path, conv_coe_path)
