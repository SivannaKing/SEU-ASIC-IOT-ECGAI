import keras
from qkeras import *
from keras.models import load_model

model = load_model('./957_1.hdf5')
model.summary()


# for layer in model.layers:
#     print(layer.name)
#     print(layer.output_shape)
q_dict = {
    "conv1d_1": {
            "kernel_quantizer": "quantized_bits(5,0,1,0.34375)",
            "bias_quantizer": "quantized_bits(5,0,1,1)"
    },

    "conv1d_2": {
            "kernel_quantizer": "quantized_bits(5,0,1,0.4921875)",
            "bias_quantizer": "quantized_bits(5,0,1,1)"
    },

    "conv1d_3": {
        "kernel_quantizer": "quantized_bits(4,0,1,0.3515625)",
        "bias_quantizer": "quantized_bits(4,0,1,1)"
    },

    "conv1d_4": {
        "kernel_quantizer": "quantized_bits(3,0,1,0.5859375)",
        "bias_quantizer": "quantized_bits(3,0,1,1)"
    },

    "conv1d_5": {
        "kernel_quantizer": "quantized_bits(1,0,1,0.546875)",
        "bias_quantizer": "quantized_bits(1,0,1,1)"
    },

    "conv1d_6": {
        "kernel_quantizer": "quantized_bits(3,0,1,0.5078125)",
        "bias_quantizer": "quantized_bits(3,0,1,1)"
    },

    "conv1d_7": {
        "kernel_quantizer": "quantized_bits(2,0,1,0.4765625)",
        "bias_quantizer": "quantized_bits(2,0,1,1)"
    },
    "dense_1": {
        "kernel_quantizer": "quantized_bits(1,0,1,0.546875)",
        "bias_quantizer": "quantized_bits(1,0,1,1)"
    },

    "dense_2": {
        "kernel_quantizer": "quantized_bits(4,0,1,0.59375)",
        "bias_quantizer": "quantized_bits(4,0,1,1)"
    }
}

qmodel, _ = model_quantize(model, q_dict, 3, transfer_weights=True)
model_save_quantized_weights(qmodel, '12_17_1.hdf5')
