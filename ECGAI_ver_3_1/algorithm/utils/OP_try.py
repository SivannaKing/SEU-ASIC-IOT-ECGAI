from torch.autograd import Function
import torch.nn.functional as F
import torch
import torch.nn as nn
import math




class BinarizeF(Function):

    @staticmethod
    def forward(ctx, input):
        output = input.new(input.size())
        output[input >= 0] = 1
        output[input < 0] = -1
        return output

    @staticmethod
    def backward(ctx, grad_output):
        grad_input = grad_output.clone()
        # TODO 加下面这两句效果如何？
        # grad_input[input.ge(1)] = 0  # ge: greater or equal
        # grad_input[input.le(-1)] = 0  # le: less or equal
        return grad_input


binarize = BinarizeF.apply

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


class BinaryLinear(nn.Linear):

    def forward(self, input):

        out = F.linear(input, self.weight)
        if self.bias is not None:
            self.bias.org = self.bias.data.clone()
            self.bias.data = binarize(self.bias)
            out = torch.add(self.bias, out)
        return out

class BinaryConv1d(nn.Conv1d):
    def forward(self, input):
        out = F.conv1d(input=input, weight= self.weight,  stride=self.stride,
                       padding=self.padding, dilation=self.dilation, groups=self.groups)
        if self.bias is not None:
            self.bias.data = binarize(self.bias)
            # out += self.bias
            out += self.bias.view(1, -1, 1)
        return out

class Bn_bin_conv_pool_block(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, pool_size, pool_stride):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(in_channels)  # default eps = 1e-5, momentum = 0.1, affine = True
        #无bias
        self.conv = nn.Conv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=padding, bias=False)
        #有bias, bias为0、1
        # self.conv = BinaryConv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=padding, bias=None)
        self.relu = nn.ReLU()
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

    def forward(self, I):
        I = self.bn(I)
        I = binarize(I)
        I = self.conv(I)*self.conv.weight.alpha
        # TODO 试试relu或者hardtanh？
        # I = self.relu(I)
        I = self.pool(I)
        return I


class BinActiv(torch.autograd.Function):

    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        input = torch.sign(input)

        return input

    def Mean(self, input):
        return torch.mean(input.abs(), 1, keepdim=True)  # 1: channel // batch[0], channel[1], height[2], width[3]

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors

        # STE (Straight Through Estimator)
        grad_input = grad_output.clone()
        grad_input[input.ge(1)] = 0  # ge: greater or equal
        grad_input[input.le(-1)] = 0  # le: less or equal
        return grad_input


BinActive = BinActiv.apply

class BinLinear(nn.Module):
    def __init__(self, in_features, out_features):
        super().__init__()
        self.in_feature  = in_features
        self.out_feature = out_features
        self.bn          = nn.BatchNorm1d(in_features)
        #无bias
        self.linear      = nn.Linear(in_features, out_features,bias=False)
        #有bias
        # self.linear     = BinaryLinear(in_features, out_features, bias=None)
    def forward(self, I):
        I = self.bn(I)
        # beta = BinActiv().Mean(I)
        I = binarize(I)
        I = self.linear(I)*self.linear.weight.alpha
        # I = torch.mul(I, beta)
        return I




class WeightOperation:
    def __init__(self,model):

        self.count_group_weights = 0
        self.weight = []
        self.saved_weight = []                               #保存weight的原始数据


        for m in model.modules():
            if isinstance(m,nn.Conv1d) or isinstance(m,nn.Linear):

                self.count_group_weights += 1
                self.weight.append(m.weight)
                self.saved_weight.append(m.weight.data)


    def WeightSave(self):
        for index in range(self.count_group_weights):
            self.saved_weight[index].copy_(self.weight[index].data)             #把weight的值给了saved_weight,而后进行binary等操作


    def WeightBinarize(self):
        for index in range(self.count_group_weights):

            n                 = self.weight[index].data[0].nelement()
            dim_group_weights = self.weight[index].data.size()

            if len(dim_group_weights) == 3:
                alpha = self.weight[index].data.norm(1, 2, keepdim=True).sum(1, keepdim=True).div(n).transpose(0,1)

            elif len(dim_group_weights) == 2:
                alpha = self.weight[index].data.norm(1, 1, keepdim=True).div(n).transpose(0,1)

            self.weight[index].data = binarize(self.weight[index].data)         #对应原model中的值也会跟着改变
            self.weight[index].alpha = alpha

    def WeightRestore(self):
        for index in range(self.count_group_weights):
            self.weight[index].data.copy_(self.saved_weight[index])


    def WeightGradient(self):
        for index in range(self.count_group_weights):
            n = self.weight[index].data[0].nelement()
            dim_group_weights = self.weight[index].data.size()

            if len(dim_group_weights) == 3:
                alpha = self.weight[index].data.norm(1, 2, keepdim=True).sum(1, keepdim=True).div(n).expand(dim_group_weights).clone()

            elif len(dim_group_weights) == 2:
                alpha = self.weight[index].data.norm(1, 1, keepdim=True).div(n).expand(dim_group_weights).clone()

            alpha[self.weight[index].data.le(-1.0)] = 0
            alpha[self.weight[index].data.ge( 1.0)] = 0

            alpha = alpha.mul(self.weight[index].grad.data)
            alpha_add = self.weight[index].data.sign().mul(self.weight[index].grad.data)
            if len(dim_group_weights) == 3:
                alpha_add = alpha_add.sum(2, keepdim=True) \
                    .sum(1, keepdim=True).div(n).expand(dim_group_weights)
            elif len(dim_group_weights) == 2:
                alpha_add = alpha_add.sum(1, keepdim=True).div(n).expand(dim_group_weights)
            alpha_add = alpha_add.mul(self.weight[index].sign())
            # self.weight[index].grad = self.weight[index].grad / n + self.weight[index].grad * alpha
            self.weight[index].grad.data = alpha.add(alpha_add).mul(1.0-1.0/dim_group_weights[1]).mul(n)