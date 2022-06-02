# ECGAI_ver_1_1 Arrhythmia Detection Algorithm
This project aims to design a HW for arrhymia detection on FPGA.
So we design a CNN first and quantize it(Main Part).
Fianlly, we will load low-precision weights into weight_buffer on FPGA. 

* Dataset : 17 Classes ECG signals (1000 fragments) based on MIT-BIH
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;


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


### 2.4 model
save model and quantized model
* used by 2 project  Qkeras Quantization and TFLite Quantization


### 2.5 Record
save experiment included log; quantized model; quantization distribution