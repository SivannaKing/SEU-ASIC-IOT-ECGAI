from matplotlib import pyplot as plt
import numpy as np
import os

layer_output_32_path = './wzx_model_layer_output/'
layer_output_16_path = './wzx_model_16_layer_output/'
data_path = layer_output_16_path
for root, dirs, files in os.walk(data_path, topdown=False):
    for files_name in files:
        loadData = np.load(os.path.join(data_path, files_name))
        loadData = loadData.flatten()
        print('ploting...', files_name)
        plt.hist(loadData, bins=100)
        plt.show()
        plt.title(files_name)