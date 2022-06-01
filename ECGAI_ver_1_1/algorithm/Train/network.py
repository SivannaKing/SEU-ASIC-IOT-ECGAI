#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     李支青;吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2020/06/01 - create - 李支青
            build basic model
            2021/03/21 - modify - 吴中行
            change model and params
@FUNC       build a CNN network
'''
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Conv1D, MaxPooling1D, GlobalAveragePooling1D
from tensorflow.keras.layers import Dense, Dropout, Input, ReLU


def build_new_network(inputs):
    '''
    build base nn

    Args:
        inputs:

    Returns:
        layer: outputs
    '''
    # block 1
    layer = Conv1D(8,
                   16,
                   strides=2,
                   padding='valid',
                   use_bias=False,
                   name='conv1')(inputs)
    layer = ReLU(max_value=2, name='act1')(layer)
    layer = MaxPooling1D(pool_size=7, strides=2, name='mp1')(layer)
    # block 2
    layer = Conv1D(16,
                   12,
                   strides=2,
                   padding='valid',
                   use_bias=False,
                   name='conv2')(layer)
    layer = ReLU(max_value=2, name='act2')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp2')(layer)
    # block 3
    layer = Conv1D(32,
                   8,
                   strides=1,
                   padding='valid',
                   use_bias=False,
                   name='conv3')(layer)
    layer = ReLU(max_value=2, name='act3')(layer)
    layer = MaxPooling1D(pool_size=5, strides=2, name='mp3')(layer)
    # block 4
    layer = Conv1D(64,
                   8,
                   strides=1,
                   padding='valid',
                   use_bias=False,
                   name='conv4')(layer)
    layer = ReLU(max_value=2, name='act4')(layer)
    layer = MaxPooling1D(pool_size=4, strides=2, name='mp4')(layer)
    # block 5
    layer = Conv1D(64,
                   4,
                   strides=1,
                   padding='valid',
                   use_bias=False,
                   name='conv5')(layer)
    layer = ReLU(max_value=2, name='act5')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp5')(layer)
    # block 6
    layer = Conv1D(72,
                   3,
                   strides=1,
                   padding='valid',
                   use_bias=False,
                   name='conv6')(layer)
    layer = ReLU(max_value=2, name='act6')(layer)
    layer = MaxPooling1D(pool_size=2, strides=2, name='mp6')(layer)
    return layer


def add_fc_layers(layer, **params):
    '''
    build fc layers

    Args:
        layer: inputs

    Returns:
        layer: outputs
    '''
    layer = Dropout(0.6, name='Dropout1')(layer)
    layer = GlobalAveragePooling1D(name='GAP')(layer)
    if params.get("dropout", 0.1):
        layer = Dropout(params["dropout"], name='Dropout2')(layer)
    layer = Dense(params["num_categories"],
                  activation='softmax',
                  name='Dense1')(layer)
    return layer


def add_compile(model, **params):
    '''
    set model optimizer and compile

    Args:
        model:
    '''
    optimizer = Adam(lr=params["learning_rate"])
    model.compile(loss='categorical_crossentropy',
                  optimizer=optimizer,
                  metrics=['accuracy'])


def build_network(**params):
    '''
    buid CNN network(base nn + fc layers)
    Returns:
        model:
    '''
    inputs = Input(shape=params['input_shape'], dtype='float32', name='inputs')
    layer = build_new_network(inputs)
    output = add_fc_layers(layer, **params)
    model = Model(inputs=[inputs], outputs=[output])
    add_compile(model, **params)
    return model
