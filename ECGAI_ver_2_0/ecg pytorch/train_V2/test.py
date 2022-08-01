import numpy as np
import torch
from torchsummary import summary
import network
import load
from torch.utils.data import DataLoader
from torch.autograd import variable
import logging
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
import sklearn
import matplotlib.pyplot as plt
from torch import nn

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

def validate(val_loader, model):
    global n_iter

    criterion = torch.nn.CrossEntropyLoss()

    # switch to evaluate mode
    model.eval()

    with torch.no_grad():
        for i, (input, target) in enumerate(val_loader):
            target = target.cuda()

            # compute output
            output = model(input)
            loss = criterion(output, target)

            # measure accuracy and record loss
            acc1, acc5 = accuracy(output, target, topk=(1, 5))


    return acc1, acc5

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




def test_model():
    model = network.build_network()
    model.load_state_dict(torch.load('./q_0.938_466.pth'))


    summary(model, (1, 3600), device='cpu')



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
    #testloader = DataLoader(torch_test_data, batch_size=100, shuffle=True, drop_last=False, num_workers=0)

    model.eval()

    logger = get_logger('./logs/exp.log')

    with torch.no_grad():
        model.eval()
        out = model(test_x)
        #print(out.requires_grad)
        accuracy = torch.max(out, 1)[1].cpu().numpy() == torch.max(test_y, 1)[1].cpu().numpy()
        y_pred = torch.max(out, 1)[1].cpu().numpy()
        y_true = torch.max(test_y, 1)[1].cpu().numpy()
        classify_report = sklearn.metrics.classification_report(y_true, y_pred)
        mcm = sklearn.metrics.multilabel_confusion_matrix(y_true, y_pred)
        #print(mcm)
        tp = mcm[:, 1, 1]
        tn = mcm[:, 0, 0]
        fn = mcm[:, 1, 0]
        fp = mcm[:, 0, 1]

        spe = tn/(tn + fp)
        sen = tp/(tp + fn)

        class_num = [85,2,3,3,2,31,19,3,15,18,7,42,4,7,41,17,5]
        class_num = np.asarray(class_num)/304

        spe = np.asarray(spe)
        sen = np.asarray(sen)

        spe = np.sum(class_num*spe)
        sen = np.sum(class_num*sen)

        print("spe = ", spe,"sen = ", sen)


        confusion = confusion_matrix(y_true, y_pred)
        print(classify_report)
        print(confusion)
        print(accuracy.astype(int))

        classes = list(set(y_true))
        plt.imshow(confusion, cmap=plt.cm.Blues)
        indices = range(len(confusion))
        plt.xticks(indices, classes)
        plt.yticks(indices, classes)
        plt.colorbar()
        plt.xlabel('Prediction')
        plt.ylabel('Truth')
        for first_index in range(len(confusion)):
            for second_index in range(len(confusion[first_index])):
                if (confusion[first_index][second_index] >= 80):
                    plt.text(first_index, second_index, confusion[first_index][second_index], va='center', ha='center', color="white")
                else:
                    plt.text(first_index, second_index, confusion[first_index][second_index], va='center', ha='center',
                             color="black")

        plt.show()


    acc = accuracy.mean()
    print('acc = ',acc)
    logger.info('acc={:.3f}'.format(acc))


    return acc


def flops():

    import torch

    from ptflops import get_model_complexity_info


    model = network.build_network()
    model.load_state_dict(torch.load('./0.938_466.pth'))
    model_name = '7_2'
    flops, params = get_model_complexity_info(model, (1, 3600), as_strings=True, print_per_layer_stat=True)
    print("%s |%s |%s" % (model_name, flops, params))


if __name__ == '__main__':
    test_model()
