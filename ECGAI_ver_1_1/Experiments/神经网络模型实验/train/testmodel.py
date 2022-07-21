from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

import argparse
import json
import keras
import os
import random
import time
import numpy as np
import pandas as pd
import tqdm
import load
import util

from keras.models import load_model
from keras import Model
from keras import backend as K


os.environ["CUDA_VISIBLE_DEVICES"] = "0"


def get_filename_for_saving(save_dir):
    return os.path.join(save_dir, "{val_accuracy:.3f}_{epoch:03d}.hdf5")


def make_save_dir(dirname):
    start_time = str(int(time.time())) + '-' + str(random.randrange(1000))
    save_dir = os.path.join(dirname, start_time)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    return save_dir


def make_log_dir(dirname):
    start_time = str(int(time.time())) + '-' + str(random.randrange(1000))
    save_dir = os.path.join(dirname, start_time)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    return save_dir


def ReadDatasets(data_json):
    with open(data_json, 'r') as fid:
        data = [json.loads(l) for l in fid]
    labels = []
    dirs = []
    for d in tqdm.tqdm(data, ncols=100):
        labels.append(d['label'])  # [[sample1], [sample2], ...]
        dirs.append(d['samp_dir'])
    return dirs, labels



# wzx
def predict_func(args, params):
    print("Loading training set...")
    train = load.load_dataset(params['train'])
    train_dirs, train_labels = ReadDatasets(params['train'])
    print("Building preprocessor...")
    preproc = load.Preproc(*train)

    print("Training size: " + str(len(train[0])) + " examples.")

    train_x, train_y = preproc.process(*train)
    # train_x, train_y = load.data_shuffle(train_x, train_y, **params)

    model = load_model('/home/wzx/ECGAI/layer-wise-quantization/model/wzx_model20_46(1).hdf5')  # replaced by your model name
    prediction = model.predict(train_x)
    record_arr = np.array(['0', 0, 0, 0])
    for i in np.random.randint(0, 2000, 10):
        # part of dir
        # train_labels != train_y (sort)
        new_row = np.array([train_dirs[i][45:], train_labels[i], np.argmax(prediction[i]), np.argmax(train_y[i])])
        record_arr = np.row_stack((record_arr, new_row))

    predict_df = pd.DataFrame(record_arr, columns=["dir", "label", "predict", "label"])
    print(predict_df)

    predata_index = train_dirs.index("/home/wzx/ECGAI/layer-wise-quantization/MLII/1 NSR/100m (1).mat")
    print(predata_index)

    # conv1
    intermediate_layer_model_1 = Model(inputs=model.input, outputs=model.get_layer('conv1').output)  # 你创建新的模型
    # 这个新的模型截取了原始模型中从输入到某个层（你想要得到结果的那一层）的一部分，
    intermediate_output_1 = intermediate_layer_model_1.predict(train_x)  # 这个数据就是原始模型的输入数据
    sz = intermediate_output_1[predata_index]
    sz = sz.tolist()
    for i in range(len(sz)):
        for j in range(len(sz[i])):
            sz[i][j] = dec2bin(round(sz[i][j] * 2 ** 5), 8)
        with open('/home/wzx/ECGAI/conv1.txt', 'a') as f:
            f.write(str(sz[i]) + '\n')

    # maxpooling1
    intermediate_layer_model_2 = Model(inputs=model.input, outputs=model.get_layer('mp1').output)  # 你创建新的模型
    # 这个新的模型截取了原始模型中从输入到某个层（你想要得到结果的那一层）的一部分，
    intermediate_output_2 = intermediate_layer_model_2.predict(train_x)  # 这个数据就是原始模型的输入数据
    sz2 = intermediate_output_2[predata_index]
    sz2 = sz2.tolist()
    for i in range(len(sz2)):
        for j in range(len(sz2[i])):
            sz2[i][j] = dec2bin(round(sz2[i][j] * 2 ** 5), 8)
        with open('/home/wzx/ECGAI/mp1.txt', 'a') as f:
            f.write(str(sz2[i]) + '\n')






def dec2bin(dec_num, bit_wide=16):
    _, bin_num_abs = bin(dec_num).split('b')
    if len(bin_num_abs) > bit_wide:
        raise ValueError           # 数值超出bit_wide长度所能表示的范围
    else:
        if dec_num >= 0:
            bin_num = bin_num_abs.rjust(bit_wide, '0')
        else:
            bin_num = bin_num_abs.rjust(bit_wide, '0')
            bin_num = '1' + bin_num[1:]
    return bin_num


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    parser.add_argument("--experiment", "-e", help="tag with experiment name", default="default")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))
    predict_func(args, params)

