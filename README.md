# SEU-ASIC-IOT-ECGAI
Arrhythmia Detection Using Algorithm and Hardware Co-design for Neural Network Inference Accelerators

使用神经网络推理加速器的算法和硬件协同设计的心律失常检测


## Background
The popularization of automatic arrhythmia diagnosis equipment system is helpful to detect the early symptoms of arrhythmia and help people prevent cardiovascular diseases. Nowadays, most of them are machine learning algorithms based on pattern recognition. However, these algorithms have low generalization ability and can't be well applied to a large number of arrhythmia patients. Deep neural network (DNN) has been gradually popularized because of its ability to learn more advanced features from data, showing better generalization ability and robustness. However, DNN/CNN still has some problems that need to be solved urgently, such as the model derivation process consumes a lot of energy and the storage of the model requires a lot of memory space. Therefore, the research of intelligent heart rate detection system with higher energy efficiency has great application prospects in clinical diagnosis, health monitoring and other fields.

## Installation
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

## DIR Tree
- [SEU-ASIC-IOT-ECGAI](#seu-asic-iot-ecgai)
  - [Background](#background)
  - [Installation](#installation)
  - [DIR Tree](#dir-tree)
  - [Version Description](#version-description)
    - [branch](#branch)
    - [tag](#tag)
  - [Dataset](#dataset)
  - [ECGAI_ver_1_0](#ecgai_ver_1_0)
  - [ECGAI_ver_1_1](#ecgai_ver_1_1)
  - [ECGAI_ver_2_0](#ecgai_ver_2_0)
  - [ECGAI_ver_2_1](#ecgai_ver_2_1)
  - [ECGAI_ver_3_0](#ecgai_ver_3_0)
  - [比赛链接](#比赛链接)


## Version Description
### branch
1. ver_1_0
  
基线版本ECG检测AI算法，网络结构为6CONV+2FC，量化使用了分层量化。只有算法部分。

2. ver_1_1

包含算法到硬件实现，并且通过了验证。网络结构为6CONV+1GAP+1FC，量化采用8bit量化。

3. ver_2_0

在ver_1_1的基础上，改进了硬件架构。量化方式采用幂指化。

4. ver_2_1 

设计一种基于混合压缩的算法。

5. ver_3_0

二值化版本。

### tag


## Dataset
MIT-BIH Arrhythmia Database is available on [physionet](https://www.physionet.org/content/mitdb/1.0.0/).

17 Classes ECG signals (1000 fragments) based on MIT-BIH is available on [mendeley](https://data.mendeley.com/datasets/7dybx7wyfn/3).

TODO add MIT-BIH 5 Classes detail


## ECGAI_ver_1_0
Contributor : 李支青；

基线版本ECG检测AI算法，网络结构为6CONV+2FC，量化使用了分层量化。只有算法部分。


## ECGAI_ver_1_1
Contributor : 李支青；黄俊光；吴中行；

包含算法到硬件实现，并且通过了验证。网络结构为6CONV+1GAP+1FC，量化采用8bit量化。

* Dataset : MIT-BIH 17 Classes;
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;
* FPGA ： Xilinx 7020;


## ECGAI_ver_2_0
Contributor : 黄俊光；

在ver_1_1的基础上，改进了硬件架构。量化方式采用幂指化。


## ECGAI_ver_2_1
Contributor : 苏峰；

设计一种基于混合压缩的算法。


## ECGAI_ver_3_0
Contributor : 刘子劲；

二值化版本。但是没有完全二值化，有些还是使用了两位(+1, -1, 0)。


## 比赛链接
