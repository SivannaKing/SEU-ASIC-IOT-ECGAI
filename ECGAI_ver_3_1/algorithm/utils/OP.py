import torch
import torch.nn as nn
import torch.nn.functional as F
from typing import Union
from torch.autograd import Function
from torch.nn.common_types import _size_1_t
from tqdm.contrib import itertools

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

# -------------------------------------STE-----------------------------------
class BinarizeF(Function):

    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        return input.sign()

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors
        grad_input = grad_output.clone()
        grad_input.masked_fill_(input.ge(1) | input.le(-1), 0)
        return grad_input

        return out

# 定义二值化操作
binarize = BinarizeF.apply

# 对权重、激活、卷积值同时进行二值化
class BinaryConv1d(nn.Conv1d):
    def __init__(self, in_channels: int, out_channels: int, kernel_size: _size_1_t, stride: _size_1_t = 1,
                 padding: Union[str, _size_1_t] = 0,
                 dilation: _size_1_t = 1,
                 groups: int = 1,
                 bias: bool = False,
                 padding_mode: str = 'zeros', ):
        super().__init__(in_channels, out_channels, kernel_size, stride=stride, padding=padding, dilation=dilation,
                         groups=groups, bias=bias, padding_mode=padding_mode)
    def forward(self, input):
        w = self.weight
        if self.in_channels == 1:
            ba = input # 第一次输入不进行二值化
        else:
            ba = BinarizeF().apply(input) #二值化
        bw = BinarizeF().apply(w)
        out = F.conv1d(input=ba, weight=bw, bias=None, stride=self.stride,
                       padding=self.padding, dilation=self.dilation, groups=self.groups)
        return out
# Naive-BNN基本块
class Bn_bin_conv_pool(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size,
                 pool_stride, ):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(out_channels)


        # pad
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        # 无bias,一维卷积
        self.conv = BinaryConv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=0,
                                 bias=False)
        # MaxPool
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)
        # ACT
        self.relu = nn.ReLU()
        self.prelu = nn.PReLU()
        self.tanh = nn.Tanh()
        self.htanh = nn.Hardtanh()
        # self.tanh = nn.Tanh()

    def forward(self, I):
        I = self.pad(I)
        I = self.conv(I)
        I = self.pool(I)
        I = self.prelu(I)
        I = self.bn(I)
        return I

