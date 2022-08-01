/////硬件部分//////
1. PE单元改动：(8bit-mul)&&(16bit-adder) --->(2*13bit-adder)&&(shifter)省去了乘法器，换成移位器并满足出现特征标志位时进行多次累加并在新权重出现时再执行乘法并将当前累加乘的值加到初始累加值上
2. output regfile改动：P_stride与PL保持一致，相邻两次池化不会有重叠的输入所以无需判断是否满足输出条件，进而简化结构(从原来的4种情况变成2种），减少了计数模块以及寄存器位宽（64bit->32bit)
output regfile 72 = 72*output regfile
3. pooling改动：省去了pooling中8选1和5选1的情况。
4. 目前还未使用算法提取的4bit权重数据，当前修改硬件结构并查看PE波形。
////算法/////////
MILL：数据集
trainV2: 
1.  load.py 加载数据集，执行标准化和训练集的划分，生成dev_32.json和train_32.json
2.  network.py 网络架构，network_pkps.py，池化步长和池化长度相等的网络结构
3.  quantizied.py 进行增量量化训练
4.  train.py 进行普通网络的训练
5.  test.py 将网络在测试集上评估
6.  train_channelprune.py 进行剪枝
7.  weights_qmodel.py 统计训练后网络的权值分布
8.  requirement.txt 代码运行环境


