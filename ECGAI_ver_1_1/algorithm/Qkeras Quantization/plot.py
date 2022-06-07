#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2022/04/07 - create - 吴中行
            create basic functions
@FUNC       plot size vs q_acc with different quantization distribution
'''
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

record_df = pd.read_csv('../model/record_df.csv')

x = np.array(record_df["size"][::-1])  # invert
y = np.array(record_df["q_acc"][::-1])  # invert
x_smooth = np.linspace(x.min(), x.max(), 300)


def func(x, a, b, c, d):
    """TWO Fitting functions

    Args:
        x (_type_): _description_
        a (_type_): _description_
        b (_type_): _description_
        c (_type_): _description_
        d (_type_): _description_

    Returns:
        _type_: _description_
    """
    # y = np.log(b + x) + a
    y = a * x * x * x + b * x * x + c * x + d
    return y


popt, pcov = curve_fit(func, x, y)
a = popt[0]
b = popt[1]
c = popt[2]
d = popt[3]

yvals = func(x_smooth, a, b, c, d)

plot1 = plt.plot(x, y, 's', label='original values')
plot2 = plt.plot(x_smooth, yvals, 'r', label='polyfit values')
plt.xlabel('size')
plt.ylabel('q_acc')
plt.legend(loc=4)  # legend in 4th quadrant
plt.title('size-q_acc polyfitting')
plt.show()
