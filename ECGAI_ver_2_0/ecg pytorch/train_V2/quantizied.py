import random
import time
import os
import torch
import torch.optim as optim
from matplotlib import pyplot as plt
from torch.autograd import variable
from torch.utils.data import DataLoader
from torchsummary import summary
from tqdm import tqdm

import load
import network
import network_pkps
import util
import inq
import logging
import shutil

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

def load_dataset():
    print("Loading training set...")
    train = load.load_dataset("./train_32.json")
    print("Loading dev set...")
    dev = load.load_dataset("./dev_32.json")
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")

    train_x, train_y = preproc.process(*train)
    dev_x, dev_y = preproc.process(*dev)
    train_x = train_x.swapaxes(2, 1)
    dev_x = dev_x.swapaxes(2, 1)


    # 调换维度符合网络的输出结构

    train_x = torch.tensor(train_x)
    train_y = torch.LongTensor(train_y)
    test_x = torch.tensor(dev_x)
    test_y = torch.LongTensor(dev_y)

    train_y = torch.topk(train_y, 1)[1].squeeze(1)
    test_y = torch.topk(test_y, 1)[1].squeeze(1)

    train_x, train_y = train_x.cuda(), train_y.cuda()
    test_x, test_y = test_x.cuda(), test_y.cuda()

    torch_data = GetLoader(train_x, train_y)
    train_loader = DataLoader(torch_data, batch_size=256, shuffle=True, drop_last=False, num_workers=0)
    torch_test_data = GetLoader(test_x, test_y)
    test_loader = DataLoader(torch_test_data, batch_size=304, shuffle=True, drop_last=False, num_workers=0)

    return train_loader,test_loader

def load_model():
    model = network_pkps.build_network()
    model.load_state_dict(torch.load('./0.934_204_pkps.pth'))
    return model

def train(train_loader, testloader, model, optimizer, epoch, inq_step):
    global n_iter
    batch_time = AverageMeter()
    data_time = AverageMeter()
    losses = AverageMeter()
    top1 = AverageMeter()
    top5 = AverageMeter()


    criterion = torch.nn.CrossEntropyLoss()

    # switch to train mode
    model.train()

    end = time.time()
    for i, (input, target) in enumerate(train_loader):
        model.train()
        # measure data loading time
        data_time.update(time.time() - end)

        target = target.cuda(non_blocking=True)


        # compute output
        output = model(input)
        loss = criterion(output, target)

        # measure accuracy and record loss
        losses.update(loss.item(), input.size(0))

        # compute gradient and do SGD step
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        # measure elapsed time
        batch_time.update(time.time() - end)
        end = time.time()


        model.eval()
        acc1, acc5 = validate(testloader, model)
        top1.update(acc1[0], input.size(0))
        top5.update(acc5[0], input.size(0))


        if i % 100 == 0:
            print("the INQ in step:",inq_step)
            print('Epoch: [{0}][{1}/{2}]\t'
                  'Time {batch_time.val:.3f} ({batch_time.avg:.3f})\t'
                  'Data {data_time.val:.3f} ({data_time.avg:.3f})\t'
                  'Loss {loss.val:.4f} ({loss.avg:.4f})\t'
                  'Acc@1 {top1.val:.3f} ({top1.avg:.3f})\t'
                  'Acc@5 {top5.val:.3f} ({top5.avg:.3f})'.format(
                   epoch,i, len(train_loader), batch_time=batch_time,
                   data_time=data_time, loss=losses, top1=top1, top5=top5))

    return acc1, acc5


def validate(val_loader, model):
    global n_iter
    batch_time = AverageMeter()
    losses = AverageMeter()
    top1 = AverageMeter()
    top5 = AverageMeter()

    criterion = torch.nn.CrossEntropyLoss()

    # switch to evaluate mode
    model.eval()

    with torch.no_grad():
        end = time.time()
        for i, (input, target) in enumerate(val_loader):
            target = target.cuda()

            # compute output
            output = model(input)
            loss = criterion(output, target)

            # measure accuracy and record loss
            acc1, acc5 = accuracy(output, target, topk=(1, 5))
            losses.update(loss.item(), input.size(0))
            top1.update(acc1[0], input.size(0))
            top5.update(acc5[0], input.size(0))


            # measure elapsed time
            batch_time.update(time.time() - end)
            end = time.time()

        #print(' * Acc {Acc.avg:.3f}'
              #.format(Acc=Acc))

    return acc1, acc5


def save_checkpoint(state, is_best, filename='checkpoint.pth.tar'):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    torch.save(state, filename)
    if is_best:
        shutil.copyfile(filename, os.path.join(os.path.dirname(filename),'model_best.pth.tar'))


class AverageMeter(object):
    """Computes and stores the average and current value"""
    def __init__(self):
        self.reset()

    def reset(self):
        self.val = 0
        self.avg = 0
        self.sum = 0
        self.count = 0

    def update(self, val, n=1):
        self.val = val
        self.sum += val * n
        self.count += n
        self.avg = self.sum / self.count


def accuracy(output, target, topk=(1, )):
    """Computes the accuracy over the k top predictions for the specified values of k"""
    with torch.no_grad():
        maxk = max(topk)
        batch_size = target.size(0)

        _, pred = output.topk(maxk, 1, True, True)
        pred = pred.t()
        correct = pred.eq(target.view(1, -1).expand_as(pred))

        res = []
        for k in topk:
            correct_k = correct[:k].contiguous().view(-1).float().sum(0, keepdim=True)
            res.append(correct_k.mul_(100.0 / batch_size))

        return res[0], res[1]


def main():
    trainloader, testloader = load_dataset()
    model = load_model()
    model.cuda()

    model.eval()
    Acc1, Acc5 = validate(testloader, model)
    print("the bftrain TOP1 acc is", Acc1)
    print("the bftrain TOP5 acc is", Acc5)




    model.train()
    optimizer = inq.SGD(model.parameters(), lr=0.0001, momentum=0.9, weight_bits=4)
    scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=300, gamma=0.1, last_epoch=-1)
    inq_scheduler = inq.INQScheduler(optimizer, [0.2, 0.4, 0.6, 0.8, 1.0], strategy="pruning")

    epochs = 4
    for inq_step in range(4):
        inq.reset_lr_scheduler(scheduler)
        inq_scheduler.step()
        for epoch in range(epochs):
            acc1, acc5 = train(trainloader, testloader, model, optimizer, epoch, inq_step)

    inq_scheduler.step()

    model.eval()
    Acc1, Acc5 = validate(testloader, model)

    print("the TOP1 acc is", Acc1)
    print("the TOP5 acc is", Acc5)
    torch.save(model.state_dict(), './q_0.934_204_pkps.pth')

def model_eval():
    trainloader, testloader = load_dataset()
    model = network.build_network()
    model.load_state_dict(torch.load('./q_0.938_466_BWN.pth'))
    model.cuda()

    model.eval()
    summary(model, (1, 3600), device='cuda')
    Acc1, Acc5 = validate(testloader, model)

    print("the TOP1 acc is", Acc1)
    print("the TOP5 acc is", Acc5)


if __name__ == '__main__':
    model_eval()
