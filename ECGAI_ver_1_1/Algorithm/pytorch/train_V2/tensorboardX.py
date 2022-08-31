import torch
import torchvision
from torch.utils.tensorboard import SummaryWriter
from collections import Counter
import numpy as np
import network
import load
import matplotlib.pyplot as plt
from scipy.stats import kde
from torchstat import stat

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

writer = SummaryWriter()

model = network.build_network()
model.load_state_dict(torch.load('./0.938_466.pth'))

model.eval()

train = load.load_dataset("./train_32.json")
dev = load.load_dataset("./dev_32.json")
preproc = load.Preproc(*train)

train_x, train_y = preproc.process(*train)
dev_x, dev_y = preproc.process(*dev)
train_x = train_x.swapaxes(2, 1)
dev_x = dev_x.swapaxes(2, 1)

train_x = torch.tensor(train_x)
train_y = torch.LongTensor(train_y)
test_x = torch.tensor(dev_x)
test_y = torch.LongTensor(dev_y)

torch_test_data = GetLoader(test_x, test_y)




writer.add_graph(model, test_x)

parm={}

param = []
for name,parameters in model.named_parameters():
    print(name,':',parameters.size())
    parm[name]=parameters.detach().numpy()
    param = np.append(param, parm[name])


max = np.max(param)
min = np.min(param)
step = (max - min)/15
step1 = (max - min)/14

bin_range = np.arange(min, max, step)
hist, _ = np.histogram(param, bins=bin_range)


density = kde.gaussian_kde(param)
x = np.linspace(min, max, 300)
y =density(x)

plt.plot(x,y)
plt.title("Density Plot of the weight")
plt.show()

# 绘制图像
fig, ax1 = plt.subplots()
fig.set_size_inches(10, 6)
plt.set_cmap('RdBu')
x = np.arange(min, max, step1)



plt.bar(x, hist, width = 0.1, align='center')

# 设置坐标轴的标签
ax1.yaxis.set_tick_params(labelsize=15) # 设置y轴的字体的大小
ax1.set_xticks(x) # 设置xticks出现的位置
# 设置坐标轴名称
ax1.set_ylabel("Count", fontsize='xx-large')
# 设置标题
ax1.set_title('The Distribution of Normal1 Data and Normal2 Data', fontsize='x-large')
# 设置图例
plt.legend(('Normal1','Nomral2'),fontsize = 'x-large', loc='upper right')
plt.show()



'''
writer.add_histogram("weight", param)

writer.add_histogram("weight_conv1", parm['conv1.weight'])
writer.add_histogram("weight_conv2", parm['conv2.weight'])
writer.add_histogram("weight_conv3", parm['conv3.weight'])
writer.add_histogram("weight_conv4", parm['conv4.weight'])
writer.add_histogram("weight_conv5", parm['conv5.weight'])
writer.add_histogram("weight_conv6", parm['conv6.weight'])
writer.add_histogram("weight_conv7", parm['conv7.weight'])
writer.add_histogram("weight_dense1", parm['dense1.weight'])
writer.add_histogram("weight_dense2", parm['dense2.weight'])

writer.close()
'''


