import torch
import torch.nn as nn

from .OP import  Bn_bin_conv_pool_block_bw, Bn_bin_conv_pool_block_baw,Bn_bin_conv_pool_block_Float, \
    Bn_bin_conv_pool_block_bw_Threshold, Bn_bin_conv_pool_block_kx_plus_b,Bn_bin_conv_pool_block_baw_akx_plus_b, Bn_bin_conv_pool_block_baw_Threshold




class ECG_XNOR_Full_Bin(nn.Module):
    def __init__(self, block1, block2, block3, block4, block5, block6, block7, device):
        super(ECG_XNOR_Full_Bin, self).__init__()
        self.name = 'Full_Bin_ECG'

        self.device = device
        self.block1 = Bn_bin_conv_pool_block_baw(*block1)
        self.block2 = Bn_bin_conv_pool_block_baw(*block2)
        self.block3 = Bn_bin_conv_pool_block_baw(*block3)
        self.block4 = Bn_bin_conv_pool_block_baw(*block4)

        self.is_block5 = False
        self.is_block6 = False
        self.is_block7 = False
        if block5 is not None:
            self.block5 = Bn_bin_conv_pool_block_baw(*block5)
            self.is_block5 = True
        if block6 is not None:
            self.block6 = Bn_bin_conv_pool_block_baw(*block6)
            self.is_block6 = True
        if block7 is not None:
            self.block7 = Bn_bin_conv_pool_block_baw(*block7)
            self.is_block7 = True
        self.dropout0 = nn.Dropout(p=0.5)
    def forward(self, batch_data):
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        batch_data = self.block1(batch_data)
        batch_data = self.block2(batch_data)
        batch_data = self.block3(batch_data)
        batch_data = self.block4(batch_data)
        if self.is_block5:
            batch_data = self.block5(batch_data)
        if self.is_block6:
            batch_data = self.block6(batch_data)
        if self.is_block7:
            batch_data = self.block7(batch_data)
        batch_data = self.dropout0(batch_data)
        batch_data = batch_data.mean(dim=2)
        return batch_data

class ECG_XNOR_Full_Ori(nn.Module):
    def __init__(self, block1, block2, block3, block4, block5, block6, block7, device):
        super(ECG_XNOR_Full_Ori, self).__init__()
        self.name = 'Ori_Bin_ECG'
        self.device = device
        self.block1 = Bn_bin_conv_pool_block_bw(*block1)
        self.block2 = Bn_bin_conv_pool_block_baw(*block2)
        self.block3 = Bn_bin_conv_pool_block_baw(*block3)
        self.block4 = Bn_bin_conv_pool_block_baw(*block4)

        self.is_block5 = False
        self.is_block6 = False
        self.is_block7 = False
        if block5 is not None:
            self.block5 = Bn_bin_conv_pool_block_baw(*block5)
            self.is_block5 = True
        if block6 is not None:
            self.block6 = Bn_bin_conv_pool_block_baw(*block6)
            self.is_block6 = True
        if block7 is not None:
            self.block7 = Bn_bin_conv_pool_block_baw(*block7)
            self.is_block7 = True
        self.dropout0 = nn.Dropout(p=0.5)
        # self.softmax = nn.Softmax()
    def forward(self, batch_data):
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        batch_data = self.block1(batch_data)
        batch_data = self.block2(batch_data)
        batch_data = self.block3(batch_data)
        batch_data = self.block4(batch_data)
        if self.is_block5:
            batch_data = self.block5(batch_data)
        if self.is_block6:
            batch_data = self.block6(batch_data)
        if self.is_block7:
            batch_data = self.block7(batch_data)
        batch_data = self.dropout0(batch_data)
        batch_data = batch_data.mean(dim=2)
        # batch_data = self.softmax(batch_data)
        return batch_data


class ECG_XNOR_Full_Thre(nn.Module):
    def __init__(self, block1, block2, block3, block4, block5, block6, block7, device):
        super(ECG_XNOR_Full_Thre, self).__init__()
        self.name = 'Threshold_ECG'

        self.device = device
        self.block1 = Bn_bin_conv_pool_block_baw_Threshold(*block1)
        self.block2 = Bn_bin_conv_pool_block_baw_Threshold(*block2)
        self.block3 = Bn_bin_conv_pool_block_baw_Threshold(*block3)
        self.block4 = Bn_bin_conv_pool_block_baw_Threshold(*block4)
        self.block5 = Bn_bin_conv_pool_block_baw_Threshold(*block5)
        self.block6 = Bn_bin_conv_pool_block_baw_akx_plus_b(*block6)

        # self.quant = torch.quantization.QuantStub()
        # self.dequant = torch.quantization.DeQuantStub()
        self.dropout0 = nn.Dropout(p=0.5)
    def forward(self, batch_data):
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        # batch_data = self.quant(batch_data)
        batch_data = self.block1(batch_data)
        batch_data = self.block2(batch_data)
        batch_data = self.block3(batch_data)
        batch_data = self.block4(batch_data)
        batch_data = self.block5(batch_data)
        batch_data = self.block6(batch_data)
        # batch_data = self.dropout0(batch_data)
        # batch_data = batch_data.sum(dim=2)
        # batch_data = self.dequant(batch_data)
        return batch_data

class ECG_XNOR_Full_akx_plus_b(nn.Module):
    def __init__(self, block1, block2, block3, block4, block5, block6, block7, device):
        super(ECG_XNOR_Full_akx_plus_b, self).__init__()
        self.name = 'Threshold_ECG'

        self.device = device
        self.block1 = Bn_bin_conv_pool_block_baw_Threshold(*block1)
        self.block2 = Bn_bin_conv_pool_block_baw_Threshold(*block2)
        self.block3 = Bn_bin_conv_pool_block_baw_Threshold(*block3)
        self.block4 = Bn_bin_conv_pool_block_baw_Threshold(*block4)
        self.block5 = Bn_bin_conv_pool_block_baw_Threshold(*block5)
        self.block6 = Bn_bin_conv_pool_block_baw_akx_plus_b(*block6)

        # self.quant = torch.quantization.QuantStub()
        # self.dequant = torch.quantization.DeQuantStub()
        self.dropout0 = nn.Dropout(p=0.5)
    def forward(self, batch_data):
        batch_data = batch_data.clone().detach().requires_grad_(True).to(self.device)
        # batch_data = self.quant(batch_data)
        batch_data = self.block1(batch_data)
        batch_data = self.block2(batch_data)
        batch_data = self.block3(batch_data)
        batch_data = self.block4(batch_data)
        batch_data = self.block5(batch_data)
        batch_data = self.block6(batch_data)
        # batch_data = self.dropout0(batch_data)
        # batch_data = batch_data.sum(dim=2)
        # batch_data = self.dequant(batch_data)
        return batch_data