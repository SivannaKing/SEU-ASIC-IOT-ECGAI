from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import logging
import os
import random
import time

import torch
import torch.optim as optim
from matplotlib import pyplot as plt
from torch.autograd import variable
from torch.utils.data import DataLoader
from torchsummary import summary
from tqdm import tqdm

import load
import network
import util

import torch.nn as nn
import torch.nn.functional as F


# 用于将一般数据集转换为dataloader
def get_logger(filename, verbosity=1, name=None):
    level_dict = {0: logging.DEBUG, 1: logging.INFO, 2: logging.WARNING}
    formatter = logging.Formatter(
        "[%(asctime)s][%(filename)s][line:%(lineno)d][%(levelname)s] %(message)s"
    )
    logger = logging.getLogger(name)
    logger.setLevel(level_dict[verbosity])

    fh = logging.FileHandler(filename, "w")
    fh.setFormatter(formatter)
    logger.addHandler(fh)

    sh = logging.StreamHandler()
    sh.setFormatter(formatter)
    logger.addHandler(sh)

    return logger


use_gpu = torch.cuda.is_available()


# 定义GetLoader类，继承Dataset方法，并重写__getitem__()和__len__()方法
class GetLoader(torch.utils.data.Dataset):

    def __init__(self, data_root, data_label):
        self.data = data_root
        self.label = data_label

    def __getitem__(self, index):
        data = self.data[index]
        labels = self.label[index]
        return data, labels

    def __len__(self):
        return len(self.data)


# 保存模型文件名
def get_filename_for_saving(save_dir):
    return os.path.join(save_dir, "{:.3f}_{:03d}.pth")


# 保存模型文件路径
def make_save_dir(dirname):
    start_time = str(int(time.time())) + '-' + str(random.randrange(1000))
    save_dir = os.path.join(dirname, start_time)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    return save_dir


def train():
    print("Loading training set...")
    train = load.load_dataset("./train_32.json")
    print("Loading dev set...")
    dev = load.load_dataset("./dev_32.json")
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")

    save_dir = make_save_dir("saved")

    util.save(preproc, save_dir)

    model = network.build_network()
    model.load_state_dict(torch.load('0.938_466.pth'))

    q_model = torch.quantization.quantize_dynamic(model, {nn.Conv1d, nn.Linear}, dtype=torch.qint8)
    summary(model, (1, 3600), device="cpu")



    train_x, train_y = preproc.process(*train)
    dev_x, dev_y = preproc.process(*dev)
    train_x = train_x.swapaxes(2, 1)
    dev_x = dev_x.swapaxes(2, 1)
    # 调换维度符合网络的输出结构

    train_x = torch.tensor(train_x)
    train_y = torch.LongTensor(train_y)
    test_x = torch.tensor(dev_x)
    test_y = torch.LongTensor(dev_y)

    optimizer = optim.Adam(model.parameters(), lr=3e-4)

    if (use_gpu):
        model = model.cuda()
        train_x, train_y = train_x.cuda(), train_y.cuda()
        test_x, test_y = test_x.cuda(), test_y.cuda()

    torch_data = GetLoader(train_x, train_y)
    trainloader = DataLoader(torch_data, batch_size=32, shuffle=True, drop_last=False, num_workers=0)
    torch_test_data = GetLoader(test_x, test_y)
    testloader = DataLoader(torch_test_data, batch_size=304, shuffle=True, drop_last=False, num_workers=0)

    loss_count = []
    logger = get_logger('./logs/exp.log')
    logger.info('start training!')
    epochs = 3000
    max_acc = 0.8
    criterion = torch.nn.CrossEntropyLoss()

    for epoch in range(epochs):
        for i, (x, y) in enumerate(tqdm(trainloader)):
            model.train()
            batch_x = variable(x)
            batch_y = variable(y)
            batch_y = torch.topk(batch_y, 1)[1].squeeze(1)
            out = model(batch_x)
            #out = torch.topk(out, 1)[1].squeeze(1)

            loss = criterion(out, batch_y)

            optimizer.zero_grad()
            loss.backward()
            optimizer.step()
            loss_count.append(loss)
            for a, b in testloader:
                model.eval()
                test_x = variable(a)
                test_y = variable(b)
                out = model(test_x)
                accuracy = torch.max(out, 1)[1].cpu().numpy() == torch.max(test_y, 1)[1].cpu().numpy()
                if accuracy.mean() > max_acc:
                    max_acc = accuracy.mean()
                    best_modle_pth = os.path.join(save_dir, "{:.3f}_{:03d}.pth".format(accuracy.mean(), epoch))
                    torch.save(model.state_dict(), best_modle_pth)
                break
        logger.info('Epoch:[{}/{}]\t loss={:.5f}\t acc={:.3f}'.format(epoch, epochs, loss, accuracy.mean()))

    plt.figure('PyTorch_CNN_Loss')
    plt.plot(loss_count, label='Loss')
    plt.legend()
    plt.show()


if __name__ == '__main__':
    train()
