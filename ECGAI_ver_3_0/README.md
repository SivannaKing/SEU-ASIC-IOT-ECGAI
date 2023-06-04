# ECGAI_ver_3_0
Contributor : 刘子劲；

The goal of this project is to design and implement an **energy-efficient convolutional neural network accelerator for ECG detection based on BNN on FPGA platform**. On the premise of ensuring the accuracy, make full use of the characteristics of BNN network with low memory and calculation overhead, reduce the resource and bandwidth occupation of deploying neural network on FPGA, and realize an energy-efficient embedded neural network accelerator.

The main contents of this project are divided into the following two parts.
1. Design of ECG detection network based on BNN: It mainly includes network structure design and network binary quantization. The network structure design is mainly based on the original network. By adding batch normalization layer and expanding convolution kernel, the network is conducive to the implementation of binary quantization. On the premise of ensuring the accuracy of the quantized network, the bit width of the non-binary parameters of the network should be compressed as much as possible.
2. Design of convolutional neural network accelerator based on BNN: According to the network structure and parameters, combined with the number of resources of FPGA platform, explore the design space and determine the size of the accelerator. At the same time, combined with the characteristics of low parameters of binary network, an appropriate data scheduling architecture is designed. In the design of arithmetic unit, considering the input bit width of each layer, a unified arithmetic unit is designed to perform convolution, batch normalization and activation operations.
3. FPGA implementation verification: realize the mapping between hardware architecture and FPGA, and optimize the timing, power consumption and resource occupation as much as possible.

* Dataset : 5 classes ECG signals 3600 based on MIT-BIH
* Training Tools : pytorch;
* Quantize Tools : bnn; XNOR-net;
* RTL Design Tools : Vivado; VCS; Verdi;
* FPGA ： Xilinx Zynq-7000 Miz7035;

---
## TODO DirTree

---
## algorithm
Requirements
* python 3.8
* tensorflow 2.6.0
* keras ~= 2.6.0 (You need install lower version manually)
* Qkeras master (20220606 Update)
* protobuf < 3.20.0 (You need install lower version manually)

*How to install Qkeras?* : Clone from [Qkeras](https://github.com/google/qkeras) and run `pip install .`in download folder [qkeras] in this project. ***NOTE Qkeras install requirements!***

See more PreRequirements in [requirements.txt](./ECGAI_ver_1_1/algorithm/requirements.txt)

[**Train**] : train and evaluate FP32 model
* save training log in './Train/logs'
* save model(.hdf5) and preprocess data in './Train/saved'

*How to use* : open terminal in [Train] on windows and run command below.
```
python data_build.py
python train.py config.json
tensorboard --logdir logs
python evaluate.py config.json
```
[**Qkeras Quantization**] : quantize FP32 model to low bit quantization model with Qkeras (Auto)
* save quantization model(.h5) and quantization log in model
* need FP32_model.hdf5 in '../model'
* Use same file in [Train] : load.py network.py evaluate.py util.py
* use **netron** check weight in model & qmodel

*How to use* : open terminal in [Qkeras Quantization] on windows and run command below.
1. Manual quantification
```
python qevaluate.py config.json
```
2. Automatic quantization
```
python Auto.py
python plot.py
```
使用Qkeras量化工具中的 keras2qkeras 的时候，发现部分问题。**q_dict中的quantized_bits并不能实现INT8量化，小数量化也与设置的数值不相符合。**经过实验，这里keras_2_qkeras更加接近定点化。如果要实现1位符号位，2位整数位，5位小数位的8bits量化，需要将"quantization_distribution"设置为"4443334"。这样才能保证，小数是5bits。

TODO 使用Qkeras，直接建立Qkeras模型，再训练的方式量化。

[TFLite Quantization] : quantize FP32 model to INT8 model with tensorflow lite
* find best model in Train/saved and copy to model
* save quantization model(.tflite) in model

| package                       | version |
| ----------------------------- | ------- |
| python                        | 3.6     |
| tf-nightly-cpu                | 2.3.0   |
| tensorflow-model-optimization | 0.5.0   |

---
## pe_exploration
TODO Add files

---
## accelerator
TODO Add description

---
## docs
1. 刘子劲毕业论文《基于BNN的ECG信号检测神经网络加速器的设计》
2. 加速器设计文档
3. rtl代码说明

---
## Experiments
TODO Add files