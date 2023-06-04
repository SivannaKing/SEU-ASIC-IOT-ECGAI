import os
from random import random
from My_Basic_Net.utils.plot import plot_cfm
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from matplotlib import pyplot as plt

from My_Basic_Net.utils.OP_try import Bn_bin_conv_pool_block, BinLinear, WeightOperation
from My_Basic_Net.utils.Dataprocess import Loader

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

batch_size = 64
classes_num = 17

seed = 110
def set_seed(seed):
    # random.seed(seed)
    os.environ['PYTHONHASHSEED'] = str(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)  # if you are using multi-GPU.
    torch.backends.cudnn.benchmark = False
    torch.backends.cudnn.deterministic = True
set_seed(seed)


class ECG_XNOR(nn.Module):
    def __init__(self):
        super(ECG_XNOR, self).__init__()
        self.name = 'ECG_XNOR'
        self.device = device
        self.block1 = Bn_bin_conv_pool_block(in_channels=1, out_channels=8, kernel_size=16, \
                                stride=2, padding=7,pool_size=8,pool_stride=4)
        self.block2 = Bn_bin_conv_pool_block(in_channels=8, out_channels=12, kernel_size=12, \
                                stride=2, padding=5,pool_size=4,pool_stride=2)
        self.block3 = Bn_bin_conv_pool_block(in_channels=12, out_channels=32, kernel_size=9, \
                                stride=1, padding=4,pool_size=5,pool_stride=2)
        self.block4 = Bn_bin_conv_pool_block(in_channels=32, out_channels=64, kernel_size=7, \
                                stride=1, padding=3,pool_size=4,pool_stride=2)
        self.block5 = Bn_bin_conv_pool_block(in_channels=64, out_channels=64, kernel_size=5, \
                                stride=1, padding=2,pool_size=2,pool_stride=2)
        self.block6 = Bn_bin_conv_pool_block(in_channels=64, out_channels=64, kernel_size=3, \
                                stride=1, padding=1,pool_size=2,pool_stride=2)
        self.block7 = Bn_bin_conv_pool_block(in_channels=64, out_channels=72, kernel_size=3, \
                                stride=1, padding=1,pool_size=2,pool_stride=2)
        self.flatten = nn.Flatten()
        self.linear1 = BinLinear(in_features=216, out_features=64)
        # self.bn8 = nn.BatchNorm1d(64)
        # self.htanh8 = nn.Hardtanh()
        # self.dropout1 = nn.Dropout(p = 0.1)
        self.linear2 = BinLinear(in_features=64, out_features=17)

    def forward(self,batch_data):
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        batch_data = self.block1(batch_data)
        batch_data = self.block2(batch_data)
        batch_data = self.block3(batch_data)
        batch_data = self.block4(batch_data)
        batch_data = self.block5(batch_data)
        batch_data = self.block6(batch_data)
        batch_data = self.block7(batch_data)
        batch_data = self.flatten(batch_data)
        batch_data = self.linear1(batch_data)
        batch_data = self.linear2(batch_data)

        return batch_data


loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=0.2)
labels, train_loader, test_loader = loader.loader()


model = ECG_XNOR().to(device)
loss_fn = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters())

weightOP = WeightOperation(model)

epochs = 500
results = {"train_loss": [],
               "train_acc": [],
               "test_loss": [],
               "test_acc": []
               }
best_test_acc = 0.0
best_train_acc = 0.0
best_test_epoch = 0
best_train_epoch = 0
# Make sure model on target device
model.to(device)

train_losses = []
train_acces = []
eval_losses = []
eval_acces = []

for epoch in range(epochs):
    ##################################开始训练########################################
    train_acc = 0
    train_loss = 0
    model.train()  # 将模型改为训练模式


    correct, total = 0, 0
    for X, y in train_loader:
        X, y = X.to(device), y.to(device)

        #
        # 前向传播，得到损失
        y_pred = model(X)

        # 反向传播，将上一次的梯度清0，反向传播，并且step更新相应的参数
        loss = loss_fn(y_pred, y)
        # 记录误差
        train_loss += loss.item()

        optimizer.zero_grad()
        weightOP.WeightSave()
        weightOP.WeightBinarize()
        loss.backward()


        weightOP.WeightGradient()
        optimizer.step()
        weightOP.WeightRestore()

        # y_pred = BinarizeF.apply(y_pred)

        # 计算分类的准确率
        _, predicted = torch.max(y_pred.data, dim=1)  # 取出预测的最大值
        correct += (predicted == y).sum().cpu().item()  # 判断预测是否正确
        total += len(y)

    train_loss = train_loss / len(train_loader)
    train_acc = correct / total
    train_losses.append(train_loss / len(train_loader))
    train_acces.append(correct / total)
    weightOP.WeightSave()
    weightOP.WeightBinarize()
    ##########################每进行一次迭代，就去测试一次##################################
    model.eval()
    test_loss, test_acc = 0, 0
    correct, total = 0, 0

    with torch.inference_mode():
        for (X, y) in test_loader:
            X, y = X.to(device), y.to(device)
            test_pred_logits = model(X)
            # test_pred_logits = BinarizeF.apply(test_pred_logits)
            loss = loss_fn(test_pred_logits, y)

            test_loss += loss.item()

            _, predicted = torch.max(test_pred_logits.data, dim=1)  # 输出概率最大的标签
            total += len(y)
            correct += (predicted == y).sum().cpu().item()  # 判断是否预测准确

    test_loss = test_loss / len(test_loader)
    test_acc = correct / total
    eval_losses.append(test_loss / len(train_loader))
    eval_acces.append(correct / total)
    weightOP.WeightRestore()
    if test_acc > best_test_acc:
        best_test_acc = test_acc
        best_test_epoch = epoch + 1
        acc_str = "{:.2f}".format(best_test_acc * 100) + '%'

    if train_acc > best_train_acc:
        best_train_acc = train_acc
        best_train_epoch = epoch + 1
        acc_str = "{:.2f}".format(best_test_acc * 100) + '%'

    print(
        f"Epoch: {epoch + 1} | "
        f"train_loss: {train_loss:.4f} | "
        f"train_acc: {train_acc:.4f} | "
        f"test_loss: {test_loss:.4f} | "
        f"test_acc: {test_acc:.4f}"
    )

    results["train_loss"].append(train_loss)
    results["train_acc"].append(train_acc)
    results["test_loss"].append(test_loss)
    results["test_acc"].append(test_acc)

# print(model.state_dict())
print('best_test_acc: ', "{:.2f}".format(best_test_acc * 100) + '%', '\t epoch: ', best_test_epoch)
print('best_train_acc: ', "{:.2f}".format(best_train_acc * 100) + '%', '\t epoch: ', best_train_epoch)
print("-" * 50 + "\n")

plt.plot(np.arange(len(train_losses)), train_losses, label="train loss")
plt.plot(np.arange(len(train_acces)), train_acces, label="train acc")
plt.plot(np.arange(len(eval_losses)), eval_losses, label="test loss")
plt.plot(np.arange(len(eval_acces)), eval_acces, label="test acc")
plt.legend()
plt.xlabel('epoches')
plt.title('Model loss & accuracy')
plt.show()

plot_cfm(model, test_loader, classes=labels, mode='bnn_ecg_xnor_net00', cnt=1000, clt=classes_num)

