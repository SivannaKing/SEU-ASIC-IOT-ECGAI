import torch
import torch.nn as nn
import torch.nn.functional as F
from torchsummary import summary

class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.conv1 = nn.Conv1d(1, 8, 16, stride=2, bias=False, padding=7)
        self.conv2 = nn.Conv1d(8, 12, 12, stride=2, bias=False, padding=5)
        self.conv3 = nn.Conv1d(12, 32, 9, stride=1, bias=False, padding=4)
        self.conv4 = nn.Conv1d(32, 64, 7, stride=1, bias=False, padding=3)
        self.conv5 = nn.Conv1d(64, 64, 5, stride=1, bias=False, padding=2)
        self.conv6 = nn.Conv1d(64, 64, 3, stride=1, bias=False, padding=1)
        self.conv7 = nn.Conv1d(64, 72, 3, stride=1, bias=False, padding=1)
        self.dropout1 = nn.Dropout(p=0.6)
        self.dense1 = nn.Linear(72*3, 64, bias=False)
        self.dropout2 = nn.Dropout(p=0.6)
        self.dense2 = nn.Linear(64, 17, bias=False)

    def forward(self, x):
        x = F.max_pool1d(torch.clamp(F.relu(self.conv1(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv2(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv3(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv4(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv5(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv6(x)), 0, 2), 2, 2)
        x = F.max_pool1d(torch.clamp(F.relu(self.conv7(x)), 0, 2), 4, 4)
        x = self.dropout1(x)
        x = x.view(-1, 72*3)
        x = self.dense1(x)
        x = self.dropout2(x)
        #x = x.view(-1, 1 * 64)
        x = self.dense2(x)
        return x

    def num_flat_features(self, x):
        size = x.size()[1:]
        num_features = 1
        for s in size:
            num_features *= s
        return num_features

class Net2d(nn.Module):
    def __init__(self):
        super(Net2d, self).__init__()
        self.conv1 = nn.Conv2d(1, 8, (1,16), stride=2, bias=False, padding=7)
        self.conv2 = nn.Conv2d(8, 12, (1,12), stride=2, bias=False, padding=5)
        self.conv3 = nn.Conv2d(12, 32, (1,9), stride=1, bias=False, padding=4)
        self.conv4 = nn.Conv2d(32, 64, (1,7), stride=1, bias=False, padding=3)
        self.conv5 = nn.Conv2d(64, 64, (1,5), stride=1, bias=False, padding=2)
        self.conv6 = nn.Conv2d(64, 64, (1,3), stride=1, bias=False, padding=1)
        self.conv7 = nn.Conv2d(64, 72, (1,3), stride=1, bias=False, padding=1)
        self.dropout1 = nn.Dropout(p=0.6)
        self.dense1 = nn.Linear(216, 64, bias=False)
        self.dropout2 = nn.Dropout(p=0.6)
        self.dense2 = nn.Linear(64, 17, bias=False)

    def forward(self, x):
        x = F.max_pool2d(torch.clamp(F.relu(self.conv1(x)), 0, 2), (1,8), 4)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv2(x)), 0, 2), (1,4), 2)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv3(x)), 0, 1), (1,5), 2)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv4(x)), 0, 1), (1,4), 2)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv5(x)), 0, 1), (1,2), 2)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv6(x)), 0, 1), (1,2), 2)
        x = F.max_pool2d(torch.clamp(F.relu(self.conv7(x)), 0, 1), (1,2), 2)
        x = self.dropout1(x)
        x = x.view(-1, 3 * 72)
        x = self.dense1(x)
        x = self.dropout2(x)
        #x = x.view(-1, 1 * 64)
        x = self.dense2(x)
        return x

    def num_flat_features(self, x):
        size = x.size()[1:]
        num_features = 1
        for s in size:
            num_features *= s
        return num_features


def build_network():
    net = Net()
    return net

def build_network_2d():
    net = Net2d()
    return net


if __name__ == "__main__":
    model = build_network()
    summary(model,(1,3600), device="cpu")
