# SEU-ASIC-IOT-ECGAI
Accelerating Neural Network Inference for Arrhymia Detection on FPGA-Based Platforms


## Background
---
自动心律诊断设备系统的推广有助于检测心率失常的早期症状，帮助人们预防心血管疾病。现如今它们大多基于模式识别的机器学习算法，然而这类算法泛化能力较低，无法很好地应用于数量庞大的心律失常患者群体。深度神经网络(DNN)由于具有从数据中学习更高级特征的能力，表现出更好的泛化能力和鲁棒性而开始被逐步推广。然而DNN目前仍存在模型推导过程消耗大量能量、保存模型要求大量内存空间等问题亟需解决。因此，对更高能效的智能心率检测系统的研究在临床诊断，健康状况监测等领域有很大的应用前景。


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

在 **ver1.0**ECG检测AI算法 的基础上，修改了**网络结构**，并在FPGA上完成仿真。

* Dataset : MIT-BIH 17 Classes;
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;

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