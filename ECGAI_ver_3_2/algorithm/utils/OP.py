import math
import os
from typing import Union
import torch
import torch.nn as nn
import torch.nn.functional as F
from pytorch_quantization.nn.modules import _utils
from pytorch_quantization.tensor_quant import QuantDescriptor
from torch.autograd import Function
from torch.nn.common_types import _size_1_t
import torch.nn.quantized as nnq
import torch.nn.quantized.functional as Fq
import torch.quantization as qat
import pytorch_quantization

# -------------------------------------STE-----------------------------------
class BinarizeF(Function):

    @staticmethod
    def forward(ctx, input):
        # output = input.new(input.size())
        # output[input >= 0] = 1
        # output[input < 0] = -1
        ctx.save_for_backward(input)

        return input.sign()

    @staticmethod
    def backward(ctx, grad_output):
        # grad_input = grad_output.clone()
        input, = ctx.saved_tensors
        grad_input = grad_output.clone()
        grad_input.masked_fill_(input.ge(1) | input.le(-1), 0)
        return grad_input


# ---------------------------------(2/coshx) ^2--------------------------
class bcEstimator(Function):  # approx with (2/coshx) ^2 like in binaryConnect?
    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors
        grad_input = (2 / torch.cosh(input)) ** 2
        return grad_output * grad_input


# ---------------------------------tanhx--------------------------
class irEstimator(Function):  # approx with (2/coshx) ^2 like in binaryConnect?
    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors
        grad_input = 1 - torch.pow(torch.tanh(input), 2)
        return grad_output * grad_input


# ---------------------------------fft--------------------------
class fft_Estimator(Function):
    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors
        # grad_input = 0
        # for i in range(0, 10):
        #     grad_input += (4/torch.pi) * torch.cos(input=(2*i+1)*input)
        pi = torch.pi
        grad_input = (4 / pi) * (torch.cos(input=(2 * 0 + 1) * pi * input)
                                 # + torch.cos(input=(2 * 1 + 1) * pi * input)
                                 # +torch.cos(input=(2 * 2 + 1) * input) + torch.cos(input=(2 * 3 + 1) * input)
                                 # + torch.cos(input=(2 * 4 + 1) * input) + torch.cos(input=(2 * 5 + 1) * input)
                                 # + torch.cos(input=(2 * 6 + 1) * input) + torch.cos(input=(2 * 7 + 1) * input)
                                 )
        # grad_input = (pi / 2) * torch.cos((pi / 2) * grad_output)
        grad_input.masked_fill_(input.ge(1) | input.le(-1), 0)
        return grad_output * grad_input


# ---------------------------------2x+-x^2--------------------------
class BinaryActivation(nn.Module):
    def __init__(self):
        super(BinaryActivation, self).__init__()

    def forward(self, x):
        out_forward = torch.sign(x)
        # out_e1 = (x^2 + 2*x)
        # out_e2 = (-x^2 + 2*x)
        # out_e_total = 0
        mask1 = x < -1
        mask2 = x < 0
        mask3 = x < 1
        out1 = (-1) * mask1.type(torch.float32) + (x * x + 2 * x) * (1 - mask1.type(torch.float32))
        out2 = out1 * mask2.type(torch.float32) + (-x * x + 2 * x) * (1 - mask2.type(torch.float32))
        out3 = out2 * mask3.type(torch.float32) + 1 * (1 - mask3.type(torch.float32))
        out = out_forward.detach() - out3.detach() + out3

        return out


class IR_Estimator(Function):  # implementing BiRealNet paper approximation
    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors
        mask1 = (input >= -1) * 1
        mask2 = (input >= 0) * 1
        mask3 = (input >= 1) * 1

        grad_input = (mask1 - mask2) * (2 + 2 * input) + (mask2 - mask3) * (2 - 2 * input)
        # grad_input.masked_fill_(input.ge(1) | input.le(-1), 0)
        return grad_output * grad_input


binarize = BinarizeF.apply

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def bin_act(x):
    bin_act = torch.sign(x).detach()
    le_clip = x.lt(-1.0).type(torch.float32)
    ri_clip = x.ge(1.0).type(torch.float32)
    clip_l = torch.bitwise_and(x.ge(-1.0), x.lt(0.0))
    clip_r = torch.bitwise_and(x.ge(0.0), x.lt(1.0))
    cliped = clip_l * (2 + x) * x + clip_r * (2 - x) * x
    out = cliped + ri_clip - le_clip
    # out = torch.tanh(x)
    return bin_act + out - out.detach()


def bin_wei(x):
    bin_wei = torch.sign(x).detach()
    out = torch.tanh(x)
    return bin_wei + out - out.detach()


class BinActivation(nn.Module):
    def __init__(self):
        super(BinActivation, self).__init__()

    def forward(self, x):
        out = bin_wei(x)
        return out


import numpy as np
from scipy.stats import ortho_group


class BinaryConv1d_bw(nn.Conv1d):
    def __init__(self, in_channels: int, out_channels: int, kernel_size: _size_1_t, stride: _size_1_t = 1,
                 padding: Union[str, _size_1_t] = 0,
                 dilation: _size_1_t = 1,
                 groups: int = 1,
                 bias: bool = False,
                 padding_mode: str = 'zeros', ):
        super().__init__(in_channels, out_channels, kernel_size, stride=stride, padding=padding, dilation=dilation,
                         groups=groups, bias=bias, padding_mode=padding_mode)

    def forward(self, input):
        a = input
        w = self.weight
        # -------IR-Net--------
        # ba = IR_Estimator().apply(a)
        # bw = IR_Estimator().apply(w)
        # -------STE----------
        # if self.training:
        # ba = BinarizeF().apply(a)
        # np.savetxt(f'model_threhold_channel0.txt', a[:,0,:].cpu().to(torch.int8), fmt='%.0f')
        bw = BinarizeF().apply(w)
        # else:
        #     ba = torch.sign(a)
        #     bw = torch.sign(w)
        # -------2/coshx----------
        # ba = bcEstimator().apply(a)
        # bw = bcEstimator().apply(w)
        # -----------tanhx-----------
        # ba = irEstimator().apply(a)
        # bw = irEstimator().apply(w)
        # -----------fft-----------
        # ba = fft_Estimator().apply(a)
        # bw = fft_Estimator().apply(w)

        out = F.conv1d(input=a, weight=bw, bias=None, stride=self.stride,
                       padding=self.padding, dilation=self.dilation, groups=self.groups)

        return out


class BinaryConv1d_baw(nn.Conv1d):
    def __init__(self, in_channels: int, out_channels: int, kernel_size: _size_1_t, stride: _size_1_t = 1,
                 padding: Union[str, _size_1_t] = 0,
                 dilation: _size_1_t = 1,
                 groups: int = 1,
                 bias: bool = False,
                 padding_mode: str = 'zeros', ):
        super().__init__(in_channels, out_channels, kernel_size, stride=stride, padding=padding, dilation=dilation,
                         groups=groups, bias=bias, padding_mode=padding_mode)

    def forward(self, input):
        a = input
        w = self.weight
        # -------IR-Net--------
        # ba = IR_Estimator().apply(a)
        # bw = IR_Estimator().apply(w)
        # -------STE----------
        # if self.training:
        ba = BinarizeF().apply(a)
        # np.savetxt(f'./threhold/channel0_sign_out.txt', ba[:,0,].cpu().to(torch.int8),fmt='%.0f')
        bw = BinarizeF().apply(w)
        # else:
        #     ba = torch.sign(a)
        #     bw = torch.sign(w)
        # -------2/coshx----------
        # ba = bcEstimator().apply(a)
        # bw = bcEstimator().apply(w)
        # -----------tanhx-----------
        # ba = irEstimator().apply(a)
        # bw = irEstimator().apply(w)
        # -----------fft-----------
        # ba = fft_Estimator().apply(a)
        # bw = fft_Estimator().apply(w)

        out = F.conv1d(input=ba, weight=bw, bias=None, stride=self.stride,
                       padding=self.padding, dilation=self.dilation, groups=self.groups)

        return out


class Bn_bin_conv_pool_block_Float(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(out_channels)  # default eps = 1e-5, momentum = 0.1, affine = True
        # 无bias
        self.conv = nn.Conv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=padding,
                              bias=False, )
        self.relu = nn.ReLU()
        self.prelu = nn.PReLU()

        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

    def forward(self, I):
        I = self.conv(I)
        I = self.pool(I)
        I = self.relu(I)
        I = self.bn(I)
        return I


class Bn_bin_conv_pool_block_bw(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(out_channels)  # default eps = 1e-5, momentum = 0.1, affine = True
        # 无bias
        self.conv = BinaryConv1d_bw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                    bias=False)
        # self.relu = nn.ReLU()
        self.prelu = nn.PReLU()
        # self.htanh = nn.Hardtanh()
        # self.tanh = nn.Tanh()
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)
        # self.binarize = BinaryActivation()
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.prelu(I)
        I = self.bn(I)
        return I


class Bn_bin_conv_pool_block_bw(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(out_channels)  # default eps = 1e-5, momentum = 0.1, affine = True
        # 无bias
        self.conv = BinaryConv1d_bw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                    bias=False)
        # self.relu = nn.ReLU()
        self.prelu = nn.PReLU()
        # self.htanh = nn.Hardtanh()
        # self.tanh = nn.Tanh()
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)
        # self.binarize = BinaryActivation()
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.k = self.bn.weight / torch.sqrt(self.bn.running_var + self.bn.eps)
        self.b = self.bn.bias - self.bn.running_mean * self.bn.weight / torch.sqrt(
            self.bn.running_var + self.bn.eps)
        self.thre_plus = - self.b / self.k
        self.thre_minus = self.b / self.k * self.prelu.weight

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.prelu(I)
        I = self.bn(I)
        return I


class Bn_bin_conv_pool_block_baw(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.conv = BinaryConv1d_baw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                     bias=False)
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)
        self.prelu = nn.PReLU()
        self.bn = nn.BatchNorm1d(out_channels)

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.prelu(I)
        I = self.bn(I)
        return I


def convert_to_hex(arr):
    # Reshape array into (232, 4) array
    arr = arr.reshape(-1, 4)

    # Convert each row of 4 numbers into a single hex number
    hex_arr = np.apply_along_axis(lambda x: ''.join([str(i) for i in x]), axis=1, arr=arr)
    hex_arr = np.array([hex(int(i, 2))[2:].zfill(1) for i in hex_arr])

    return hex_arr

def Slide_data_save(tensor, filename):
    tensor[tensor == -1] = 0
    tensor = tensor.to(torch.int32)
    indices = []
    for i in range(0, tensor.shape[0] - 6, 1):
        indices.append(i)

    # Get the data in each convolution window
    data = []
    # tensor = tensor.reshape(1, 3610)
    for i in indices:
        data.append(tensor[i:i + 7].tolist())

    # Save the data to a txt file
    with open('temp.txt', 'w') as f:
        for d in data:
            f.write(str(d) + '\n')

    with open('temp.txt', "r") as f:
        lines = f.readlines()

    # 去除每行两侧的方括号和换行符，合并为一个字符串
    new_lines = ["".join(line.strip()[1:-1].split(",")).replace(" ", "") for line in lines]
    folder_path = os.path.abspath(os.path.join(os.getcwd(), ".", "Compare", "Block6_Slide_Data"))

    # 如果文件夹不存在，则创建它
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    file_path = os.path.join(folder_path, filename)
    # 将新的字符串写入文件
    with open(file_path, "w") as f:
        f.write("\n".join(new_lines))

    import fileinput

    # 遍历文件中的每一行数据
    for line in fileinput.input(file_path, inplace=True):
        # 去掉行尾的换行符
        line = line.strip()
        # 将二进制字符串转换为十进制整数
        dec = int(line, 2)
        # 将十进制整数转换为十六进制字符串，并补零
        hex_str = format(dec, '02x')
        # 输出转换后的十六进制字符串，并加上行尾的换行符
        print(hex_str, end='\n')

    # 关闭文件输入流
    fileinput.close()

def Conv_to_txt(conv_result, filename, I):
    # Assuming your tensor is named 'conv_result'
    channel_0 = conv_result[0, I, :].sign().to('cpu').to(torch.int32)  # Extract the 0th channel
    channel_0[channel_0 == -1] = 0
    zero_tensor = torch.zeros(9).to('cpu')
    channel_0 = torch.cat((channel_0, zero_tensor))
    # Convert to binary and then to hexadecimal
    # binary_values = np.vectorize(lambda x: format(np.int16(x) & 0xf, '04b'))(channel_0)
    # hex_values = np.vectorize(lambda x: hex(int(x, 2)))(binary_values)
    hex_values = np.vectorize(lambda x: format(int(np.int16(x) & 0xf), 'x'))(channel_0)
    hex_values = convert_to_hex(hex_values)
    # Reshape into groups of 8
    hex_values = hex_values.reshape((-1, 8))
    # 去掉空格
    # hex_values = np.apply_along_axis(lambda x: ''.join(x), 1, hex_values)
    # Save to file
    # 获取指定文件夹A的绝对路径
    folder_path = os.path.abspath(os.path.join(os.getcwd(), ".", "Compare", "Block6_Input_Binary"))

    # 如果文件夹不存在，则创建它
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    file_path = os.path.join(folder_path, filename)
    with open('temp.txt', 'w') as f:
        for row in hex_values:
            f.write(' '.join(row) + '\n')

    with open('temp.txt', "r") as f:
        lines = f.readlines()

    # 去除每行两侧的方括号和换行符，合并为一个字符串
    new_lines = ["".join(line.strip()).replace(" ", "") for line in lines]

    # 将新的字符串写入文件
    with open(file_path, "w") as f:
        f.write("\n".join(new_lines))

    os.remove('temp.txt')
class WeightOperation:
    def __init__(self, model):
        self.model = model
        self.count_group_weights = 0
        self.weight = []
        self.saved_weight = []  # 保存weight的原始数据
        self.saved_alpha = []
        self.binarize = BinaryActivation()
        for m in model.modules():
            if isinstance(m, nn.Conv1d) or isinstance(m, nn.Linear):
                self.count_group_weights += 1
                self.weight.append(m.weight)
                self.saved_weight.append(m.weight.data)

    def WeightSave(self):
        for index in range(self.count_group_weights):
            self.saved_weight[index].copy_(self.weight[index].data)  # 把weight的值给了saved_weight,而后进行binary等操作

    def alpha_extract(self):
        for m in self.model.modules():
            if isinstance(m, nn.Conv1d) or isinstance(m, nn.Linear):
                self.saved_alpha.append(m.alpha)

    def WeightBinarize(self):
        for index in range(self.count_group_weights):
            self.weight[index].data = binarize(self.weight[index].data)  # 对应原model中的值也会跟着改变

    def WeightRestore(self):
        for index in range(self.count_group_weights):
            self.weight[index].data.copy_(self.saved_weight[index])

    def WeightGradient(self):
        for index in range(self.count_group_weights):
            self.weight[index].grad.data = self.weight[index].grad.data * self.saved_alpha[
                index].data.detach().transpose(0, 1)


class BinaryQuantize(Function):
    @staticmethod
    def forward(ctx, input):
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        grad_input = grad_output.clone()
        return grad_input


class BinaryQuantize_a(Function):
    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        out = torch.sign(input)
        return out

    @staticmethod
    def backward(ctx, grad_output):
        input = ctx.saved_tensors[0]
        grad_input = (2 - torch.abs(2 * input))
        grad_input = grad_input.clamp(min=0) * grad_output.clone()
        return grad_input


class BinActive(nn.Module):
    def __init__(self):
        super(BinActive, self).__init__()
        self.hardtanh = nn.Hardtanh()

    def forward(self, input):
        output = self.hardtanh(input)
        output = binarize(output)
        return output


class Threshold(nn.Module):
    def __init__(self, num_channels):
        super().__init__()
        self.num_channels = num_channels
        self.threshold_plus = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        self.threshold_minus = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        self.threshold_plus_sign = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        self.threshold_minus_sign = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        # self.quant = torch.quantization.QuantStub()
        # self.dequant = torch.quantization.DeQuantStub()
        # self.quan_plus = 1
        # self.threshold_plus = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        # self.threshold_minus = nn.Parameter(torch.ones(size=[num_channels]), requires_grad=False)
        # self.qconifg = qconfig
        # self.weight_fake_quant = qconfig.weight()

    def forward(self, x):
        # x = self.quant(x)
        # assert x.size(1) == self.num_channels, f"Expected {self.num_channels} channels, but got {x.size(1)}"
        # Apply thresholding to each channel
        output = []
        # self.quan_plus = self.threshold_plus
        # self.quan_plus = self.quant(self.threshold_plus)
        # self.quan_minus = self.threshold_minus
        # self.quan_minus = self.quant(self.threshold_minus)

        for i in range(self.num_channels):
            channel = x[:, i, :]
            # self.threshold_plus[i] = self.quant(self.threshold_plus[i])
            # self.threshold_minus[i] = self.quant(self.threshold_minus[i])
            p_sign = self.threshold_plus_sign[i]
            m_sign = self.threshold_minus_sign[i]
            channel_output = torch.where(channel >= 0, torch.where(2 * channel > 2 * self.threshold_plus[i], p_sign * torch.tensor(1.0),
                                                                   p_sign * torch.tensor(-1.0)),
                                         torch.where(2 * channel > 2 * self.threshold_minus[i], m_sign * torch.tensor(1.0),
                                                     m_sign * torch.tensor(-1.0)))
            output.append(channel_output)

        # self.dequant(self.threshold_plus[i])
        # self.dequant(self.threshold_minus[i])

        # for i in range(self.num_channels):
        #     channel = x[:, i, :]
        #     # self.threshold_p = self.quant(self.threshold_plus[i])
        #     threshold_p = self.threshold_plus[i]
        #     threshold_m = self.threshold_minus[i]
        #     p_sign = self.threshold_plus_sign[i]
        #     m_sign = self.threshold_minus_sign[i]
        #     channel_output = torch.where(channel >= 0, torch.where(channel > self.threshold_p, p_sign * torch.tensor(1.0),
        #                    p_sign * torch.tensor(-1.0)),
        #                     torch.where(channel > threshold_m, m_sign * torch.tensor(1.0),
        #                      m_sign * torch.tensor(-1.0)))
        #     output.append(channel_output)
        # Stack the thresholded channels along the channel dimension
        output = torch.stack(output, dim=1)
        # output = self.dequant(output)
        return output


# torch.quantization.get_default_dynamic_quant_module_mappings.register_qat_module_mapping(Custom, Threshold)
class Bn_bin_conv_pool_block_baw_Threshold(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.conv = BinaryConv1d_baw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                     bias=False)
        # self.conv = nn.Conv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
        #                       bias=False)
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

        self.threhold = Threshold(num_channels=out_channels)
        # self.kx_plus_b = PBnKxPlusB(num_channels=out_channels)
        # self.bn_kbx = BnKxPlusB(num_channels=out_channels)
        self.prelu = nn.PReLU()
        self.bn = nn.BatchNorm1d(out_channels)
        # self.quant = torch.quantization.QuantStub()
        # self.dequant = torch.quantization.DeQuantStub()

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.threhold(I)
        # I = self.prelu(I)
        # I = self.bn(I)
        return I


class Bn_bin_conv_pool_block_bw_Threshold(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.conv = BinaryConv1d_bw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                    bias=False)
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

        self.threhold = Threshold(num_channels=out_channels)
        self.kx_plus_b = PBnKxPlusB(num_channels=out_channels)
        self.bn_kbx = BnKxPlusB(num_channels=out_channels)
        self.prelu = nn.PReLU()
        self.bn = nn.BatchNorm1d(out_channels)

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.threhold(I)
        return I


class Bn_bin_conv_pool_block_baw_akx_plus_b(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.conv = BinaryConv1d_baw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                     bias=False)
        # self.conv = nn.Conv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
        #                       bias=False)
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

        # self.threhold = Threshold(num_channels=out_channels)
        self.kx_plus_b = PBnKxPlusB(num_channels=out_channels)
        # self.bn_kbx = BnKxPlusB(num_channels=out_channels)
        self.prelu = nn.PReLU()
        self.bn = nn.BatchNorm1d(out_channels)
        # self.quant = torch.quantization.QuantStub()
        # self.dequant = torch.quantization.DeQuantStub()

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.kx_plus_b(I)
        # I = self.prelu(I)
        # I = self.bn(I)
        return I


import torch
import torch.nn as nn


class PBnKxPlusB(nn.Module,  _utils.QuantMixin):
    def __init__(self, num_channels, **kwargs):
        super(PBnKxPlusB, self).__init__()
        # quant_desc_input, quant_desc_weight = _utils.pop_quant_desc_in_kwargs(self.__class__, **kwargs)
        quant_desc_input = QuantDescriptor(num_bits=10)
        quant_desc_weight = QuantDescriptor(num_bits=10,)
        self.init_quantizer(quant_desc_input, quant_desc_weight)
        # self.init_quantizer(quant_desc_weight)

        self.num_channels = num_channels
        self.k = nn.Parameter(torch.ones(num_channels))
        self.b = nn.Parameter(torch.zeros(num_channels))
        self.a = nn.Parameter(torch.ones(num_channels))
        self.ak = nn.Parameter(torch.ones(num_channels))
        self.k_ak_b = nn.Parameter(torch.ones(3 * num_channels))
        # self.quant = torch.ao.quantization.QuantStub()
        # self.dequant = torch.ao.quantization.DeQuantStub()

    def forward(self, x):
        # x = self.quant(x)

        # y = torch.where(x >= 0, self.k.unsqueeze(0).unsqueeze(2) * x + self.b.unsqueeze(0).unsqueeze(2),
        #                 self.ak.unsqueeze(0).unsqueeze(2) * x + self.b.unsqueeze(0).unsqueeze(2))
        #****************************Normal****************************

        ge_sum = torch.sum(torch.relu(x), dim=2)
        le_sum = torch.sum(-torch.relu(-x), dim=2)
        y = ge_sum * self.k_ak_b[0:5] + le_sum * self.k_ak_b[5:10] + 27 * self.k_ak_b[10:15]


        #****************************Quan_try****************************
        # quant_x = x
        # quant_x = self._input_quantizer(x)
        # quant_k = self._weight_quantizer(self.k)
        # quant_ak = self._weight_quantizer(self.ak)
        # quant_b = self._weight_quantizer(self.b)
        # quant_ge_sum = torch.sum(torch.relu(quant_x), dim=2)
        # quant_le_sum = torch.sum(-torch.relu(-quant_x), dim=2)
        # y = quant_ge_sum * quant_k + quant_le_sum * quant_ak + 27 * quant_b
        #***************************一起量化以获得相同scale的数********************8
        # quant_x = self._input_quantizer(x)
        # quant_k_ak_b = self._weight_quantizer(self.k_ak_b)
        # quant_ge_sum = torch.sum(torch.relu(quant_x), dim=2)
        # quant_le_sum = torch.sum(-torch.relu(-quant_x), dim=2)
        # y = quant_ge_sum * quant_k_ak_b[0:5] + quant_le_sum * quant_k_ak_b[5:10] + 27 * quant_k_ak_b[10:15]
        return y

    @property
    def input_quantizer(self):
        return self._input_quantizer

    @property
    def weight_quantizer(self):
        return self._weight_quantizer



class BnKxPlusB(nn.Module):
    def __init__(self, num_channels):
        super(BnKxPlusB, self).__init__()
        self.num_channels = num_channels
        self.k = torch.ones(1, num_channels, 1)
        self.b = torch.zeros(1, num_channels, 1)

    def forward(self, x):
        # x has shape (batch_size, num_channels, sequence_length)
        # expand k and b to match the shape of x
        k = self.k.unsqueeze(0).unsqueeze(2)
        b = self.b.unsqueeze(0).unsqueeze(2)
        y = k * x + b

        return y


class Bn_bin_conv_pool_block_kx_plus_b(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        self.conv = BinaryConv1d_bw(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                    bias=False)
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

        self.prelu = nn.PReLU()
        self.kx_plus_b = PBnKxPlusB(num_channels=out_channels)
        self.bn_kbx = BnKxPlusB(num_channels=out_channels)
        self.bn = nn.BatchNorm1d(out_channels)

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.prelu(I)
        I = self.bn(I)
        return I
