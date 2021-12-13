# SEU-ASIC-IOT-ECGAI
Project of Arrhymia Detection on HW/FPGA based on **deep learning algorithm** and **RTL design**


## Background
Every year, about 540,000 people in China die of sudden death caused by arrhythmia. 
Electrocardiogram (ECG) is one of the important detection methods, which is widely used in clinical diagnosis of arrhythmia. 
Technologies related to smart wearable devices capable of real-time arrhythmia monitoring have attracted wide attention.

The deep learning algorithm developed in recent years has the ability to learn more advanced features from data, and its hierarchical structure makes it show better generalization ability and robustness.

We have designed several versions of **intelligent heart rate detection SOC based on ECG signal with high energy efficiency** by means of software and hardware cooperation.

## Dataset
How to get Original dataset?

Click Here [MIT-BIH 17 Classses]()

TODO Add Link

MIT-BIH Arrhythmia Dataset
* 17 Classes
* 10s 360Hz
* MILL

## ECGAI_ver_1_0
Contributor : 李支青；

基线版本ECG检测AI算法

TODO origin version

## ECGAI_ver_1_1
Contributor : 李支青；黄俊光；吴中行；

在 **ver1.0**ECG检测AI算法 的基础上，修改了**网络结构**，并在FPGA上实现。

* Dataset : MIT-BIH MLII 17 Classes;
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;

## ECGAI_ver_2_0
Contributor : 黄俊光；

实现了幂指数量化的**ECG检测AI算法和电路**，电路还有待进一步测试。

## ECGAI_ver_2_1
Contributor : 刘子劲；

设计基于**二值化**的算法。

## ECGAI_ver_2_2
Contributor : 苏峰；

设计基于**混合压缩**的算法。