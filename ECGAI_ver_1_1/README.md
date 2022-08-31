# ECGAI_ver_1_1
Contributor : 李支青；黄俊光；吴中行；

This project aims to design a HW for arrhythmia detection on FPGA. On the basis of ver1.0ECG detection AI algorithm, the network structure was modified. Then we quantized in 8 bits and lower bit width. Finally, we loaded 8-bit quantized weights into weight_buffer on FPGA. 

* Dataset : 17 Classes ECG signals (1000 fragments) based on MIT-BIH
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;
* RTL Design Tools : Vivado; VCS;
* FPGA ： Xilinx 7020;

---
## TODO DirTree

---
## Accelerator
TODO Add description

---
## Algorithm
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
## Documents
TODO Add files
训练实验文档
量化实验文档

---
## Experiments
TODO Add files

---
## Papers
TODO Add files

---
## PEexploration
TODO Add files