# run in env Qkeras
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from tensorflow import keras
from qkeras.utils import model_quantize
import qkeras
import netron


# use by function converter
# make q_dict configure qkeras quantize
# i don't kown why but you need quantized_bits(3,0,1) to have a 4-bit wide quantization JUST FOR conv1D
# bit_wide_list : quantization distribution
# absmax_weight_list : list of absmax weights of each layer (exist Qkeras_8bit_model)
# return : q_dict
def make_q_dict(bit_wide_list=[8, 8, 8, 8, 8, 8, 8], absmax_weight_list=[]):
    if not absmax_weight_list:
        if len(set(bit_wide_list)) == 1 and bit_wide_list[0]==8:
            q_dict = {
                "conv1": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "conv2": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "conv3": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "conv4": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "conv5": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "conv6": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
                },

                "Dense1": {
                    "kernel_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0]),
                    "bias_quantizer": "quantized_bits({},0,1)".format(bit_wide_list[0])
                }
            }
        else:
            input('please set AbsmaxWeightList or run 8888888 first !')
    else:
        q_dict = {
            "conv1": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[0] - 1, absmax_weight_list[0]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[0] - 1)
            },

            "conv2": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[1] - 1, absmax_weight_list[1]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[1] - 1)
            },

            "conv3": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[2] - 1, absmax_weight_list[2]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[2] - 1)
            },

            "conv4": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[3] - 1, absmax_weight_list[3]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[3] - 1)
            },

            "conv5": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[4] - 1, absmax_weight_list[4]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[4] - 1)
            },

            "conv6": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[5] - 1, absmax_weight_list[5]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[5] - 1)
            },

            "Dense1": {
                "kernel_quantizer": "quantized_bits({},0,1,{})".format(bit_wide_list[6], absmax_weight_list[6]),
                "bias_quantizer": "quantized_bits({},0,1,1)".format(bit_wide_list[6])
            }
        }
    return q_dict


# use by function evaluate
# converter keras model to qkeras model
# BitWideList : quantization distribution
# AbsmaxWeightList : list of absmax weights of each layer (exist Qkeras_8bit_model)
def converter(model_path, qmodel_path, BitWideList, AbsmaxWeightList):
    model = keras.models.load_model(model_path)
    print('quantizing...')
    qmodel = model_quantize(model,
                            make_q_dict(BitWideList, AbsmaxWeightList),
                            max(BitWideList),
                            transfer_weights=True)
    # qmodel.summary()
    qkeras.utils.model_save_quantized_weights(qmodel, qmodel_path) # only save weight
    # netron.start(qmodel_path)
