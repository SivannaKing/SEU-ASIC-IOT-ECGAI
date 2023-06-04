import torch
import torch.nn as nn
import torch.optim as optim

import utils.OP
from utils.model import ECG_XNOR_Full_Bin, ECG_XNOR_Full_Ori, ECG_XNOR_Full_Thre, ECG_XNOR_Full_akx_plus_b
from utils.dataset import Loader
from utils.engine import train
from utils.save_model import save_model
from utils.OP import WeightOperation

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
# device = torch.device('cpu')
import numpy as np
import random
import copy
import os

def prepare_model(classes_num, model):
    test_size = 0.2
    if classes_num == 17:
        batch_size = 64
        lr = 0.002
        seed = 142
    else:
        batch_size = 512
        lr = 0.02
        seed = 101  # 101

    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)

    loader = Loader(batch_size=batch_size, classes_num=classes_num, device=device, test_size=test_size)
    labels, train_loader, test_loader = loader.loader()
    # in_channels, out_channels,    kernel_size,     stride,    padding,   pad_value,   pool_size,  pool_stride
    kernel_size, padding, poolsize = 7, 5, 7
    padding_value = 1
    A = [[1, 8, kernel_size, 2, padding, padding_value, poolsize, 2],
         [8, 16, kernel_size, 1, padding, padding_value, poolsize, 2],
         [16, 32, kernel_size, 1, padding, padding_value, poolsize, 2],
         [32, 32, kernel_size, 1, padding, padding_value, poolsize, 2],
         [32, 64, kernel_size, 1, padding, padding_value, poolsize, 2],
         [64, classes_num, kernel_size, 1, padding, padding_value, poolsize, 2],
         ]

    model = model(block1=A[0], block2=A[1], block3=A[2], block4=A[3],
                  block5=A[4] if len(A) > 4 else None,
                  block6=A[5] if len(A) > 5 else None,
                  block7=A[6] if len(A) > 6 else None,
                  device=device).to(device)
    loss_fn = nn.CrossEntropyLoss().to(device)
    optimizer = optim.Adam(model.parameters(), lr=lr)
    weightOperation = WeightOperation(model)

    return loader, train_loader, test_loader, model, loss_fn, optimizer, weightOperation


def int_to_signed_bit(n, num_of_bits):
    if n < -2 ** (num_of_bits - 1) or n > (2 ** (num_of_bits - 1) - 1):
        raise ValueError("Integer out of range")
    if n < 0:
        # Two's complement of negative number
        binary = bin((1 << num_of_bits) + n)[2:]
    else:
        binary = bin(n)[2:].zfill(num_of_bits)
    return binary


def tensor_to_signed_bits_file(tensor1, tensor2, plus_sign, minus_sign, filename, num_ot_bits):
    plus_sign[plus_sign > 0] = 1
    minus_sign[minus_sign < 0] = 0
    with open(filename, 'w') as file:
        for n1, n2, sign1, sign2 in zip(tensor1.to(torch.int16).tolist(), tensor2.to(torch.int16).tolist(),
                                        plus_sign.to(torch.int16).tolist(), minus_sign.to(torch.int16).tolist()):
            binary_1 = int_to_signed_bit(n1, num_of_bits=num_ot_bits)
            binary_2 = int_to_signed_bit(n2, num_of_bits=num_ot_bits)
            file.write(str(sign1) + binary_1 + str(sign2) + binary_2 + '\n')

def folder_txt_to_coe(input_folder, output_folder):
    for filename in os.listdir(input_folder):
        if filename.endswith(".txt"):
            with open(os.path.join(input_folder, filename), "r") as txt_file:
                data = txt_file.read()
                data = data.replace("_", "")
                data = data.replace("\n", "")
                coe_filename = filename.replace(".txt", ".coe")
                with open(os.path.join(output_folder, coe_filename), "w") as coe_file:
                    coe_file.write("memory_initialization_radix=2;\nmemory_initialization_vector=\n")
                    for i in range(0, len(data), 24):
                        coe_file.write(data[i:i+24] + ",\n")
                    coe_file.write(";")

def calcu_threhold(model_best, model_target):
    block1_k = model_best.block1.bn.weight / torch.sqrt(model_best.block1.bn.running_var + model_best.block1.bn.eps)
    block1_b = model_best.block1.bn.bias - (
            model_best.block1.bn.running_mean * model_best.block1.bn.weight) / torch.sqrt(
        model_best.block1.bn.running_var + model_best.block1.bn.eps)
    block1_ak = model_best.block1.prelu.weight * block1_k
    block1_threshold_plus_sign = torch.sign(block1_k)
    block1_threshold_minus_sign = torch.sign(block1_ak)
    block1_thre_plus = - block1_b / block1_k
    block1_thre_minus = - block1_b / block1_ak
    block1_thre_plus = block1_thre_plus.ceil() - 0.5
    block1_thre_minus = block1_thre_minus.ceil() - 0.5

    block2_k = model_best.block2.bn.weight / torch.sqrt(model_best.block2.bn.running_var + model_best.block2.bn.eps)
    block2_b = model_best.block2.bn.bias - (
            model_best.block2.bn.running_mean * model_best.block2.bn.weight) / torch.sqrt(
        model_best.block2.bn.running_var + model_best.block2.bn.eps)
    block2_ak = model_best.block2.prelu.weight * block2_k
    block2_threshold_plus_sign = torch.sign(block2_k)
    block2_threshold_minus_sign = torch.sign(block2_ak)
    block2_thre_plus = - block2_b / block2_k
    block2_thre_minus = - block2_b / block2_ak
    block2_thre_plus = block2_thre_plus.ceil() - 0.5
    block2_thre_minus = block2_thre_minus.ceil() - 0.5

    block3_k = model_best.block3.bn.weight / torch.sqrt(model_best.block3.bn.running_var + model_best.block3.bn.eps)
    block3_b = model_best.block3.bn.bias - (
            model_best.block3.bn.running_mean * model_best.block3.bn.weight) / torch.sqrt(
        model_best.block3.bn.running_var + model_best.block3.bn.eps)
    block3_ak = model_best.block3.prelu.weight * block3_k
    block3_threshold_plus_sign = torch.sign(block3_k)
    block3_threshold_minus_sign = torch.sign(block3_ak)
    block3_thre_plus = - block3_b / block3_k
    block3_thre_minus = - block3_b / block3_ak
    block3_thre_plus = block3_thre_plus.ceil() - 0.5
    block3_thre_minus = block3_thre_minus.ceil() - 0.5

    block4_k = model_best.block4.bn.weight / torch.sqrt(model_best.block4.bn.running_var + model_best.block4.bn.eps)
    block4_b = model_best.block4.bn.bias - (
            model_best.block4.bn.running_mean * model_best.block4.bn.weight) / torch.sqrt(
        model_best.block4.bn.running_var + model_best.block4.bn.eps)
    block4_ak = model_best.block4.prelu.weight * block4_k
    block4_threshold_plus_sign = torch.sign(block4_k)
    block4_threshold_minus_sign = torch.sign(block4_ak)
    block4_thre_plus = - block4_b / block4_k
    block4_thre_minus = - block4_b / block4_ak
    block4_thre_plus = block4_thre_plus.ceil() - 0.5
    block4_thre_minus = block4_thre_minus.ceil() - 0.5

    block5_k = model_best.block5.bn.weight / torch.sqrt(model_best.block5.bn.running_var + model_best.block5.bn.eps)
    block5_b = model_best.block5.bn.bias - (
            model_best.block5.bn.running_mean * model_best.block5.bn.weight) / torch.sqrt(
        model_best.block5.bn.running_var + model_best.block5.bn.eps)
    block5_ak = model_best.block5.prelu.weight * block5_k
    block5_threshold_plus_sign = torch.sign(block5_k)
    block5_threshold_minus_sign = torch.sign(block5_ak)
    block5_thre_plus = - block5_b / block5_k
    block5_thre_minus = - block5_b / block5_ak
    block5_thre_plus = block5_thre_plus.ceil() - 0.5
    block5_thre_minus = block5_thre_minus.ceil() - 0.5

    block6_k = model_best.block6.bn.weight / torch.sqrt(model_best.block6.bn.running_var + model_best.block6.bn.eps)
    block6_b = model_best.block6.bn.bias - (
            model_best.block6.bn.running_mean * model_best.block6.bn.weight) / torch.sqrt(
        model_best.block6.bn.running_var + model_best.block6.bn.eps)

    model_target.block1.threhold.threshold_plus.data = block1_thre_plus
    model_target.block1.threhold.threshold_minus.data = block1_thre_minus
    model_target.block1.threhold.threshold_plus_sign.data = block1_threshold_plus_sign
    model_target.block1.threhold.threshold_minus_sign.data = block1_threshold_minus_sign
    # model_target.block1.kx_plus_b.k = block1_k
    # model_target.block1.kx_plus_b.b = block1_b
    # model_target.block1.kx_plus_b.a = model_best.block1.prelu.weight
    # model_target.block1.bn_kbx.k = block1_k
    # model_target.block1.bn_kbx.b = block1_b
    model_target.block1.bn = model_best.block1.bn
    model_target.block1.prelu.weight = model_best.block1.prelu.weight
    model_target.block1.conv.weight.data = model_best.block1.conv.weight.sign()

    model_target.block2.threhold.threshold_plus.data = block2_thre_plus
    model_target.block2.threhold.threshold_minus.data = block2_thre_minus
    model_target.block2.threhold.threshold_plus_sign.data = block2_threshold_plus_sign
    model_target.block2.threhold.threshold_minus_sign.data = block2_threshold_minus_sign
    # model_target.block2.kx_plus_b.k = block2_k
    # model_target.block2.kx_plus_b.b = block2_b
    # model_target.block2.kx_plus_b.a = model_best.block2.prelu.weight
    # model_target.block2.bn_kbx.k = block2_k
    # model_target.block2.bn_kbx.b = block2_b
    model_target.block2.bn = model_best.block2.bn
    model_target.block2.prelu.weight = model_best.block2.prelu.weight
    model_target.block2.conv.weight.data = model_best.block2.conv.weight.sign()

    model_target.block3.threhold.threshold_plus.data = block3_thre_plus
    model_target.block3.threhold.threshold_minus.data = block3_thre_minus
    model_target.block3.threhold.threshold_plus_sign.data = block3_threshold_plus_sign
    model_target.block3.threhold.threshold_minus_sign.data = block3_threshold_minus_sign
    # model_target.block3.kx_plus_b.k = block3_k
    # model_target.block3.kx_plus_b.b = block3_b
    # model_target.block3.kx_plus_b.a = model_best.block3.prelu.weight
    # model_target.block3.bn_kbx.k = block3_k
    # model_target.block3.bn_kbx.b = block3_b

    model_target.block3.conv.weight.data = model_best.block3.conv.weight.sign()
    model_target.block3.bn = model_best.block3.bn
    model_target.block3.prelu.weight = model_best.block3.prelu.weight

    model_target.block4.threhold.threshold_plus.data = block4_thre_plus
    model_target.block4.threhold.threshold_minus.data = block4_thre_minus
    model_target.block4.threhold.threshold_plus_sign.data = block4_threshold_plus_sign
    model_target.block4.threhold.threshold_minus_sign.data = block4_threshold_minus_sign
    # model_target.block4.kx_plus_b.k = block4_k
    # model_target.block4.kx_plus_b.b = block4_b
    # model_target.block4.kx_plus_b.a = model_best.block4.prelu.weight
    # model_target.block4.bn_kbx.k = block4_k
    # model_target.block4.bn_kbx.b = block4_b

    model_target.block4.conv.weight.data = model_best.block4.conv.weight.sign()
    model_target.block4.bn = model_best.block4.bn
    model_target.block4.prelu.weight = model_best.block4.prelu.weight

    model_target.block5.threhold.threshold_plus.data = block5_thre_plus
    model_target.block5.threhold.threshold_minus.data = block5_thre_minus
    model_target.block5.threhold.threshold_plus_sign.data = block5_threshold_plus_sign
    model_target.block5.threhold.threshold_minus_sign.data = block5_threshold_minus_sign
    # model_target.block5.kx_plus_b.k = block5_k
    # model_target.block5.kx_plus_b.b = block5_b
    # model_target.block5.kx_plus_b.a = model_best.block5.prelu.weight
    # model_target.block5.bn_kbx.k = block5_k
    # model_target.block5.bn_kbx.b = block5_b

    model_target.block5.conv.weight.data = model_best.block5.conv.weight.sign()
    model_target.block5.bn = model_best.block5.bn
    model_target.block5.prelu.weight = model_best.block5.prelu.weight

    model_target.block6.kx_plus_b.k.data = block6_k
    model_target.block6.kx_plus_b.b.data = block6_b
    model_target.block6.kx_plus_b.a.data = model_best.block6.prelu.weight
    model_target.block6.kx_plus_b.ak.data = block6_k * model_best.block6.prelu.weight
    model_target.block6.kx_plus_b.k_ak_b.data = torch.cat(
        [block6_k, block6_k * model_best.block6.prelu.weight, block6_b], dim=0)
    # 91.28%
    # 精度损失0.14%
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([82., 426., 319., 306., 604., 18., 92., 69., 66.,
    #                                                           131., -8191., 2166., 962., -5244., -2428.])
    # scale = 947.2757
    # 91.60%
    # 精度无损:
    # 14bit
    model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([399., 711., 651., 671., 1066., 142., 253., 231., 238.,
                                                              379., 2672., 2937., -1557., -8191., -7765.]) #91.60%
    # 8bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([6., 11., 10., 10., 17., 2., 4., 4., 4., 6.,
    #                                                           41., 46., -24., -127., -120.]) #90.76
    # 9bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([12., 22., 20., 21., 33., 4., 8., 7., 7., 12.,
    #                                                           83., 91., -48., -255., -242.]) #91.14%
    # 10bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([25., 44., 41., 42., 66., 9., 16., 14., 15., 24.,
    #                                                           167., 183., -97., -511., -484.]) #91.40%
    # 11bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([50., 89., 81., 84., 133., 18., 32., 29., 30.,
    #                                                           47., 334., 367., -195., -1023., -970.]) #91.53%
    # 12bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([100., 178., 163., 168., 266., 35., 63., 58., 60.,
    #                                                           95., 668., 734., -389., -2047., -1941.]) #91.40%
    # 13bit
    # model_target.block6.kx_plus_b.k_ak_b.data = torch.tensor([199., 356., 325., 335., 533., 71., 126., 116., 119.,
    #                                                           189., 1336., 1468., -779., -4095., -3882.]) #91.53%
    # model_target.block6.bn_kbx.k = block6_k
    # model_target.block6.bn_kbx.b = block6_b

    model_target.block6.conv.weight.data = model_best.block6.conv.weight.sign()
    model_target.block6.bn = model_best.block6.bn
    model_target.block6.prelu.weight = model_best.block6.prelu.weight

    # threhold_path = os.path.abspath(os.path.join(os.getcwd(), "Data", "9160", "Threhold"))
    # threhold_coe_path = os.path.abspath(os.path.join(os.getcwd(), "Data", "9160", "Threhold_Coe"))
    # for i in range(1, 6):
    #     block_thre_plus = locals()[f"block{i}_thre_plus"]
    #     block_thre_minus = locals()[f"block{i}_thre_minus"]
    #     block_thre_plus_sign = locals()[f"block{i}_threshold_plus_sign"]
    #     block_thre_minus_sign = locals()[f"block{i}_threshold_minus_sign"]
    #     variables = {"tensor1": block_thre_plus * 2,
    #                  "tensor2": block_thre_minus * 2,
    #                  "plus_sign": block_thre_plus_sign,
    #                  "minus_sign": block_thre_minus_sign}
    #     # tensor_to_signed_bits_file(block_thre_plus * 2, block_thre_minus * 2, block_thre_plus_sign, block_thre_minus_sign , f"{threhold_path}/block{i}_thre.txt", num_ot_bits=10)
    #     tensor_to_signed_bits_file(**variables, filename=f"{threhold_path}/block{i}_thre.txt", num_ot_bits=11)
    # folder_txt_to_coe(threhold_path, threhold_coe_path)
    return model_target


def acc_cal(model, test_loader):
    model.eval()
    test_loss, test_acc = 0, 0
    correct, total = 0, 0
    # Turn on inference context manager
    with torch.inference_mode():
        # Loop through DataLoader batches
        for (X, y) in test_loader:
            # Send data to target device
            X, y = X.to(device).sign(), y.to(device)

            # 1. Forward pass
            test_pred_logits = model(X)
            # 2. Calculate and accumulate loss
            loss = loss_fn(test_pred_logits, y)

            test_loss += loss.item()

            _, predicted = torch.max(test_pred_logits.data, dim=1)
            total += len(y)
            correct += (predicted == y).sum().cpu().item()
    # Adjust metrics to get average loss and accuracy per batch
    test_acc = correct / total
    print(test_acc)
    return test_acc


def calibrate(model, data_loader):  # 校准功能函数
    model.eval()
    with torch.no_grad():
        for image, target in data_loader:
            model(image)


def FX_PTQ(float_model, data_loader, data_loader_test):
    from torch.ao.quantization import get_default_qconfig
    from torch.ao.quantization.quantize_fx import prepare_fx, convert_fx
    from torch.ao.quantization import QConfigMapping

    float_model.eval()

    model_to_quantize = copy.deepcopy(float_model)
    model_to_quantize.eval()

    # The old 'fbgemm' is still available but 'x86' is the recommended default.
    qconfig = get_default_qconfig("x86")
    qconfig_mapping = QConfigMapping().set_global(qconfig)

    # qconfig_mapping = (QConfigMapping()
    #                    .set_global(None)  # qconfig_opt is an optional qconfig, either a valid qconfig or None
    #                    # .set_object_type(torch.nn.Conv2d, qconfig_opt)  # can be a callable...
    #                    .set_object_type("BinaryConv1d_baw", None)
    #                    .set_object_type("PBnKxPlusB", qconfig)
    #                    .set_object_type("Threshold", qconfig)  # ...or a string of the class name
    #                    # .set_module_name_regex("BinaryConv1d_baw",
    #                    #                        valid)  # matched in order, first match takes precedence
    #                    # .set_module_name("foo.bar", qconfig_opt)
    #                    # .set_module_name_object_type_order()
    #                    )
    # qconfig_mapping = QConfigMapping().set_module_name("block6.kx_plus_b", qconfig)
    # qconfig_mapping = QConfigMapping().set_global(torch.ao.quantization.default_dynamic_qconfig)
    # priority (in increasing order): global, object_type, module_name_regex, module_name
    # qconfig == None means fusion and quantization should be skipped for anything
    # matching the rule (unless a higher priority match is found)
    example_inputs = (next(iter(data_loader))[0])  # get an example input
    prepared_model = prepare_fx(float_model, qconfig_mapping, example_inputs)  # fuse modules and insert observers
    prepared_model.block1.conv.qconfig = None
    prepared_model.block2.conv.qconfig = None
    prepared_model.block3.conv.qconfig = None
    prepared_model.block4.conv.qconfig = None
    prepared_model.block5.conv.qconfig = None
    prepared_model.block6.conv.qconfig = None
    calibrate(prepared_model, data_loader_test)  # run calibration on sample data
    quantized_model = convert_fx(prepared_model)  # convert the calibrated model to a quantized model
    acc_cal(quantized_model, test_loader)


def PTDQ(float_model, data_loader_test):
    model_int8 = torch.ao.quantization.quantize_dynamic(
        float_model,  # the original model
        {nn.Conv1d},  # a set of layers to dynamically quantize
        dtype=torch.qint8)

    acc = acc_cal(model_int8, data_loader_test)
    return print(acc)


def PTSQ(float_model, data_loader, data_loader_test):
    float_model.eval()
    # float_model.qconfig = torch.ao.quantization.get_default_qconfig('x86')
    # float_model.block1.threhold.qconfig = torch.ao.quantization.get_default_qconfig('x86')
    from torch.quantization.quantize import add_quant_dequant

    float_model = add_quant_dequant(float_model.block6.kx_plus_b)
    model_fp32_prepared = torch.ao.quantization.prepare(float_model)
    example_inputs = (next(iter(data_loader))[0])
    model_fp32_prepared(example_inputs)
    model_int8 = torch.ao.quantization.convert(model_fp32_prepared)
    acc = acc_cal(model_int8, data_loader_test)
    return print(acc)


def NvidiaQ(float_model, data_loader, data_loader_test):
    model = float_model
    from pytorch_quantization.tensor_quant import QuantDescriptor
    from pytorch_quantization.nn.modules.tensor_quantizer import TensorQuantizer

    # quant_desc = QuantDescriptor(num_bits=13, fake_quant=False, axis=(1), unsigned=False)
    # model.block6.quant_desc_input = quant_desc
    # model.block6.quant_desc_weight = quant_desc
    # quantizer = TensorQuantizer(quant_desc)
    for name, module in model.named_modules():
        if name.endswith('_input_quantizer'):
            module.enable_calib()
            module.disable_quant()  # Use full precision data to calibrate

    example_inputs = (next(iter(data_loader))[0])
    model(example_inputs)
    model.cuda()
    for name, module in model.named_modules():
        if name.endswith('_input_quantizer'):
            module.load_calib_amax()
            module.enable_quant()

    model(loader.test_dataset[0][0].unsqueeze(0))
    acc_cal(model, data_loader_test)


if __name__ == "__main__":
    # ***************************************准备要量化的模型***************************************
    classes_num = 5
    num_epochs = 1000
    model_best = torch.load(f'./models/ECG_Net_for_5_91.60%.pth', map_location=device)
    model_best.device = device
    # model_best = torch.load(f'./models/ECG_Net_for_17_97.50%.pth')
    loader, train_loader, test_loader, model_target, loss_fn, optimizer, weightOperation = prepare_model(
        classes_num=classes_num,
        model=ECG_XNOR_Full_akx_plus_b)
    model_done = calcu_threhold(model_best, model_target).to(device)
    model_done.device = device
    # acc_cal(model_done, test_loader)
    # test_acc(model_best, test_loader)
    # model_best(loader.test_dataset[0][0].unsqueeze(0))
    model_done(loader.test_dataset[0][0].unsqueeze(0))
    # ********************************************EagerPTQ********************************************

    # ***********************************************PTDQ***********************************************
    # PTDQ(float_model=model_done, data_loader_test=test_loader)
    # 失败，Conv1d都没量化

    # ***********************************************PTSQ***********************************************
    # PTSQ(float_model=model_done, data_loader=train_loader, data_loader_test=test_loader)

    # ***********************************************FXPTQ***********************************************
    # FX_PTQ(model_done, train_loader, test_loader)
    # 结果：仅仅Conv被量化为了int8,未能识别threhold与kx+b

    # **********************************************NvidiaQ**********************************************
    # NvidiaQ(model_done, train_loader, test_loader)
    # acc_cal(model_done, test_loader)
