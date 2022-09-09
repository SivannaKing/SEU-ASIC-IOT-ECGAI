#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     wzx;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/08/30 - create - wzx
            Initial Commit
@FUNC       transform origin ECG dataset to 5 classes QRS
'''
import wfdb
import numpy as np
import csv
import matplotlib.pyplot as plt


def MITBIH_print(signal_path: str):
    """打印一段0~1000的ECG信号采样记录的标注和位置。

    Args:
        signal_path (str): 某个采样记录路径
    """
    signal_annotation = wfdb.rdann(signal_path, "atr", sampfrom=0, sampto=1000)
    # 打印标注信息
    print("symbol: " + str(signal_annotation.symbol))
    print("sample: " + str(signal_annotation.sample))
    # 运行结果如下
    # symbol: ['~', '+', 'N', 'N']
    # sample: [ 83 229 351 724]


def MITBIH_plot(signal_path: str):
    """画出一段0~1000的ECG信号采样记录，标出标注点。

    Args:
        signal_path (str): 某个采样记录路径
    """
    record = wfdb.rdrecord(signal_path,
                           sampfrom=0,
                           sampto=1000,
                           physical=True,
                           channels=[0])
    signal_annotation = wfdb.rdann(signal_path, "atr", sampfrom=0, sampto=1000)
    ECG = record.p_signal
    plt.plot(ECG)
    # 按坐标在散点图上绘点
    for index in signal_annotation.sample:
        plt.scatter(index, ECG[index], marker='*', s=200)
    plt.show()


def MITBIH_classify(base_path: str):
    """将19类信号分为基于AAMI标准的5分类。

    Args:
        base_path (str): 原始数据集路径
    """
    # 将19类信号分为五大类
    AAMI_MIT = {'N': 'Nfe/jnBLR', 'S': 'SAJa', 'V': 'VEr', 'F': 'F', 'Q': 'Q?'}
    # 5分类存储字典
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
        # 删除非R点的标签
        ECG_R_list = np.array([
            'N', 'f', 'e', '/', 'j', 'n', 'B', 'L', 'R', 'S', 'A', 'J', 'a',
            'V', 'E', 'r', 'F', 'Q', '?'
        ])
        # 获取表示R点的心拍类型的索引
        Index = np.isin(signal_annotation.symbol, ECG_R_list)
        # 将标签从list列表类型转化为数组类型为了用下面的索引值提取
        Label = np.array(signal_annotation.symbol)
        Label = Label[Index]  # 提取表示为R点的心拍标签
        Sample = signal_annotation.sample[Index]  # 提取表示为R点的坐标
        Label_kind = list(set(Label))  # 获取心拍种类
        # 读取每一种R点在信号中的位置
        for k in Label_kind:
            index = [i for i, x in enumerate(Label) if x == k]
            Signal_index = Sample[index]
            length = len(record.p_signal)
            # 截取
            for site in Signal_index:
                if 130 < site < length - 130:
                    ECG_signal = record.p_signal.flatten().tolist()
                    ECG_signal = ECG_signal[site - 130:site + 130]
                    ECG[str(k)].append(ECG_signal)

    # 打印种类
    for key, value in ECG.items():
        print(f'{key} = {len(value)}')

    for ECG_key, ECG_value in ECG.items():
        for AAMI_MIT_key, AAMI_MIT_value in AAMI_MIT.items():
            if ECG_key in AAMI_MIT_value:
                AAMI[AAMI_MIT_key].extend(ECG_value)

    # 5分类并保存到CSV格式的文件里
    for key, value in AAMI.items():
        with open(f'./5 classes QRS signals 130/{key}.csv', 'w', newline='\n') as f:
            writer = csv.writer(f)
            # 将列表的每条数据依次写入csv文件， 并以逗号分隔
            # 传入的数据为列表中嵌套列表或元组，每一个列表或元组为每一行的数据
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
    MITBIH_print('./mit-bih-arrhythmia-database-1.0.0/106')
    MITBIH_plot('./mit-bih-arrhythmia-database-1.0.0/106')
    MITBIH_classify('./mit-bih-arrhythmia-database-1.0.0')
    QRS_print_plot()
