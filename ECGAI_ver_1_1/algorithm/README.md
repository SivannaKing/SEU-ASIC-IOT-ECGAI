# ECGAI_ver_1_1 Arrhythmia Detection Algorithm
## 1 Project Description
This project aims to design a HW for arrhymia detection on FPGA.
So we design a CNN first and quantize it(Main Part).
Fianlly, we will load low-precision weights into weight_buffer on FPGA. 

* Dataset : MIT-BIH
* Training Tools : tensorflow; keras;
* Quantize Tools : Qkeras; tensorflow lite;


## 2 File Structure
base path|sub path|folder
---|---|---
ECG2|Train|saved
-->|TFLite Quantization
-->|Qkeras Quantization
-->|model
-->|MLII
-->|Record
-->|layer_wise_quantization


### 2.1 Train
train FP32 model
* save model(.hdf5) in '../Train/saved'

env : **TF23**

package|version
---|---
tensorflow|2.3.0

we don't use tf 2.4.0 because our CUDA==10.1 CUDNN==7.6

  
### 2.2 TFLite Quantization
quantize FP32 model to INT8 model with tensorflow lite
* find best model in Train/saved and copy to model
* save quantization model(.tflite) in model
env : **TFLite


package|version
---|---
tf-nightly-cpu|2.3.0
tensorflow-model-optimization|0.5.0

TODO HOW to use? 


### 2.3 Qkeras Quantization
quantize FP32 model to low bit quantization model with Qkeras
* save quantization model(.h5) and quantization log in model
* need FP32_model.hdf5 in '../model'
env: Qkeras

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