# SEU-ASIC-IOT-ECGAI
Arrhythmia Detection Using Algorithm and Hardware Co-design for Neural Network Inference Accelerators


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

TODO add MIT-BIH 5 Classses detail


## ECGAI_ver_1_1
---
Contributor : 李支青；黄俊光；吴中行；

在**ver1.0**ECG检测AI算法 的基础上，修改了**网络结构**，进行了量化并在FPGA上完成仿真。
This project aims to design a HW for arrhymia detection on FPGA.
So we design a CNN first and quantize it(Main Part).
Fianlly, we will load low-precision weights into weight_buffer on FPGA. 

* Dataset : 17 Classes ECG signals (1000 fragments) based on MIT-BIH
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;
* FPGA ： Xilinx 7020;

## TODO DirTree
---


## Train
---
train and evaluate FP32 model
* save training log in './Train/logs'
* save model(.hdf5) and preprocess data in './Train/saved'

package|version
---|---
tensorflow|2.5.0

**How to use** : open terminal in './Train' on windows and run command below.
```
python data_build.py
python train.py config.json
tensorboard --logdir logs
python evaluate.py config.json
```
  
## TFLite Quantization
---
quantize FP32 model to INT8 model with tensorflow lite
* find best model in Train/saved and copy to model
* save quantization model(.tflite) in model


package|version
---|---
tf-nightly-cpu|2.3.0
tensorflow-model-optimization|0.5.0

TODO HOW to use? 


## Qkeras Quantization
---
quantize FP32 model to low bit quantization model with Qkeras
* save quantization model(.h5) and quantization log in model
* need FP32_model.hdf5 in '../model'

package|version
---|---
tensorflow|2.3.0
Qkeraas|0.8.0

install and konw more about Qkeras : [Qkeras](https://github.com/google/qkeras)

run `pip install .`in download folder and ***NOTE Qkeras install requirements!***




## Record
save experiment included log; quantized model; quantization distribution