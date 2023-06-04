from torch.autograd import Function
import torch.nn.functional as F
import torch
import torch.nn as nn
from pathlib import Path

device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

# -----------------------------------------二值化函数（STE技术）------------------------------------------------
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

binarize = BinarizeF.apply

# -----------------------------------------二值化input-----------------------------------------------
class BinActiv(torch.autograd.Function):

    @staticmethod
    def forward(ctx, input):
        ctx.save_for_backward(input)
        input = torch.sign(input)

        return input

    def Mean(self, input):
        return torch.mean(input.abs(), 1, keepdim=True)  # 求解A：沿通道方向加和绝对值，但没有除以通道数

    @staticmethod
    def backward(ctx, grad_output):
        input, = ctx.saved_tensors

        # STE (Straight Through Estimator)
        grad_input = grad_output.clone()
        grad_input[input.ge(1)] = 0  # ge: greater or equal
        grad_input[input.le(-1)] = 0  # le: less or equal
        return grad_input
BinActive = BinActiv.apply

# -----------------------------------------二值化卷积------------------------------------------------
# 该类对偏置（bias）进行了二值化处理，即将其转化为 +1 或 -1 的形式。这是为了将偏置值映射到二值化激活函数的取值范围内。
class BinaryConv1d(nn.Conv1d):
    def forward(self, input):
        # binary_input = binarize(input)
        # binary_weight = binarize(self.weight)
        # out = F.conv1d(input=binary_input, weight=binary_weight, stride=self.stride,
        #                padding=self.padding, dilation=self.dilation, groups=self.groups)
        out = F.conv1d(input=input, weight= self.weight,  stride=self.stride,
                       padding=self.padding, dilation=self.dilation, groups=self.groups)
        if self.bias is not None:
            self.bias.data = binarize(self.bias)
            # out += self.bias
            out += self.bias.view(1, -1, 1)
        return out

# -----------------------------------------二值化线性层------------------------------------------------
class BinLinear(nn.Module):
    def __init__(self, in_features, out_features):
        super().__init__()
        self.in_feature = in_features
        self.out_feature = out_features
        self.bn = nn.BatchNorm1d(in_features)
        # 无bias
        self.linear = nn.Linear(in_features, out_features, bias=False)
        # 有bias
        # self.linear     = BinaryLinear(in_features, out_features, bias=None)

    def forward(self, I):
        I = self.bn(I)
        beta = BinActiv().Mean(I)
        I = binarize(I)
        I = self.linear(I) * self.linear.weight.alpha
        I = torch.mul(I, beta)
        return I
# --------------------------------------网络基本块---------------------------------------------
class Bn_bin_conv_pool(nn.Module):
    def __init__(self, in_channels, out_channels, kernel_size, stride, padding, padding_value, pool_size, pool_stride):
        super().__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size
        self.stride = stride
        self.padding = padding
        self.bn = nn.BatchNorm1d(in_channels)  # default eps = 1e-5, momentum = 0.1, affine = True
        # pad
        self.pad = nn.ConstantPad1d(padding=padding, value=padding_value)
        #无bias
        self.conv = nn.Conv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=padding, bias=False)
        #有bias, bias为0、1
        # self.conv = BinaryConv1d(in_channels, out_channels, kernel_size=kernel_size, stride=stride, padding=padding, bias=None)
        self.relu = nn.ReLU()
        self.prelu = nn.PReLU()
        self.htanh = nn.Hardtanh()
        self.tanh = nn.Tanh()
        self.pool = nn.MaxPool1d(kernel_size=pool_size, stride=pool_stride)

    def forward(self, I):
        I = self.bn(I)
        I = binarize(I)
        I = self.conv(I)*self.conv.weight.alpha
        # TODO 试试relu或者hardtanh？
        I = self.prelu(I)
        I = self.pool(I)

        return I

# ---------------------------------------权重处理-----------------------------------------------
class WeightOperation:
    def __init__(self, model):
        self.model = model
        self.count_group_weights = 0
        self.weight = []
        self.saved_weight = []  # 保存weight的原始数据
        self.saved_alpha = []


        for m in model.modules():
            if isinstance(m, nn.Conv1d) or isinstance(m, nn.Linear):
                self.count_group_weights += 1
                self.weight.append(m.weight)
                self.saved_weight.append(m.weight.data)
    # -----------------------------------------------保存权重-----------------------------------------------
    def WeightSave(self):
        for index in range(self.count_group_weights):
            self.saved_weight[index].copy_(self.weight[index].data)  # 把weight的值给了saved_weight,而后进行binary等操作
    # ----------------------------------------------二值化权重----------------------------------------------
    def WeightBinarize(self):
        for index in range(self.count_group_weights):

            # 利用变量n和dim_group_weights获取权重张量的元素数量和形状信息
            n                 = self.weight[index].data[0].nelement()
            dim_group_weights = self.weight[index].data.size()

            # 计算出对应的alpha值
            if len(dim_group_weights) == 3:
                alpha = self.weight[index].data.norm(1, 2, keepdim=True).sum(1, keepdim=True).div(n).transpose(0, 1)
            # 如果权重张量dim_group_weights为3
            # alpha的计算方式为：对于每一个通道（channel），将每个参数的绝对值求和，再除以元素总数n，得到该通道上的平均l1范数，最后在各个通道之间进行广播。
            # （在计算中，使用了norm()函数来根据输入的范数类型（此处为1）计算张量各元素的范数，并使用expand()函数来广播特定形状的tensor）
            elif len(dim_group_weights) == 2:
                alpha = self.weight[index].data.norm(1, 1, keepdim=True).div(n).transpose(0, 1)
            # 如果权重张量dim_group_weights为2
            # alpha的计算方式为：将各列的绝对值求和，再除以元素总数n，得到每个列向量的平均l1范数，最后在各列之间进行广播

            # 调用了binarize()函数来实现权重二值化
            self.weight[index].data = binarize(self.weight[index].data)  # 对应原model中的值也会跟着改变
            self.weight[index].alpha = alpha
            # 该函数通常的实现方式是：对于输入张量x，先使用sign()函数将其内部元素按符号转换为-1或1
            # 然后创造一个与x形状相同的张量并将其所有元素都初始化为1，最后使用where()函数将两个张量进行按位相乘即可。
            # 因此，二值化后的权重张量中的元素只能是-1或1，并且其形状与原始张量相同。

    def Weightclamp(self):
        for index in range(self.count_group_weights):
            self.weight[index].data = \
            self.weight[index].data.clamp(-1.0, 1.0)

    # -----------------------------------------------恢复权重-----------------------------------------------
    def WeightRestore(self):
        for index in range(self.count_group_weights):
            self.weight[index].data.copy_(self.saved_weight[index])
            # 具体来说，该函数通过将已保存的参数值从内存中拷贝回神经网络的相应参数中来实现权重的恢复。
            # 其中，self.count_group_weights表示要恢复的层数，
            # self.weight表示待恢复的权重矩阵，self.saved_weight表示已保存的权重矩阵。
            # 通过该函数，我们可以在神经网络训练过程中调整参数值，进而提高模型的性能表现

    # -----------------------------------------------更新权重 -----------------------------------------------
    # 该函数主要针对二值神经网络（binary neural network）而设计，能够有效地提高神经网络的训练效率和准确性。
    def WeightGradient(self):
        for index in range(self.count_group_weights):
            # 利用变量n和dim_group_weights来获取权重张量的元素数量和形状信息
            n                 = self.weight[index].data[0].nelement()
            dim_group_weights = self.weight[index].data.size()

            if len(dim_group_weights) == 3:
                alpha = self.weight[index].data.norm(1, 2, keepdim=True).sum(1, keepdim=True).div(n).expand(
                    dim_group_weights).clone()
            elif len(dim_group_weights) == 2:
                alpha = self.weight[index].data.norm(1, 1, keepdim=True).div(n).expand(dim_group_weights).clone()

            # 对权重张量中小于-1或大于1的元素所对应的alpha值进行了置0操作
            alpha[self.weight[index].data.le(-1.0)] = 0
            alpha[self.weight[index].data.ge(1.0)] = 0
            # 这是为了消除二值权重（binary weights）在反向传播时可能会产生的过大或过小的梯度，避免更新过程出现不稳定的情况

            alpha = alpha.mul(self.weight[index].grad.data)
            alpha_add = self.weight[index].data.sign().mul(self.weight[index].grad.data)
            if len(dim_group_weights) == 3:
                alpha_add = alpha_add.sum(2, keepdim=True) \
                    .sum(1, keepdim=True).div(n).expand(dim_group_weights)
            elif len(dim_group_weights) == 2:
                alpha_add = alpha_add.sum(1, keepdim=True).div(n).expand(dim_group_weights)

            alpha_add = alpha_add.mul(self.weight[index].sign())
            # 接下来，分别计算alpha和alpha_add，并将它们加权后应用到对应的梯度grad上，最后再除以元素总数n以进行梯度平均化。
            # self.weight[index].grad = self.weight[index].grad / n + self.weight[index].grad * alpha
            self.weight[index].grad.data = alpha.add(alpha_add).mul(1.0 - 1.0 / dim_group_weights[1]).mul(n)

# -----------------------------------------------保存模型-----------------------------------------------
def save_model(model: torch.nn.Module,
               target_dir: str,
               model_name: str):
    """Saves a PyTorch model to a target directory.
    Args:
    model: A target PyTorch model to save.
    target_dir: A directory for saving the model to.
    model_name: A filename for the saved model. Should include
      either ".pth" or ".pt" as the file extension.
    Example usage:
    save_model(model=model_0,
               target_dir="models",
               model_name="05_going_modular_tingvgg_model.pth")
    """
    # Create target directory
    target_dir_path = Path(target_dir)
    target_dir_path.mkdir(parents=True,
                        exist_ok=True)

    # Create model save path
    assert model_name.endswith(".pth") or model_name.endswith(".pt"), "model_name should end with '.pt' or '.pth'"
    model_save_path = target_dir_path / model_name

    # Save the model state_dict()
    print(f"[INFO] Saving model to: {model_save_path}")
    torch.save(obj=model.state_dict(),
             f=model_save_path)