#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     李支青;
@EMAIL      
@TIME&LOG   2020/06/01 - create
            create basic functions
@FUNC       tools for train.py
'''
import os
import _pickle as pickle


def load(dirname):
    '''
    load preproc data from .bin

    Args:
        dirname: path

    Returns:
        preproc: preprocess data -> class
    '''
    preproc_f = os.path.join(dirname, "preproc.bin")
    with open(preproc_f, 'rb') as fid:
        preproc = pickle.load(fid)
    return preproc


def save(preproc, dirname):
    '''
    save preprocess data into .bin

    Args:
        preproc: preprocess data -> class
        dirname: save path
    '''
    preproc_f = os.path.join(dirname, "preproc.bin")
    with open(preproc_f, 'wb') as fid:
        pickle.dump(preproc, fid)
