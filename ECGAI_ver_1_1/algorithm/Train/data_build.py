#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     李支青;吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2020/06/21 - create - 李支青
            create basic functions
            2022/05/01 - modify - 吴中行
            modify path for both Linux & Windows os
@FUNC       build train & dev data in .json from [Dataset]
'''
import os
import random
import json

from sklearn.model_selection import train_test_split


def load_dataset(data_path, args, split_ratio=0.3):
    '''
    load data from [Dataset]
    split data into train & dev
    train data completion

    Args:
        data_path:
        args:
        split_ratio: ratio equals dev/total

    Returns:
        labels: labels in [Dataset]
        tr_samps: train dataset
        te_samps: test dataset
        seed:
    '''
    seed = 32
    labels = []
    tr_samps = []
    te_samps = []

    for root, dirs, files in os.walk(data_path, topdown=False):
        if len(files) == 0:
            continue  # skip folder
        label = os.path.basename(root)
        samps = [os.path.abspath(os.path.join(root, i)) for i in files]
        tr_samp, te_samp = train_test_split(samps,
                                            test_size=split_ratio,
                                            random_state=seed)
        labels.append(label)
        tr_samps.append(tr_samp)
        te_samps.append(te_samp)

    # read the max len of dataset class and complete others
    max_len = 0
    for index, item in enumerate(labels):
        if len(tr_samps[index]) > max_len:
            max_len = len(tr_samps[index])

    for index, i in enumerate(tr_samps):
        repeat = max_len // len(i)
        tr_samps[index] = i * repeat
        print("{}: before_num:{}, after_num:{}".format(labels[index], len(i),
                                                       len(tr_samps[index])))

    return labels, tr_samps, te_samps, seed


def make_json(save_path, labels, dataset):
    '''
    create .json file of train & test dataset

    Args:
        save_path: path of .json file
        labels:
        dataset: train or test dataset

    Releases:
        json file
    '''
    with open(save_path, 'w') as fid:
        for index, label in enumerate(labels):
            for item in dataset[index]:
                datum = {'label': label, 'samp_dir': item}
                json.dump(datum, fid)
                fid.write('\n')


if __name__ == "__main__":
    print("=== get dataset dir ===")
    current_dir = os.getcwd()
    base_dir = current_dir.split('ECGAI_ver_1_1')[0]
    data_dir = os.path.join(base_dir, 'Dataset',
                            '17 Classes ECG signals (1000 fragments)', 'MLII')
    print(data_dir)

    random.seed(2018)
    split_ratio = 0.3

    label, train, test, seed = load_dataset(data_dir, split_ratio)
    make_json("../train_{}.json".format(seed), label, train)
    make_json("../dev_{}.json".format(seed), label, test)
