#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/06/02 - create - 吴中行
            create basic functions
@FUNC       evaluate keras model
'''
import os
import argparse
import json

from tensorflow import keras
from tensorflow.keras.models import load_model

import load
import util


def eval_model(model: keras.models, dev_x, dev_y):
    """evaluate keras model

    Args:
        model (keras.models): _description_
        dev_x (_type_): test data
        dev_y (_type_): test labels
    """
    loss, dev_score = model.evaluate(dev_x, dev_y, verbose=1)
    print('model acc:', dev_score)
    print('model loss:', loss)


def evaluate(args, params: json):
    """load and evaluate model

    Args:
        args (_type_): _description_
        params (json): _description_
    """
    save_dir = './saved/2022-05-31-19-26-14'
    model_path = os.path.join(save_dir, '056_0.987_0.914.hdf5')
    print("Loading dev set...")
    dev = load.load_dataset(params['dev'])

    preproc = util.load(save_dir)
    dev_x, dev_y = preproc.process(*dev)

    model = load_model(model_path)
    eval_model(model, dev_x, dev_y)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("config_file", help="path to config file")
    args = parser.parse_args()
    params = json.load(open(args.config_file, 'r'))

    evaluate(args, params)
