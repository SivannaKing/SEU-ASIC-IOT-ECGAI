#!/usr/bin/env python
# coding: utf-8

# CalcShannonEnt is used to calculate entropy of each layer
# Ranking is used to rank the importance of each layer

from __future__ import print_function
from __future__ import division
from __future__ import absolute_import


import h5py
import numpy as np
from math import log
from sklearn import preprocessing


def cal_entropy(dataset):
    data = len(dataset)                                                         # number
    counter = {}                                                                # frequency of each class
    for featVec in dataset:
        label = featVec[-1]                                                     # 该样本的标签
        if label not in counter.keys(): counter[label] = 0
        counter[label] += 1
    entropy = 0.0
    for key in counter:
        prob = float(counter[key])/data                                         # calculate probability
        entropy -= prob * log(prob, 2)  # log base 2
    return entropy


def ranking(params, ratio=0.5):

    layers = {"conv1d_1": '/conv1d_1/conv1d_1_1/kernel:0',
              "conv1d_2": '/conv1d_2/conv1d_2_1/kernel:0',
              "conv1d_3": '/conv1d_3/conv1d_3_1/kernel:0',
              "conv1d_4": '/conv1d_4/conv1d_4_1/kernel:0',
              "conv1d_5": '/conv1d_5/conv1d_5_1/kernel:0',
              "conv1d_6": '/conv1d_6/conv1d_6_1/kernel:0',
              "conv1d_7": '/conv1d_7/conv1d_7_1/kernel:0',
              "dense_1": '/dense_1/dense_1_1/kernel:0',
              "dense_2": '/dense_2/dense_2_1/kernel:0'}
    energy = {"conv1d_1": 1,  # changed from 2
              "conv1d_2": 1,
              "conv1d_3": 2,
              "conv1d_4": 5,
              "conv1d_5": 3,
              "conv1d_6": 1,
              "conv1d_7": 0,
              "dense_1": 0,
              "dense_2": 0}

    Ent = []
    Abs = []
    Abs_Max = []
    Ene = []

    min_max_scaler = preprocessing.MinMaxScaler()
    
    # ----------------------------Scoring---------------------------
    with h5py.File(params["eight_bit_model_dir"], 'r') as f:

        for layer in layers:

            weight = f[layers[layer]].value
            weight = weight.reshape((-1, 1))
            abs_maximum = np.average(np.max(np.abs(weight)))
            abs_mean = np.average(np.abs(weight))
            entropy = cal_entropy(weight)
            Ent.append(entropy)
            Abs.append(abs_mean)
            Abs_Max.append(abs_maximum)
            Ene.append(energy[layer])

    _ent = np.array(Ent).reshape((-1, 1))
    _abs = np.array(Abs).reshape((-1, 1))
    _max = np.array(Abs_Max).reshape((-1, 1)).squeeze()

    _Ent = min_max_scaler.fit_transform(_ent)
    _Abs = min_max_scaler.fit_transform(_abs)

    score = (ratio * _Ent + (1-ratio) * _Abs).squeeze().tolist()  # get score

    # ----------------------------Ranking--------------------------
    rank = zip(layers.keys(), score, _max, Ene)
    rank = sorted(rank, key=lambda x: x[1], reverse=params["ranking_reverse"])

    rank, normalized_score, maximum, ene = zip(*rank)
    print("Ranking of Layer...")
    for index, layer in enumerate(rank):
        print("{}'s\t entropy is {:.3f}\t maximum is {:.3f}\t energy is {}".format(
            layer, normalized_score[index], maximum[index], ene[index]))

    return rank, normalized_score, maximum, ene
