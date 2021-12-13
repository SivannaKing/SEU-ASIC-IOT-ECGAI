import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

record_df = pd.read_csv('../model/record_df.csv')

x = np.array(record_df["size"][::-1])  # invert
y = np.array(record_df["q_acc"][::-1])  # invert
x_smooth = np.linspace(x.min(), x.max(), 300)


def func(x, a, b, c, d):
    # y = np.log(b + x) + a
    y = a*x*x*x + b*x*x + c*x +d
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
