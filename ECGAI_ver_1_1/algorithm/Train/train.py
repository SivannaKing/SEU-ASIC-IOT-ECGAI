# run in conda env tf22
from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

from tensorflow import keras

import argparse
import json
import os
import time
import warnings

import network
import load
import util


# os.environ["CUDA_VISIBLE_DEVICES"] = "0"


def get_filename_for_saving(save_dir):
    return os.path.join(save_dir, "{val_accuracy:.3f}_{epoch:03d}_{accuracy:.3f}.hdf5")


def make_save_dir(dirname):
    start_time = str(time.asctime(time.localtime(time.time())))
    save_dir = os.path.join(dirname, start_time)
    if not os.path.exists(save_dir):
        os.makedirs(save_dir)
    return save_dir


def make_log_dir(dirname):
    start_time = str(time.asctime(time.localtime(time.time())))
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

    model = network.build_network(**params)
    model.summary()
    input("wait")

    stopping = keras.callbacks.EarlyStopping(patience=1000)
    batch_size = params.get("batch_size", 32)
    logs = keras.callbacks.TensorBoard(log_dir=log_save, histogram_freq=100, batch_size=batch_size)

    reduce_lr = keras.callbacks.ReduceLROnPlateau(
        factor=0.1,
        patience=params["patience"],
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
        print("generator=False")
        train_x, train_y = preproc.process(*train)
        train_x, train_y = load.data_shuffle(train_x, train_y, **params)
        dev_x, dev_y = preproc.process(*dev)

        model.fit(
            train_x, train_y,
            batch_size=batch_size,
            epochs=params["MAX_EPOCHS"],
            verbose=1,  # 1 normal 0 hide log
            validation_data=(dev_x, dev_y),
            callbacks=[reduce_lr, stopping, logs, checkpointer])


if __name__ == '__main__':
    warnings.filterwarnings('ignore')
    os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    parser.add_argument("--experiment", "-e", help="tag with experiment name", default="default")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))
    train(args, params)
