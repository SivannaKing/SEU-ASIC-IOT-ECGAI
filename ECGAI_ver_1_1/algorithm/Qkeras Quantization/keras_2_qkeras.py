#!/usr/bin/env python
# -*- coding: utf-8 -*-
'''
@AUTHOR     吴中行;
@EMAIL      wuzhong_xing@126.com
@TIME&LOG   2021/01/06 - create - 吴中行
            create basic functions
            2022/06/06 - modify - 吴中行
            del qnoise_factor and AbsMaxWeightList
@FUNC       turn keras model to qkeras model by q_dict
 TODO       save model not only weight
'''
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from qkeras.utils import model_quantize
import qkeras
import netron


def make_q_dict(bit_wide_list=[8, 8, 8, 8, 8, 8, 8]):
    """make q_dict configure

    quantized_bits
    Attributes:
    bits: number of bits to perform quantization.
    integer: number of bits to the left of the decimal point.
    symmetric: if true, we will have the same number of values for positive
      and negative numbers.
    alpha: a tensor or None, the scaling factor per channel.
      If None, the scaling factor is 1 for all channels.
    keep_negative: if true, we do not clip negative numbers.
    use_stochastic_rounding: if true, we perform stochastic rounding.
    scale_axis: which axis to calculate scale from
    qnoise_factor: float. a scalar from 0 to 1 that represents the level of
      quantization noise to add. This controls the amount of the quantization
      noise to add to the outputs by changing the weighted sum of
      (1 - qnoise_factor)*unquantized_x + qnoise_factor*quantized_x.
    var_name: String or None. A variable name shared between the tf.Variables
      created in the build function. If None, it is generated automatically.
    use_ste: Bool. Whether to use "straight-through estimator" (STE) method or
        not.
    use_variables: Bool. Whether to make the quantizer variables to be dynamic
      tf.Variables or not.

    Args:
        bit_wide_list (list, optional): quantization distribution. Defaults to [8, 8, 8, 8, 8, 8, 8].
        NOT need find_absmax_weight as Arg qnoise_factor

    Returns:
        _type_: _description_
    """
    q_dict = {
        "conv1": {
            # 1 sign + or -
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[0] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[0] - 1)
        },
        "conv2": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[1] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[1] - 1)
        },
        "conv3": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[2] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[2] - 1)
        },
        "conv4": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[3] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[3] - 1)
        },
        "conv5": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[4] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[4] - 1)
        },
        "conv6": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[5] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[5] - 1)
        },
        "Dense1": {
            "kernel_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[6] - 1),
            "bias_quantizer":
            "quantized_bits({},0,1)".format(bit_wide_list[6] - 1)
        }
    }
    return q_dict


def converter(model, qmodel_path, BitWideList):
    """converter keras model to qkeras model

    Args:
        model (_type_): _description_
        qmodel_path (_type_): _description_
        BitWideList (_type_): quantization distribution
    """
    print('quantizing...')
    qmodel = model_quantize(model,
                            make_q_dict(BitWideList),
                            max(BitWideList),
                            transfer_weights=True)
    qkeras.utils.model_save_quantized_weights(qmodel,
                                              qmodel_path)  # only save weight
    netron.start(qmodel_path)
