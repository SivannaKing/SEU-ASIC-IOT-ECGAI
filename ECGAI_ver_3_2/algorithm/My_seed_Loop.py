import torch
import torch.nn as nn
import torch.optim as optim

from utils.model import ECG_XNOR_Full_Bin, ECG_XNOR_Full_Ori, ECG_XNOR_Full_Thre
from utils.OP import WeightOperation
from utils.dataset import Loader
from utils.engine import train
from utils.save_model import save_model

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
import numpy as np
import random
import os
import time

# 110:92.97  170:92.97
# 17-142 5-101
acc_list = []
other_list = []
classes_num = 5
test_size = 0.2
if classes_num == 5:
    batch_size = 64
    lr = 0.002
    seed = 142
else:
    batch_size = 512
    lr = 0.02
    seed = 101
for i in range(100):
    # seed += 1
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)

    loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=test_size)
    labels, train_loader, test_loader = loader.loader()
    # in_channels, out_channels,    kernel_size,     stride,    padding,   pad_value,   pool_size,  pool_stride
    kernel_size, padding, poolsize = 7, 5, 7
    padding_value = 1
    A = [[1, 8, kernel_size, 2, padding, padding_value, poolsize, 2],
         [8, 16, kernel_size, 1, padding, padding_value, poolsize, 2],
         [16, 32, kernel_size, 1, padding, padding_value, poolsize, 2],
         [32, 32, kernel_size, 1, padding, padding_value, poolsize, 2],
         [32, 64, kernel_size, 1, padding, padding_value, poolsize, 2],
         [64, classes_num, kernel_size, 1, padding, padding_value, poolsize, 2],
         ]

    model = ECG_XNOR_Full_Bin(block1=A[0], block2=A[1], block3=A[2], block4=A[3],
                               block5=A[4] if len(A) > 4 else None,
                               block6=A[5] if len(A) > 5 else None,
                               block7=A[6] if len(A) > 6 else None,
                               device=device).to(device)
    loss_fn = nn.CrossEntropyLoss().to(device)
    optimizer = optim.Adam(model.parameters(), lr=lr)

    # from torchinfo import summary

    # summary(model=model,
    #         input_size=(batch_size, 1, 3600),  # make sure this is "input_size", not "input_shape"
    #         col_names=["input_size", "output_size", "num_params", "trainable"],
    #         col_width=20,
    #         row_settings=["var_names"])

    weightOperation = WeightOperation(model)
    num_epochs = 1000
    best_test_acc = train(model=model,
                          train_dataloader=train_loader,
                          test_dataloader=test_loader,
                          optimizer=optimizer,
                          loss_fn=loss_fn,
                          epochs=num_epochs,
                          device=device,
                          writer=False,
                          weight_op=weightOperation,
                          classes_num=classes_num)

    print("-" * 50 + "\n")
    acc_str = "{:.2f}".format(best_test_acc * 100) + '%'
    from utils.Draw import plot_cfm
    # model_best = torch.load(f'./models/ECG_Net_for_{classes_num}_{acc_str}.pth')
    # plot_cfm(model_best, test_loader, classes=labels, mode='bcnn', cnt=1000, clt=classes_num, seed=seed, best_test_acc=best_test_acc)
    # acc_list.append(best_test_acc)
