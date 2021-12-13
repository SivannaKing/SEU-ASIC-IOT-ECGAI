from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

import argparse
import json
from tensorflow import keras

import os
import numpy as np
import h5py
import warnings
import json
import time

import network
import load
import keras_2_qkeras

warnings.filterwarnings("ignore")
os.environ["CUDA_VISIBLE_DEVICES"] = "3"


# use by function correct_quant
# make sure quantize in right bit wide
# recorrect some error : quantization bit wide bigger than quantization_distribution
# write weight with right quantization bit wide
# f : h5 weight value
# MINUNIT : min unit , like 0.0000 0001
def correct_layer(f, MINUNIT):
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
    f = weight  # write new weight


# use by function evaluate
# make sure quantize in right bit wide
# recorrect some error : quantization bit wide bigger than quantization_distribution
# write weight with right quantization bit wide
def correct_quant(qmodel_path, quantization_distribution):
    # calculate the min unit of quantization bit wide
    MINUNIT = []
    for i in range(len(quantization_distribution)):
        MINUNIT.append(0.00390625 * 2 ** (8 - quantization_distribution[i]))  # 0.00390625 DEC = 0.0000 0001 BIN

    # recorrect quantization bit wide
    if os.path.exists(qmodel_path):
        with h5py.File(qmodel_path, 'a') as f:  # a : write mode
            # conv 6 kernel 0 bias
            # dense 1 kernel 1 bias
            # h5 file struct
            # Qkeras_8bit_model.h5 -> conv1  -> conv1  -> kernel: 0 -> weight
            #                      -> conv2  -> conv2  -> kernel: 0 -> weight
            #                      -> conv3  -> conv3  -> kernel: 0 -> weight
            #                      -> conv4  -> conv4  -> kernel: 0 -> weight
            #                      -> conv5  -> conv5  -> kernel: 0 -> weight
            #                      -> conv6  -> conv6  -> kernel: 0 -> weight
            #                      -> Dense1 -> Dense1 -> kernel: 0 -> weight
            #                                          -> bias: 0   -> weight

            correct_layer(f['conv1']['conv1']['kernel:0'], MINUNIT[0])
            correct_layer(f['conv2']['conv2']['kernel:0'], MINUNIT[1])
            correct_layer(f['conv3']['conv3']['kernel:0'], MINUNIT[2])
            correct_layer(f['conv4']['conv4']['kernel:0'], MINUNIT[3])
            correct_layer(f['conv5']['conv5']['kernel:0'], MINUNIT[4])
            correct_layer(f['conv6']['conv6']['kernel:0'], MINUNIT[5])
            correct_layer(f['Dense1']['Dense1']['kernel:0'], MINUNIT[6])
            correct_layer(f['Dense1']['Dense1']['bias:0'], MINUNIT[6])
            # kernel and bias should be same bit wide


# use by function converter
# find the absmax weights in Qkeras_8bit_model of each layer
# qmodel_path : path of Qkeras_8bit_model
# return : list of absmax weights of each layer (exist Qkeras_8bit_model)
# return : [] (NO exist Qkeras_8bit_model)
def find_absmax_weight(qmodel_path):
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
            weight_list.append(np.array(f['Dense1']['Dense1']['kernel:0'])
                               + np.array(f['Dense1']['Dense1']['bias:0']))

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


# use by function evaluate
# find the file size of qmodel
# size += NumWeight * bit_wide
# bit_wide_list : quantization distribution
# return : qmodel size (kB)
def getsize(qmodel, bit_wide_list):
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


# use by main
# converter keras model to qkeras model
# evaluate acc size of different quantization distribution
# record in log file
def evaluate(dev_x, dev_y, params):
    # read config from config.json
    quantization_distribution = list(params.get("quantization_distribution"))
    quantization_distribution = list(map(int, quantization_distribution))
    params.update({"input_shape": [3600, 1]})
    batch_size = params.get("batch_size", 32)

    # set path
    model_path = params.get("model_dir")
    # two different mode : correct or not correct wrong quantization bit wide
    if params.get("recorrect"):
        qmodel_8bit_path = params.get("qkeras_8bit_model_dir")[:-3] + "-rc.h5"
        qmodel_path = params.get("qkeras_model_dir")[:-3] + "-rc.h5"
        log_path = params.get("log_file_dir") + "-rc"
    else:
        qmodel_8bit_path = params.get("qkeras_8bit_model_dir")
        qmodel_path = params.get("qkeras_model_dir")
        log_path = params.get("log_file_dir")

    # converter
    if not os.path.exists(qmodel_8bit_path):
        # converter keras to 8-bits qkeras model
        keras_2_qkeras.converter(model_path,
                                 qmodel_8bit_path,
                                 quantization_distribution,
                                 find_absmax_weight(qmodel_8bit_path))
        # load model struct
        qmodel = network.build_network(**params)
        if params.get("recorrect"):
            correct_quant(qmodel_8bit_path, quantization_distribution)
        # load model weight
        qmodel.load_weights(qmodel_8bit_path)

    else:
        # converter keras 2 qkeras model
        keras_2_qkeras.converter(model_path,
                                 qmodel_path,
                                 quantization_distribution,
                                 find_absmax_weight(qmodel_8bit_path))
        # load model
        qmodel = network.build_network(**params)
        if params.get("recorrect"):
            correct_quant(qmodel_path, quantization_distribution)
        qmodel.load_weights(qmodel_path)

    qmodel.summary()

    # evaluate model
    loss, q_dev_score = qmodel.evaluate(dev_x, dev_y, batch_size=batch_size, verbose=1)
    model = keras.models.load_model(model_path)
    loss, dev_score = model.evaluate(dev_x, dev_y, batch_size=batch_size, verbose=1)

    print('FP32 model acc:', dev_score)
    print('quantization_distribution:', quantization_distribution)
    print('Qkeras model acc:', q_dev_score)
    print('Qkeras model size:', getsize(qmodel, quantization_distribution), 'kB')

    # save score in log file

    if not os.path.exists(log_path):
        with open('./config.json', 'r') as j:
            config_setting = json.load(j)
        with open(log_path, 'a') as f:
            f.write(str(time.asctime(time.localtime(time.time()))) + '\n')
            for key, value in config_setting.items():
                f.write(str(key) + ':' + str(value) + '\n')
            f.write('\nquantization_distribution' + '\t'
                    + 'FP32 acc' + '\t'
                    + 'qkeras model acc' + '\t'
                    + 'FP32 acc - qkeras model acc' + '\t'
                    + 'size(kB)' + '\n')
    with open(log_path, 'a') as f:
        f.write(str(quantization_distribution) + '\t\t\t'
                + str(round(dev_score * 100, 2)) + '\t\t'
                + str(round(q_dev_score * 100, 2)) + '\t\t\t'
                + str(round((dev_score - q_dev_score) * 100, 2)) + '\t\t\t\t'
                + str(round(getsize(qmodel, quantization_distribution), 2)) + '\t\n')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))

    print("Loading training set...")
    train = load.load_dataset(params['train'])
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    dev_x, dev_y = preproc.process(*dev)
    train_x, train_y = preproc.process(*train)

    evaluate(dev_x, dev_y, params)
