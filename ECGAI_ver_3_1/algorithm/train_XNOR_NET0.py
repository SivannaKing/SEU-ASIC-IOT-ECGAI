import os
import random
from typing import Tuple
import torchinfo
from torchinfo import summary

import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from matplotlib import pyplot as plt
from My_Basic_Net.utils.plot import plot_cfm
from My_Basic_Net.utils.OP_XNOR_NET1 import Bn_bin_conv_pool, WeightOperation, save_model
from My_Basic_Net.utils.OP_XNOR_NET0 import BinLinear, WeightOperation,save_model
from My_Basic_Net.utils.Dataprocess import Loader
from My_Basic_Net.utils.engine import train, create_writer

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

batch_size = 64
classes_num = 17
seed = 110
def set_seed(seed):
    random.seed(seed)
    os.environ['PYTHONHASHSEED'] = str(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed) # if you are using multi-GPU.
    torch.backends.cudnn.benchmark = False
    torch.backends.cudnn.deterministic = True
set_seed(seed)

lr = 0.01
epochs = 1000
#
# class ECG_XNOR0(nn.Module):
#     def __init__(self, device):
#         super(ECG_XNOR0, self).__init__()
#         self.name = 'Bin_ECG'
#         self.device = device
#         self.classifier = nn.Sequential(
#         # input_channels, output_channels, kernel_size, stride, padding, pad_value, pool_size, pool_stride
#             Bn_bin_conv_pool( 1, 8, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 8, 16, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 16, 32, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 32, 64, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 64, 72, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 72, 32, 11, 1, 7, 1,
#                               5, 2),
#             Bn_bin_conv_pool( 32, 32, 11, 1, 7, 1,
#                               5, 2)
#                     )
#         self.flatten = nn.Flatten()
#         self.linear1 = BinLinear(in_features=928, out_features=64)
#         # self.bn8 = nn.BatchNorm1d(64)
#         # self.htanh8 = nn.Hardtanh()
#         self.prelu8 = nn.PReLU()
#         self.dropout1 = nn.Dropout(p = 0.1)
#         self.linear2 = BinLinear(in_features=64, out_features=17)
#         self.dropout2 = nn.Dropout(p=0.5) # 防止过拟合
#
#     def forward(self, batch_data):
#         batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
#         batch_data = self.classifier(batch_data)
#         batch_data = self.flatten(batch_data)
#         batch_data = self.linear1(batch_data)
#         # batch_data = self.bn8(batch_data)
#         # batch_data = self.htanh8(batch_data)
#         batch_data = self.dropout1(batch_data)
#         batch_data = self.linear2(batch_data)
#         batch_data = self.dropout2(batch_data)
#
#         return batch_data
class ECG_XNOR0(nn.Module):
    def __init__(self, device):
        super(ECG_XNOR0, self).__init__()
        self.name = 'Bin_ECG'
        self.device = device
        padding = 5
        pool_size = 5
        self.classifier = nn.Sequential(
        # input_channels, output_channels, kernel_size:335733, stride, padding7, pad_value, pool_size5, pool_stride
            Bn_bin_conv_pool( 1, 8, 11, 1, padding, 1,
                            pool_size, 2),
            Bn_bin_conv_pool( 8, 16, 11, 1, padding, 1,
                              pool_size, 2),
            Bn_bin_conv_pool( 16, 32, 11, 1, padding, 1,
                              pool_size, 2),
            Bn_bin_conv_pool(32, 64, 11, 1, padding, 1,
                             pool_size, 2),# 加一层
            Bn_bin_conv_pool( 64, 72, 11, 1, padding, 1,
                              pool_size, 2),
            Bn_bin_conv_pool(72, 32, 11, 1, padding, 1,
                             pool_size, 2),
            Bn_bin_conv_pool( 32, 64, 11, 1, padding, 1,
                              pool_size, 2)

        )
        self.flatten = nn.Flatten()
        self.linear1 = BinLinear(in_features=32, out_features=32)
        #         # self.bn8 = nn.BatchNorm1d(64)
        #         # self.htanh8 = nn.Hardtanh()
        #         self.prelu8 = nn.PReLU()
        self.dropout1 = nn.Dropout(p = 0.1)
        self.linear2 = BinLinear(in_features=2240, out_features=17)
        self.dropout2 = nn.Dropout(p=0.5) # 防止过拟合

    def forward(self, batch_data):
        # print('batch_data.shape: ', batch_data.shape)  # [32, 1, 3600]
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        batch_data = self.classifier(batch_data)
        # batch_data = self.flatten(batch_data)
        # print('000000: ', batch_data.shape)  # [32, 17, 64]
        # batch_data = self.linear1(batch_data)
        # batch_data = self.dropout1(batch_data)
        # batch_data = self.linear1(batch_data)
        batch_data = self.dropout2(batch_data)
        batch_data = batch_data.mean(dim=2)  # 去掉一个维度

        return batch_data


loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=0.2)
labels, train_loader, test_loader = loader.loader()

model = ECG_XNOR0(device)
# 其中numel()函数用于计算p张量中元素的数量，而element_size()则返回每个元素的字节数。
print(f"Number of parameters: {sum(p.numel() for p in model.parameters())}")
print(f"Memory size: {sum(p.numel() * p.element_size() for p in model.parameters())} bytes")

loss_fn = nn.CrossEntropyLoss().to(device)
optimizer = optim.Adam(model.parameters())
# lr_scheduler=torch.optim.lr_scheduler.CosineAnnealingWarmRestarts(optimizer,epochs,1,0.02)
lr_scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=0.05,last_epoch=-1)

weightOP = WeightOperation(model)

# Make sure model on target device
model.to(device)
train(model=model,
      train_dataloader=train_loader,
      test_dataloader=test_loader,
      optimizer=optimizer,
      loss_fn=loss_fn,
      epochs=epochs,
      device=device,
      # writer=create_writer(experiment_name='11.5.xnor_exp_3kepoch_1th',
      #                      model_name=model.name,
      #                      extra=f"{epochs}_epochs"),
      weight_op = weightOP)


plot_cfm(model, test_loader, classes=labels, mode='bnn_ecg_xnor_net0', cnt=1000, clt=classes_num)
