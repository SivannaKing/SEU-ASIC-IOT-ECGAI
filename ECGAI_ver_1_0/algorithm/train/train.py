from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

import argparse
import json
import keras
import os
import random
import time

import network
import load
import util

# wzx
from keras.models import load_model
from keras import backend as K
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt

os.environ["CUDA_VISIBLE_DEVICES"] = "0"


def get_filename_for_saving(save_dir):
    return os.path.join(save_dir,
                        "{val_accuracy:.3f}_{val_loss:.3f}_{epoch:03d}_{loss:.3f}_{accuracy:.3f}.hdf5")


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


def train(args, params):
    print("Loading training set...")
    train = load.load_dataset(params['train'])
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*train)
    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")

    save_dir = make_save_dir(params['save_dir'])
    log_save = make_log_dir(params['log_dir'])

    util.save(preproc, save_dir)

    params.update({
        "input_shape": [3600, 1],
        "num_categories": len(preproc.classes)
    })

    batch_size = params.get("batch_size", 32)
    model = network.build_network(**params)
    model.summary()
    stopping = keras.callbacks.EarlyStopping(patience=1000)
    logs = keras.callbacks.TensorBoard(log_dir=log_save, histogram_freq=100, batch_size=batch_size)

    reduce_lr = keras.callbacks.ReduceLROnPlateau(
        factor=0.1,
        patience=400,
        min_lr=params["learning_rate"] * 0.001)

    checkpointer = keras.callbacks.ModelCheckpoint(
        filepath=get_filename_for_saving(save_dir),
        monitor='val_accuracy',
        save_best_only=True)

    if params.get("generator", False):
        print("generator=True")
        train_gen = load.data_generator(batch_size, preproc, *train)
        dev_gen = load.data_generator(batch_size, preproc, *dev)
        model.fit_generator(
            train_gen,
            steps_per_epoch=int(len(train[0]) / batch_size),
            epochs=params["MAX_EPOCHS"],
            validation_data=dev_gen,
            validation_steps=int(len(dev[0]) / batch_size),
            callbacks=[reduce_lr, stopping, checkpointer])
    else:
        print("g-enerator=False")
        train_x, train_y = preproc.process(*train)
        train_x, train_y = load.data_shuffle(train_x, train_y, **params)
        dev_x, dev_y = preproc.process(*dev)

        model.fit(
            train_x, train_y,
            batch_size=batch_size,
            epochs=params["MAX_EPOCHS"],
            validation_data=(dev_x, dev_y),
            callbacks=[reduce_lr, stopping, logs, checkpointer])
        model.save('/home/wzx/ECGAI/layer-wise-quantization/model/wzx_model_16.hdf5')


# wzx
def layers_outputs(args, params):

    print("Loading training set...")
    train = load.load_dataset(params['train'])

    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])

    print("Building preprocessor...")
    preproc = load.Preproc(*train)

    print("Training size: " + str(len(train[0])) + " examples.")
    print("Dev size: " + str(len(dev[0])) + " examples.")

    save_dir = make_save_dir(params['save_dir'])
    log_save = make_log_dir(params['log_dir'])

    util.save(preproc, save_dir)

    params.update({
        "input_shape": [3600, 1],
        "num_categories": len(preproc.classes)
    })

    train_x, train_y = preproc.process(*train)
    train_x, train_y = load.data_shuffle(train_x, train_y, **params)

    print('counting num of > 8 16 32...')
    model = load_model('/home/wzx/ECGAI/layer-wise-quantization/model/wzx_model_16.hdf5')  # replaced by your model name

    # put into df
    record_arr = np.array(['0', 0, 0, 0, 0])

    for i in range(1, 28):
        print('calculating on the outputs of No.', i, ' layer')

        # get the layer_outputs
        layer = K.function([model.layers[0].input], [model.layers[i].output])
        layer_arr = layer([train_x])[0]

        # save the layer_outputs
        if not os.path.exists('./wzx_model_16_layer_output'):
            os.makedirs('./wzx_model_16_layer_output')
        np.save('./wzx_model_16_layer_output/layer_{}.npy'.format(i), layer_arr)

        # name
        layer_name = model.layers[i].name
        # max & min
        layer_outputs_max = np.max(layer_arr)
        layer_outputs_min = np.min(layer_arr)
        # num of negative
        num_neg = np.sum(layer_arr < 0)
        # absmax
        absmax = max(abs(layer_outputs_max), abs(layer_outputs_min))

        new_row = np.array([layer_name, layer_outputs_max, layer_outputs_min, num_neg, absmax])
        record_arr = np.row_stack((record_arr, new_row))

    record_df = pd.DataFrame(record_arr, columns=["name", "max", "min", "num_neg", "absmax"])

    print(record_df.loc[:, ["name", "num_neg", "absmax"]])


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    parser.add_argument("--experiment", "-e", help="tag with experiment name", default="default")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))
    # train(args, params)
    layers_outputs(args, params)
