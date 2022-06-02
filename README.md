# SEU-ASIC-IOT-ECGAI
Arrhythmia Detection Using Algorithm and Hardware Co-design for Neural Network Inference Accelerators


## Background
---
The popularization of automatic arrhythmia diagnosis equipment system is helpful to detect the early symptoms of arrhythmia and help people prevent cardiovascular diseases. Nowadays, most of them are machine learning algorithms based on pattern recognition. However, these algorithms have low generalization ability and can't be well applied to a large number of arrhythmia patients. Deep neural network (DNN) has been gradually popularized because of its ability to learn more advanced features from data, showing better generalization ability and robustness. However, DNN/CNN still has some problems that need to be solved urgently, such as the model derivation process consumes a lot of energy and the storage of the model requires a lot of memory space. Therefore, the research of intelligent heart rate detection system with higher energy efficiency has great application prospects in clinical diagnosis, health monitoring and other fields.

## Dataset
---
MIT-BIH Arrhythmia Database is available on [physionet](https://www.physionet.org/content/mitdb/1.0.0/).

17 Classes ECG signals (1000 fragments) based on MIT-BIH is available on [mendeley](https://data.mendeley.com/datasets/7dybx7wyfn/3).

TODO add MIT-BIH 5 Classses detail

## ECGAI_ver_1_0
---
Contributor : 李支青；

基线版本ECG检测AI算法

TODO origin version

## ECGAI_ver_1_1
---
Contributor : 李支青；黄俊光；吴中行；

在**ver1.0**ECG检测AI算法 的基础上，修改了**网络结构**，进行了量化并在FPGA上完成仿真。

* Dataset : MIT-BIH 17 Classes;
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;
* FPGA ： Xilinx 7020;

## ECGAI_ver_2_0
---
Contributor : 黄俊光；

实现了幂指数量化的**ECG检测AI算法和电路**，电路还有待进一步测试。

## ECGAI_ver_2_1
---
Contributor : 刘子劲；

设计基于**二值化**的算法。

## ECGAI_ver_2_2
---
Contributor : 苏峰；

设计基于**混合压缩**的算法。