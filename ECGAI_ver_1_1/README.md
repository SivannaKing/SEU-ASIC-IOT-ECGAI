# SEU-ASIC-IOT-ECGAI
Arrhythmia Detection Using Algorithm and Hardware Co-design for Neural Network Inference Accelerators

使用神经网络推理加速器的算法和硬件协同设计的心律失常检测

## Background
---
The popularization of automatic arrhythmia diagnosis equipment system is helpful to detect the early symptoms of arrhythmia and help people prevent cardiovascular diseases. Nowadays, most of them are machine learning algorithms based on pattern recognition. However, these algorithms have low generalization ability and can't be well applied to a large number of arrhythmia patients. Deep neural network (DNN) has been gradually popularized because of its ability to learn more advanced features from data, showing better generalization ability and robustness. However, DNN/CNN still has some problems that need to be solved urgently, such as the model derivation process consumes a lot of energy and the storage of the model requires a lot of memory space. Therefore, the research of intelligent heart rate detection system with higher energy efficiency has great application prospects in clinical diagnosis, health monitoring and other fields.

## Installation
---
Download all versions
```
git clone https://github.com/SivannaKing/SEU-ASIC-IOT-ECGAI.git
git clone git@github.com:SivannaKing/SEU-ASIC-IOT-ECGAI.git
```
Download branch or tag of **specific version**
```
git clone --branch [branch/tag] https://github.com/SivannaKing/SEU-ASIC-IOT-ECGAI.git
git clone --branch [branch/tag] git@github.com:SivannaKing/SEU-ASIC-IOT-ECGAI.git
```

## Dataset
---
MIT-BIH Arrhythmia Database is available on [physionet](https://www.physionet.org/content/mitdb/1.0.0/).

17 Classes ECG signals (1000 fragments) based on MIT-BIH is available on [mendeley](https://data.mendeley.com/datasets/7dybx7wyfn/3).

TODO add MIT-BIH 5 Classes detail


## ECGAI_ver_1_1
---
Contributor : 李支青；黄俊光；吴中行；

This project aims to design a HW for arrhythmia detection on FPGA. On the basis of ver1.0ECG detection AI algorithm, the network structure was modified. Then we quantized in 8 bits and lower bit width. Finally, we loaded 8-bit quantized weights into weight_buffer on FPGA. 

* Dataset : 17 Classes ECG signals (1000 fragments) based on MIT-BIH
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;
* FPGA ： Xilinx 7020;

## TODO DirTree
---


## Algorithm
---
Requirements
* python 3.8
* tensorflow 2.6.0
* keras ~= 2.6.0 (You need install lower version manually)
* Qkeras master (20220606 Update)
* protobuf < 3.21.0 (You need install lower version manually)

Clone from [Qkeras](https://github.com/google/qkeras) or you can run `pip install .`in download folder [algorithm/Qkeras Quantization/qkeras] in this project. ***NOTE Qkeras install requirements!***

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

*How to use* : open terminal in [Train] on windows and run command below.
1. Manual quantification
```
python qevaluate.py config.json
```
2. Automatic quantization
```
python Auto.py
python plot.py
```
TODO 验证量化结果？？？分层量化结果太好了。量化结果出错，修改keras2qkeras

TODO [TFLite Quantization] : quantize FP32 model to INT8 model with tensorflow lite
* find best model in Train/saved and copy to model
* save quantization model(.tflite) in model

| package                       | version |
| ----------------------------- | ------- |
| python                        | 3.6     |
| tf-nightly-cpu                | 2.3.0   |
| tensorflow-model-optimization | 0.5.0   |

## Documents
---
TODO Add files

## Experiments
---
TODO Add files

## Papers
---
TODO Add files

## PEexploration
---
TODO Add files

## Competition
---
TODO Add link