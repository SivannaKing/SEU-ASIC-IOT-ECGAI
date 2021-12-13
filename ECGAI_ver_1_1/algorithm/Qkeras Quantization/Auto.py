import os
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from time import sleep


# use by main
# try every QD on basic QD(Quantization Distrubution)
# eg. basic QD = 8888888
#          try = 6888888
#                8688888
#                ...
#                8888886
# QuantizationDistribution :
# return : Next basic QD, q_acc, acc-q_acc, size
def traver(QuantizationDistribution):
    sleep(2)  # wait for cpu

    # change quantization_distribution  and RUN evaluate.py
    for i in range(7):
        with open('config.json', 'r') as j:
            config_setting = json.load(j)
        config_setting["quantization_distribution"] = QuantizationDistribution
        quantization_distribution = list(config_setting["quantization_distribution"])
        quantization_distribution = list(map(int, quantization_distribution))
        if quantization_distribution[i] in [4, 6, 8]:
            quantization_distribution[i] = quantization_distribution[i] - 2
        config_setting["quantization_distribution"] = ''.join([str(x) for x in quantization_distribution])
        with open('config.json', 'w') as j:
            json.dump(config_setting, j)
        os.system('python evaluate.py config.json')

    # save 7 log lines in qlist
    # ONE qlist row for ONE Quantization Distrubution
    qlist = [[],
             [],
             [],
             []]
    MINAccLoss = 100
    tree = 0

    # read log
    with open('../model/log-rc', 'r') as f:
        lines = f.readlines()
        # 7 layers
        for i in range(7):
            linelist = lines[i - 7].split('\t')

            # process str in log
            for x in linelist:
                if x in ['', '\n', '\t', ' ']:
                    linelist.remove(x)

            # linelist[0] eg. '[6, 8, 8, 8, 8, 8, 8]' -> '688888'
            linelist[0] = list(linelist[0])
            for x in linelist[0]:
                if x in ['[', ']', ' ', ',']:
                    linelist[0].remove(x)
            linelist[0] = ''.join(linelist[0][::2])  # Quantization Distrubution
            # str -> float
            linelist[2] = float(linelist[2])  # q_acc
            linelist[3] = float(linelist[3])  # acc - q_acc
            linelist[-1] = float(linelist[-1])  # size

            if linelist[0] == QuantizationDistribution:
                continue

            tree += 1
            # record min acc - q_acc
            if MINAccLoss >= linelist[3]:
                MINAccLoss = linelist[3]

            # save log line in qlist
            # linelist eg. ['6888888', '94.74', 94.08, 0.66, '', '', '', '52.31']
            qlist[0].append(linelist[0])  # quantization distrubution
            qlist[1].append(linelist[2])  # q_acc
            qlist[2].append(linelist[3])  # acc - q_acc
            qlist[3].append(linelist[-1])  # size

        # find min size in qlist[][0~6]
        MINSize = 100
        for i in range(tree):
            if qlist[2][i] == MINAccLoss:
                if MINSize >= qlist[3][i]:
                    MINSize = qlist[3][i]

        for i in range(tree):
            if qlist[2][i] == MINAccLoss and qlist[3][i] == MINSize:
                return list(map(lambda x: x[i], qlist))

        return None


if __name__ == '__main__':
    count = 0  # conut biasc QD

    # initialize with 8888888
    Next = traver('8888888')
    record_arr = np.array(Next)  # record [basic QD, q_acc, acc-q_acc, size] in arr

    while (True):
        count += 1
        QD = Next[0]
        Next = traver(QD)
        # STOP condition
        if Next[0] == '2222222' or Next is None or Next[0] == QD or count == 20:
            break
        # record [basic QD, q_acc, acc-q_acc, size] in arr_row
        new_row = np.array(Next)
        record_arr = np.row_stack((record_arr, new_row))  # Merge into record_arr

    # record into df
    labels = ['Quantization Distrubution', 'q_acc', 'acc - q_acc', 'size']
    df = pd.DataFrame(record_arr, columns=labels)
    print(df)
    with open('../model/record_df.csv', 'w') as f:
        f.write(df.to_csv())
