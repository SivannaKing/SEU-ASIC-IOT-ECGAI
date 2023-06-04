import os
import torch
import os
import scipy.io as scio
from sklearn.model_selection import train_test_split
import numpy as np
from torch.utils.data import Dataset, DataLoader

def get_data(classes_num, device, test_size):
    classes_num = 17
    device = device
    dataset_path= '../ECG_Dataset/ECG-17'
    classes = ['NSR', 'APB', 'AFL', 'AFIB', 'SVTA', 'WPW', 'PVC', 'Bigeminy',
                   'Trigeminy', 'VT', 'IVR', 'VFL', 'Fusion', 'LBBBB', 'RBBBB', 'SDHB', 'PR']
    len_classes = len(classes)
    X = list()
    y = list()
    for root, dirs, files in os.walk(dataset_path, topdown=False):
        for name in files:
            data_train = scio.loadmat(
                os.path.join(root, name))  # 取出字典里的value

            # arr -> list
            data_arr = data_train.get('val')
            data_list = data_arr.tolist()
            X.append(data_list[0])  # [[……]] -> [ ]
            y.append(int(os.path.basename(root)[0:2]) - 1)

    X = torch.tensor(X, dtype=torch.float32)
    y = torch.tensor(y, dtype=torch.long)
    X_mean = torch.mean(X, dim=1, keepdim=True)
    X_std = torch.std(X, dim=1, keepdim=True)
    X = (X - X_mean) / X_std
    # X = X-X_mean
    print('X shape before reshape:', X.shape)
    X = X.reshape((1024, 1, 3600)).to(device)
    y = y.reshape((1024)).to(device)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size)
    return classes, X_train, X_test, y_train, y_test
class TrainDatasets(Dataset):
    def __init__(self, x_train, y_train):
        self.len = x_train.size(0)
        self.x_train = x_train
        self.y_train = y_train

    def __getitem__(self, index):
        return self.x_train[index], self.y_train[index]

    def __len__(self):
        return self.len


class TestDatasets(Dataset):
    def __init__(self, x_test, y_test):
        self.len = x_test.size(0)
        self.x_test = x_test
        self.y_test = y_test

    def __getitem__(self, index):
        return self.x_test[index], self.y_test[index]

    def __len__(self):
        return self.len


class Loader:
    def __init__(self, batch_size, classes_num, device, test_size):
        self.classes, self.x_train, self.x_test, self.y_train, self.y_test = get_data(classes_num, device, test_size)
        self.batch_size = batch_size
        self.train_dataset = TrainDatasets(self.x_train, self.y_train)
        self.test_dataset = TestDatasets(self.x_test, self.y_test)

    def loader(self):
        train_loader = DataLoader(dataset=self.train_dataset, batch_size=self.batch_size, shuffle=True)
        test_loader = DataLoader(dataset=self.test_dataset, batch_size=self.batch_size, shuffle=False)
        return self.classes, train_loader, test_loader