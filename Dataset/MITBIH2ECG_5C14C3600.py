#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     wzx;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/09/09 - create - wzx
            Initial Commit
@FUNC       transform origin MIT-BIH database into
            5 classes 3600 samples 10s ECG signal
'''
import numpy as np
import wfdb
import os
from tqdm import tqdm
from scipy.signal import medfilt

fliter = int(0.8 * 360)
label_useless_list = ['[', ']', '!', 'x', '|', '~', '+', '"']


def medfilt_ecg(original_ecg, window_size):
    # 确保窗大小变为奇数
    window_size = window_size + 1 if window_size % 2 == 0 else window_size
    give_up_size = int(window_size / 2)
    ecg_baseline = medfilt(original_ecg, window_size)
    totality_bias = np.sum(ecg_baseline[give_up_size:-give_up_size]) / (
        len(original_ecg) - 2 * give_up_size)
    filtered_ecg = original_ecg - ecg_baseline
    final_filtered_ecg = filtered_ecg[
        give_up_size:-give_up_size] - totality_bias
    return final_filtered_ecg


def normalize(data):
    data = data.astype('float')
    mx = np.max(data, axis=0).astype(np.float64)
    mn = np.min(data, axis=0).astype(np.float64)
    # Workaround to solve the problem of ZeroDivisionError
    return np.true_divide(data - mn,
                          mx - mn,
                          out=np.zeros_like(data - mn),
                          where=(mx - mn) != 0)


def label_change_14(label_value_in):
    if label_value_in == 'A':
        label_value_out = 'AP'
    elif label_value_in == 'N':
        label_value_out = 'NOR'
    elif label_value_in == 'V':
        label_value_out = 'PVC'
    elif label_value_in == 'Q':
        label_value_out = 'U'
    elif label_value_in == '/':
        label_value_out = 'P'
    elif label_value_in == 'F':
        label_value_out = 'fVN'
    elif label_value_in == 'j':
        label_value_out = 'NE'
    elif label_value_in == 'L':
        label_value_out = 'LBBB'
    elif label_value_in == 'a':
        label_value_out = 'Aap'
    elif label_value_in == 'R':
        label_value_out = 'RBBB'
    elif label_value_in == 'J':
        label_value_out = 'NP'
    elif label_value_in == 'E':
        label_value_out = 'VE'
    elif label_value_in == 'f':
        label_value_out = 'fPN'
    elif label_value_in == 'e':
        label_value_out = 'AE'
    else:
        print("**********exist extra label!!!!!************")
        label_value_out = label_value_in
    return label_value_out


def label_change_5(label_value_in: str) -> str:
    """将原始数据库转为基于AAMI标准的5分类。

    Args:
        label_value_in (str): 原始数据库标签

    Returns:
        str: 5分类标签
    """
    if label_value_in == 'A':
        label_value_out = 'S'
    elif label_value_in == 'N':
        label_value_out = 'N'
    elif label_value_in == 'V':
        label_value_out = 'V'
    elif label_value_in == 'Q':
        label_value_out = 'Q'
    elif label_value_in == '/':
        label_value_out = 'Q'
    elif label_value_in == 'F':
        label_value_out = 'F'
    elif label_value_in == 'j':
        label_value_out = 'N'
    elif label_value_in == 'L':
        label_value_out = 'N'
    elif label_value_in == 'a':
        label_value_out = 'S'
    elif label_value_in == 'R':
        label_value_out = 'N'
    elif label_value_in == 'J':
        label_value_out = 'S'
    elif label_value_in == 'E':
        label_value_out = 'V'
    elif label_value_in == 'f':
        label_value_out = 'Q'
    elif label_value_in == 'e':
        label_value_out = 'N'
    else:
        print("**********exist extra label!!!!!************")
        label_value_out = label_value_in
    return label_value_out


if __name__ == '__main__':
    rootdir = './mit-bih-arrhythmia-database-1.0.0'
    files = os.listdir(rootdir)
    name_list = []  # name_list=[100, 101, ...， 234]
    ECG = []
    ECG2 = []

    # collect the record name list
    for file in files:
        if file[0:3] in name_list:
            continue
        elif file[0:3] in ['102', '104', '107', '217']:
            print("drop the paced beat", file[0:3])
        else:
            name_list.append(file[0:3])

    for name in name_list:
        if name[0] not in '1234567890':  # skip file not start with num
            continue
        record = wfdb.rdrecord(rootdir + '/' + name)
        annotation = wfdb.rdann(rootdir + '/' + name, 'atr')
        if record.sig_name[0] == 'MLII':
            print("processing record ", name)
            # ecg1 = normalize(record.p_signal[:, 0])  # 归一化处理
            ecg1 = record.p_signal[:, 0]
            t1 = int(0.2 * 360)
            t2 = int(0.6 * 360)
            ecg2 = medfilt(ecg1, t1 + 1)
            ecg3 = medfilt(ecg2, t2 + 1)  # 分别用200ms和600ms的中值滤波得到基线
            ecg4 = ecg1 - ecg3  # 得到基线滤波的结果
            record.p_signal[:, 0] = ecg4
            ECG.append(name)

    f = 360
    segmented_len = 10
    label_count = 0
    count = 0

    segmented_data = []
    segmented_label = []
    ECG_len = len(ECG)

    with tqdm(total=ECG_len) as pbar:
        pbar.set_description('processing ecg record')
        for person in ECG:
            k = 0
            signal_len = wfdb.rdrecord(rootdir + '/' +
                                       person).p_signal.shape[0]
            # until the last point
            while (k + 1) * f * segmented_len <= signal_len:
                record = wfdb.rdrecord(rootdir + '/' + person,
                                       sampfrom=k * f * segmented_len,
                                       sampto=(k + 1) * f * segmented_len)
                annotation = wfdb.rdann(rootdir + '/' + person,
                                        'atr',
                                        sampfrom=k * f * segmented_len,
                                        sampto=(k + 1) * f * segmented_len)

                # mid_signal = medfilt_ecg(record.p_signal[:, 1], 65)
                segmented_data.append(record.p_signal[:, 0])

                # rhythm = annotation.aux_note
                symbol = annotation.symbol
                if len(symbol) == 0:
                    segmented_label.append('Q')
                elif symbol.count('N') / len(symbol) == 1:
                    segmented_label.append('N')
                else:
                    label_dist = {}
                    for i in symbol:
                        if i != 'N':
                            useless_label = 0
                            # if label belong to the useless list remove it
                            for j in range(len(label_useless_list)):
                                if i == label_useless_list[j]:
                                    useless_label = 1
                                    break
                            # if label belong to the useful list add it
                            if useless_label != 1:
                                dist_value = label_dist.get(i, 0)
                                # if not exist key, set 0 and add 1/ else add 1
                                label_dist[i] = dist_value + 1
                    # finish write to the label dist
                    if (len(label_dist) == 0) & (symbol.count('N') != 0):
                        segmented_label.append('N')
                    elif (len(label_dist) == 0) & (symbol.count('N') == 0):
                        segmented_label.append('Q')
                    else:
                        max_dist_value = max(label_dist.values())
                        for key, value in label_dist.items():
                            if value == max_dist_value:
                                label = key
                        segmented_label.append(label)
                k += 1
            pbar.update(1)
        print("finish")

    with open("./label_MIT_C2.txt", "w") as f:
        for i in range(len(segmented_label)):
            str_temp = segmented_label[i]
            f.writelines(str_temp + '\n')

    total_label_dist_5 = {}
    if len(segmented_data) != len(segmented_label):
        print("********************READ ECG WRONG***********************")
    else:
        with tqdm(total=len(segmented_label)) as pbar:
            pbar.set_description('writing ecg 10s to npy file 5 classes')
            total_len = len(segmented_label)
            for i in range(total_len):
                label_value = label_change_5(segmented_label[i][0])
                segment_dir = "./5 classes ECG signals 3600/%s" % label_value
                if not os.path.exists(segment_dir):
                    os.makedirs(segment_dir)
                temp_value = total_label_dist_5.get(label_value, 0)
                total_label_dist_5[label_value] = temp_value + 1
                np.save(
                    segment_dir + "/%s_%d.npy" %
                    (label_value, total_label_dist_5[label_value]),
                    segmented_data[i])
                pbar.update(1)

    print(total_label_dist_5)
