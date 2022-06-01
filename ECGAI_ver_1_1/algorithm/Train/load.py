#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     李支青;
@EMAIL      
@TIME&LOG   2020/06/01 - create
            create basic function
@FUNC       load and preprocess data
'''
import json
import numpy as np
import os
import random
import scipy.io as sio
import tqdm
from sklearn.preprocessing import LabelBinarizer
from sklearn.utils import shuffle


def data_generator(batch_size, preproc, x, y):
    '''
    generator data for batch train

    Args:
        batch_size:
        preproc:
        x: train dataset
        y: labels

    Returns:
        yield train dataset generator
    '''
    num_examples = len(x)
    examples = zip(x, y)
    examples = sorted(examples, key=lambda x: x[0].shape[0])
    end = num_examples - batch_size + 1
    batches = [examples[i:i + batch_size] for i in range(0, end, batch_size)]
    random.shuffle(batches)
    while True:
        for batch in batches:
            x, y = zip(*batch)
            yield preproc.process(x, y)


def data_shuffle(x, y, **params):
    '''
    shuffle data

    Args:
        x: train dataset
        y: labels

    Returns:
        x: train dataset
        y: labels
    '''
    if params.get("shuffle", False):  # default = False
        x, y = shuffle(x, y)
        return x, y
    else:
        return x, y


class Preproc:
    '''
    preprocess data
    '''
    def __init__(self, ecg, labels):
        '''
        some functions and vars in class

        Args:
            ecg: ecg_data
            labels:
        '''
        self.mean, self.std = compute_mean_std(ecg)
        self.classes = sorted(set(label for label in labels))
        self.int_to_class = dict(zip(range(len(self.classes)), self.classes))
        self.class_to_int = {c: i for i, c in self.int_to_class.items()}

    def process(self, x, y):
        '''
        preprocess data

        Args:
            x: ecg data
            y: labels

        Returns:
            x: ecg data
            y: labels
        '''
        return self.process_x(x), self.process_y(y)

    def process_x(self, x):
        '''
        preprocess ecg data with normalization

        Args:
            x: ecg data

        Returns:
            x: ecg data
        '''
        x = (x - self.mean) / self.std
        x = x[:, :, None]
        return x

    def process_y(self, y):
        '''
        preprocess labels to one-hot code
        fit_transform: Fit the data first, find mean, variance, maximum and minimum values, etc and then transform the trainData to realize the standardization and normalization of the data.

        Args:
            y: labels

        Returns:
            y: labels in Binarizer (one-hot)
        '''
        y = LabelBinarizer().fit_transform(y)
        return y


def compute_mean_std(x):
    '''
    compute mean & std of ecg data

    Args:
        x: ecg data

    Returns:
        mean:
        std:
    '''
    x = np.hstack(x)
    return (np.mean(x).astype(np.float32), np.std(x).astype(np.float32))


def load_dataset(data_json):
    '''
    load dataset from .json

    Args:
        data_json: .json path

    Returns:
        ecgs: with length of step times
        labels: with length of step times
    '''
    with open(data_json, 'r') as fid:
        data = [json.loads(l) for l in fid]
    labels = []
    ecgs = []
    for d in tqdm.tqdm(data, ncols=100):
        labels.append(d['label'])  # [[sample1], [sample2], ...]
        ecgs.append(load_ecg(d['samp_dir']))
    return ecgs, labels


def load_ecg(record):
    '''
    load ecg data from .mat

    Args:
        record: ecg data path

    Returns:
        ecg: a np.array with the size of times of ecg signal
    '''
    if os.path.splitext(record)[1] == ".npy":  # get attributes of the file
        ecg = np.load(record)
    elif os.path.splitext(record)[1] == ".mat":
        ecg = sio.loadmat(record)['val'].squeeze()
    else:
        print('FileError: No mat and npy file')
    return ecg


if __name__ == "__main__":
    data_json = "./train.json"
    train = load_dataset(data_json)
    preproc = Preproc(*train)
    gen = data_generator(32, preproc, *train)
    for x, y in gen:
        print(x.shape, y.shape)
        break
