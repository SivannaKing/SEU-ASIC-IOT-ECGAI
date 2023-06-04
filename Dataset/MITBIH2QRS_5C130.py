#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     wzx;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/08/30 - create - wzx
            Initial Commit
@FUNC       transform origin ECG dataset to 5 classes QRS
'''
import os
import wfdb
import numpy as np
import csv
import matplotlib.pyplot as plt


def MITBIH_print(signal_path: str):
    """Print the label and position of a 0~1000 ECG signal sampling record.

    Args:
        signal_path (str): A sample path
    """
    signal_annotation = wfdb.rdann(signal_path, "atr", sampfrom=0, sampto=1000)
    print("symbol: " + str(signal_annotation.symbol))
    print("sample: " + str(signal_annotation.sample))
    # result
    # symbol: ['~', '+', 'N', 'N']
    # sample: [ 83 229 351 724]


def MITBIH_plot(signal_path: str):
    """Draw a sampling record of ECG signal from 0 to 1000, and mark the marked points.

    Args:
        signal_path (str): A sample path
    """
    record = wfdb.rdrecord(signal_path,
                           sampfrom=0,
                           sampto=1000,
                           physical=True,
                           channels=[0])
    signal_annotation = wfdb.rdann(signal_path, "atr", sampfrom=0, sampto=1000)
    ECG = record.p_signal
    plt.plot(ECG)

    for index in signal_annotation.sample:
        plt.scatter(index, ECG[index], marker='*', s=200)
    plt.show()


def MITBIH_classify(base_path: str):
    """19 kinds of signals are divided into 5 categories based on AAMI standard, and the size is 261 1D ECG.

    Args:
        base_path (str): 原始数据集路径
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
            # 截取
            for site in Signal_index:
                if 130 < site < length - 130:
                    ECG_signal = record.p_signal.flatten().tolist()
                    ECG_signal = ECG_signal[site - 130:site + 130]  # cut off QRS
                    ECG[str(k)].append(ECG_signal)

    for key, value in ECG.items():
        print(f'{key} = {len(value)}')

    for ECG_key, ECG_value in ECG.items():
        for AAMI_MIT_key, AAMI_MIT_value in AAMI_MIT.items():
            if ECG_key in AAMI_MIT_value:
                AAMI[AAMI_MIT_key].extend(ECG_value)

    # save into 5 scv
    for key, value in AAMI.items():
        if os.path.exists('./5 classes QRS signals 130'):
            print('文件夹存在')
        else:
            os.mkdir('./5 classes QRS signals 130')
        with open(f'./5 classes QRS signals 130/{key}.csv', 'w', newline='\n') as f:
            writer = csv.writer(f)
            # Write each piece of data in the list into csv file in turn, separated by commas.
            # The incoming data is nested lists or tuples in a list, and each list or tuple is the data of each row.
            writer.writerows(value)


def QRS_print_plot():
    AAMI_key = {'N', 'S', 'V', 'F', 'Q'}
    AAMI = dict()

    def Tolist(x):
        return list(map(float, x))

    for key in AAMI_key:
        with open(f'./5 classes QRS signals 130/{key}.csv', 'r') as f:
            reader = csv.reader(f)
            AAMI[key] = list(map(Tolist, list(reader)))

    for i in AAMI_key:
        print(f'{i}={np.array(AAMI[i]).shape}')

    QRS = AAMI['N'][0]
    plt.plot(QRS)
    plt.show()


if __name__ == "__main__":
    # MITBIH_print('./mit-bih-arrhythmia-database-1.0.0/106')
    MITBIH_plot('./mit-bih-arrhythmia-database-1.0.0/106')
    # MITBIH_classify('./mit-bih-arrhythmia-database-1.0.0')
    # QRS_print_plot()