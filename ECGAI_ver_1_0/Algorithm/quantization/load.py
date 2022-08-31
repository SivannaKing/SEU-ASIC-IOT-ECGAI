import json
import numpy as np
import os
import random
import scipy.io as sio
import tqdm
from sklearn.preprocessing import LabelBinarizer
from sklearn.utils import shuffle
lb = LabelBinarizer()


def data_generator(batch_size, preproc, x, y):
    num_examples = len(x)
    examples = zip(x, y)
    examples = sorted(examples, key=lambda x: x[0].shape[0])
    end = num_examples - batch_size + 1
    batches = [examples[i:i+batch_size] for i in range(0, end, batch_size)]
    random.shuffle(batches)
    while True:
        for batch in batches:
            x, y = zip(*batch)
            yield preproc.process(x, y)


def data_shuffle(x, y, **params):
    if params.get("shuffle", False):
        x, y = shuffle(x, y)
        return x, y
    else:
        return x, y


class Preproc:
    def __init__(self, ecg, labels):
        self.mean, self.std = compute_mean_std(ecg)            # return mean and std of all of the data
        self.classes = sorted(set(label for label in labels))
        self.int_to_class = dict(zip(range(len(self.classes)), self.classes))
        self.class_to_int = {c: i for i, c in self.int_to_class.items()}

    def process(self, x, y):
        print(self.int_to_class)
        return self.process_x(x), self.process_y(y)

    def process_x(self, x):
        x = (x - self.mean) / self.std
        x = x[:, :, None]
        # print(x.shape)
        return x

    def process_y(self, y):
        y = lb.fit_transform(y)
        # print(type(y))
        return y


def compute_mean_std(x):
    x = np.hstack(x)
    # print(x.shape)
    return (np.mean(x).astype(np.float32),
            np.std(x).astype(np.float32))


# return labels and ecg signal with length of step times
def load_dataset(data_json):
    with open(data_json, 'r') as fid:
        data = [json.loads(l) for l in fid]
    labels = []
    ecgs = []
    for d in tqdm.tqdm(data, ncols=100):
        labels.append(d['label'])  # [[sample1], [sample2], ...]
        ecgs.append(load_ecg(d['samp_dir']))
    return ecgs, labels


def load_ecg(record):
    if os.path.splitext(record)[1] == ".npy":
        ecg = np.load(record)
    elif os.path.splitext(record)[1] == ".mat":
        ecg = sio.loadmat(record)['val'].squeeze()
    else:
        print('FileError: No mat and npy file')
    return ecg   # return a np.array with the size of times of ecg signal


if __name__ == "__main__":
    data_json = "./train.json"
    train = load_dataset(data_json)
    preproc = Preproc(*train)
    gen = data_generator(32, preproc, *train)
    for x, y in gen:
        print(x.shape, y.shape)
        break
