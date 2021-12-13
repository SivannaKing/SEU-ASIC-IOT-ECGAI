from __future__ import print_function
from __future__ import division
from __future__ import absolute_import

import argparse
import json
from keras.models import *
import os

import network
import load

os.environ["CUDA_VISIBLE_DEVICES"] = "3"


def train(dev_x, dev_y, params):

    params.update({"input_shape": [3600, 1]})
    batch_size = params.get("batch_size", 32)

    # load model
    model = network.build_network(**params)
    # model.summary()
    # print(params["qmodel_dir"])
    model.load_weights(params["qmodel_dir"], by_name=True)

    loss, dev_score = model.evaluate(dev_x, dev_y, batch_size=batch_size, verbose=1)
    return loss, dev_score


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))

    print("Loading training set...")
    traina = load.load_dataset(params['train'])
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])
    print("Building preprocessor...")
    preproc = load.Preproc(*traina)
    dev_x, dev_y = preproc.process(*dev)
    train_x, train_y = preproc.process(*traina)
    loss, dev_score = train(dev_x, dev_y, params)
    print(loss, dev_score)
