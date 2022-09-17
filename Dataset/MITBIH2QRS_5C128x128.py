#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     wzx;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/09/15 - create - wzx
            Initial Commit
@FUNC       Transform origin ECG dataset to 5 classes QRS 2D 128*128
'''
import os
import wfdb
import numpy as np
import matplotlib.pyplot as plt
from tqdm import tqdm


def quantize(r: np.array, qmax: int, qmin: int = 0) -> np.array:
    """quantize np.array

    Args:
        r (np.array): FP32
        qmax (int): quantization size
        qmin (int, optional): quantization size. Defaults to 0.

    Returns:
        np.array: quantized array
    """
    S = (np.max(r) - np.min(r)) / (qmax - qmin)
    Z = np.round(qmax - np.max(r) / S)
    q = np.round(r / S + Z)
    return q.astype(int)


def signal2img(signal: list[int], height: int):
    """get ECG grey img

    Args:
        signal (list[int]): _description_
        height (int): value range

    Returns:
        NDArray: bool array grey img
    """
    img = np.zeros((len(signal), height), dtype=bool)
    if len(signal) != height:
        print("NOT SQUARE!")
    else:
        for idx, value in enumerate(signal):
            img[height-value-1, idx] = 1  # flip up and down
    return img


def MITBIH_classify(base_path: str, QRS_len: int):
    """19 kinds of signals are divided into 5 categories based on AAMI standard, and the size is 128*128 2D ECG.

    Args:
        base_path (str): Original MIT-BIH dataset path
        QRS_len (int): img size
    """
    # 19->5 classes
    AAMI_MIT = {'N': 'Nfe/jnBLR', 'S': 'SAJa', 'V': 'VEr', 'F': 'F', 'Q': 'Q?'}
    AAMI = {'N': [], 'S': [], 'V': [], 'F': [], 'Q': []}
    file_name = [
        '100', '101', '102', '103', '104', '105', '106', '107', '108', '109',
        '111', '112', '113', '114', '115', '116', '117', '118', '119', '121',
        '122', '123', '124', '200', '201', '202', '203', '205', '207', '208',
        '209', '210', '212', '213', '214', '215', '217', '219', '220', '221',
        '222', '223', '228', '230', '231', '232', '233', '234'
    ]
    ECG = {
        'N': [],
        'f': [],
        'e': [],
        '/': [],
        'j': [],
        'n': [],
        'B': [],
        'L': [],
        'R': [],
        'S': [],
        'A': [],
        'J': [],
        'a': [],
        'V': [],
        'E': [],
        'r': [],
        'F': [],
        'Q': [],
        '?': []
    }
    for F_name in file_name:
        signal_annotation = wfdb.rdann(f'{base_path}/{F_name}',
                                       "atr",
                                       sampfrom=0,
                                       sampto=650000)
        record = wfdb.rdrecord(f'{base_path}/{F_name}',
                               sampfrom=0,
                               sampto=650000,
                               physical=True,
                               channels=[0])
        # del not R-wave labels
        ECG_R_list = np.array([
            'N', 'f', 'e', '/', 'j', 'n', 'B', 'L', 'R', 'S', 'A', 'J', 'a',
            'V', 'E', 'r', 'F', 'Q', '?'
        ])
        # Gets the index of the heartbeat type representing the R point.
        Index = np.isin(signal_annotation.symbol, ECG_R_list)
        Label = np.array(signal_annotation.symbol)
        Label = Label[Index]
        Sample = signal_annotation.sample[Index]  # Coordinates of point R

        Label_kind = list(set(Label))

        for k in Label_kind:
            index = [i for i, x in enumerate(Label) if x == k]
            Signal_index = Sample[index]
            length = len(record.p_signal)

            for site in tqdm(Signal_index):
                if QRS_len // 2 < site < length - QRS_len // 2:
                    q_ECG_signal = quantize(r=record.p_signal,
                                            qmax=QRS_len - 1)
                    ECG_signal = q_ECG_signal.flatten().tolist()
                    start = site - QRS_len // 2
                    end = site + QRS_len // 2
                    ECG_signal = ECG_signal[start:end]  # cut off QRS
                    ECG_img = signal2img(ECG_signal, height=QRS_len)
                    ECG[str(k)].append(ECG_img)

    for key, value in ECG.items():
        print(f'{key} = {len(value)}')

    for ECG_key, ECG_value in ECG.items():
        for AAMI_MIT_key, AAMI_MIT_value in AAMI_MIT.items():
            if ECG_key in AAMI_MIT_value:
                AAMI[AAMI_MIT_key].extend(ECG_value)

    # save into csv
    img_base_path = f'./5 classes QRS signals {QRS_len}x{QRS_len}'
    if os.path.exists(img_base_path):
        print('folder exist!')
    else:
        os.mkdir(img_base_path)
    for key, value in AAMI.items():
        np.save(img_base_path + f'/{key}.npy', np.array(value))


def QRS_print_plot(QRS_len: int):
    """plot a QRS img

    Args:
        QRS_len (int): img size
    """
    AAMI_key = {'N', 'S', 'V', 'F', 'Q'}
    AAMI = dict()

    for key in AAMI_key:
        AAMI[key] = np.load(f'./5 classes QRS signals {QRS_len}x{QRS_len}/{key}.npy')
        print(key, AAMI[key].shape)

    ECG_img = AAMI['V'][100, :, :]
    plt.imshow(ECG_img, cmap=plt.get_cmap('gray'))
    plt.show()


if __name__ == "__main__":
    # MITBIH_classify('./mit-bih-arrhythmia-database-1.0.0', QRS_len=128)
    QRS_print_plot(QRS_len=128)
