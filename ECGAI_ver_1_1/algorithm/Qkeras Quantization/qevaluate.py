#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/06/06 - create - 吴中行
            create basic function
            2022/06/06 - modify - 吴中行
            remove recorrect and find_absmax_weight
@FUNC       transfer keras model to qkeras model
            FP32 -> 8bit(sign, integer, decimal)
 TODO       结合自动分层量化脚本
'''
from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

import os
import time
import argparse
import json
import warnings

from tensorflow import keras
import numpy as np
import h5py

import network
import load
import keras_2_qkeras
from evaluate import eval_model

warnings.filterwarnings("ignore")
# os.environ["CUDA_VISIBLE_DEVICES"] = "3"


def correct_layer(f, MINUNIT):
    """make sure quantize in right bit wide
    write weight with right quantization bit wide
    used by function correct_quant

    Args:
        f (.h5): weight value
        MINUNIT (_type_): min unit , like 0.0000 0001
    """
    weight = f
    del f  # delete old weight first
    for index, element in np.ndenumerate(weight):
        if element % MINUNIT != 0:
            # eg. 0.124999999 ==> 0.125
            if (element - element // MINUNIT * MINUNIT) >= MINUNIT / 2:
                weight[index] = (element // MINUNIT + 1) * MINUNIT
            else:
                weight[index] = element // MINUNIT * MINUNIT
            # print(element, weight[index])
    # f = weight  # write new weight


def correct_quant(qmodel_path, quantization_distribution):
    """make sure quantize in right bit wide
    recorrect some error : quantization bit wide bigger than quantization_distribution
    write weight with right quantization bit wide
    used by function evaluate

    Args:
        qmodel_path (_type_): _description_
        quantization_distribution (_type_): _description_
    """
    # calculate the min unit of quantization bit wide
    MINUNIT = []
    for i in range(len(quantization_distribution)):
        MINUNIT.append(0.00390625 * 2**(8 - quantization_distribution[i])
                       )  # 0.00390625 DEC = 0.0000 0001 BIN

    # recorrect quantization bit wide
    if os.path.exists(qmodel_path):
        with h5py.File(qmodel_path, 'a') as f:  # a : write mode
            '''
            conv 6 kernel 0 bias
            dense 1 kernel 1 bias
            h5 file struct
            Qkeras_8bit_model.h5 -> conv1  -> conv1  -> kernel: 0 -> weight
                                 -> conv2  -> conv2  -> kernel: 0 -> weight
                                 -> conv3  -> conv3  -> kernel: 0 -> weight
                                 -> conv4  -> conv4  -> kernel: 0 -> weight
                                 -> conv5  -> conv5  -> kernel: 0 -> weight
                                 -> conv6  -> conv6  -> kernel: 0 -> weight
                                 -> Dense1 -> Dense1 -> kernel: 0 -> weight
                                                     -> bias: 0   -> weight
            '''
            correct_layer(f['conv1']['conv1']['kernel:0'], MINUNIT[0])
            correct_layer(f['conv2']['conv2']['kernel:0'], MINUNIT[1])
            correct_layer(f['conv3']['conv3']['kernel:0'], MINUNIT[2])
            correct_layer(f['conv4']['conv4']['kernel:0'], MINUNIT[3])
            correct_layer(f['conv5']['conv5']['kernel:0'], MINUNIT[4])
            correct_layer(f['conv6']['conv6']['kernel:0'], MINUNIT[5])
            correct_layer(f['Dense1']['Dense1']['kernel:0'], MINUNIT[6])
            correct_layer(f['Dense1']['Dense1']['bias:0'], MINUNIT[6])
            # kernel and bias should be same bit wide


def find_absmax_weight(qmodel_path):
    """find the absmax weights in Qkeras_8bit_model of each layer

    Args:
        qmodel_path (_type_): path of Qkeras_8bit_model

    Returns:
        []: list of absmax weights of each layer
    """
    absmax_weight_list = []
    weight_list = []

    if os.path.exists(qmodel_path):
        with h5py.File(qmodel_path, 'r') as f:  # read only mode
            weight_list.append(np.array(f['conv1']['conv1']['kernel:0']))
            weight_list.append(np.array(f['conv2']['conv2']['kernel:0']))
            weight_list.append(np.array(f['conv3']['conv3']['kernel:0']))
            weight_list.append(np.array(f['conv4']['conv4']['kernel:0']))
            weight_list.append(np.array(f['conv5']['conv5']['kernel:0']))
            weight_list.append(np.array(f['conv6']['conv6']['kernel:0']))
            # add 2 array to find the absmax both in kernel and bias
            weight_list.append(
                np.array(f['Dense1']['Dense1']['kernel:0']) +
                np.array(f['Dense1']['Dense1']['bias:0']))

        for weight in weight_list:
            maxweight = 0
            for index, element in np.ndenumerate(weight):
                if element >= maxweight:
                    maxweight = element
            absmax_weight_list.append(maxweight)

    else:
        print('NO 8bits model!')
    print(absmax_weight_list)
    # input('this is absmax weight list')
    return absmax_weight_list


def getsize(qmodel, bit_wide_list):
    """find the file size of qmodel
    size += NumWeight * bit_wide

    Args:
        qmodel (_type_): _description_
        bit_wide_list (_type_): quantization distribution

    Returns:
        _type_: qmodel size (kB)
    """
    NumWeight = []  # num of weights of each layers
    size = 0

    for layer in qmodel.layers:
        layer_size = 0
        Weight = layer.get_weights()
        if not Weight:  # skip empty layer
            continue
        else:
            for i in range(len(Weight)):  # layer have kernel and bias weights
                Weight[i] = np.array(Weight[i])
                layer_size += Weight[i].size

        NumWeight.append(layer_size)

    # print('layers NumWeight:', NumWeight)

    if len(NumWeight) == len(bit_wide_list):
        for i in range(len(NumWeight)):
            size += NumWeight[i] * bit_wide_list[i]
    size = size / (1024 * 8)  # 1kB = 1024Bytes = 8kb = 8*1024 bits
    return size


def qevaluate(dev_x, dev_y, params):
    """quantize and evaluate model
    evaluate acc size of different quantization distribution
    record in log file

    Args:
        dev_x (_type_): test data in json
        dev_y (_type_): test labels in json
        params (_type_): args in config.json
    """
    # read config from config.json
    quantization_distribution = list(params.get("quantization_distribution"))
    quantization_distribution = list(map(int, quantization_distribution))

    # set path
    model_path = params.get("model_dir")
    '''remove recorrect part
    # two different mode : correct or not correct wrong quantization bit wide
    if params.get("recorrect"):
        qmodel_8bit_path = params.get("qkeras_8bit_model_dir")[:-3] + "-rc.h5"
        qmodel_path = params.get("qkeras_model_dir")[:-3] + "-rc.h5"
        log_path = params.get("log_file_dir") + "-rc"
    else:
    '''
    qmodel_path = params.get("qkeras_model_dir")
    log_path = params.get("log_file_dir")

    # converter
    model = keras.models.load_model(model_path)
    # converter keras to qkeras model
    keras_2_qkeras.converter(model, qmodel_path, quantization_distribution)
    qmodel = network.build_network(**params)  # load model struct
    '''remove recorrect part
    if params.get("recorrect"):
        correct_quant(qmodel_8bit_path, quantization_distribution)
    '''
    qmodel.load_weights(qmodel_path)  # load model weight
    qmodel.summary()

    # evaluate model
    loss, dev_score = eval_model(model, dev_x, dev_y)
    loss, q_dev_score = eval_model(qmodel, dev_x, dev_y)
    print('FP32 model acc:', dev_score)
    print('quantization_distribution:', quantization_distribution)
    print('Qkeras model acc:', q_dev_score)
    print('Qkeras model size:', getsize(qmodel, quantization_distribution),
          'kB')

    # save score in log file
    if not os.path.exists(log_path):
        with open('./config.json', 'r') as j:
            config_setting = json.load(j)
        with open(log_path, 'a') as f:
            f.write(str(time.asctime(time.localtime(time.time()))) + '\n')
            for key, value in config_setting.items():
                f.write(str(key) + ':' + str(value) + '\n')
            f.write('\nquantization_distribution' + '\t' + 'FP32 acc' + '\t' +
                    'qkeras model acc' + '\t' + 'FP32 acc - qkeras model acc' +
                    '\t' + 'size(kB)' + '\n')
    with open(log_path, 'a') as f:
        f.write(
            str(quantization_distribution) + '\t\t\t' +
            str(round(dev_score * 100, 2)) + '\t\t' +
            str(round(q_dev_score * 100, 2)) + '\t\t\t' +
            str(round((dev_score - q_dev_score) * 100, 2)) + '\t\t\t\t' +
            str(round(getsize(qmodel, quantization_distribution), 2)) + '\t\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))

    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*dev)
    dev_x, dev_y = preproc.process(*dev)

    qevaluate(dev_x, dev_y, params)
