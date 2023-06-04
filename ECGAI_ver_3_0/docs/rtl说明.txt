bnn_top.v为顶层文件
act mem 0 为BRAM ，位宽32bit，深度1024,coe 为act_mem_0 coe，有Padding好的数据
act mem 0 为BRAM ，位宽32bit，深度1024.
weg mem 为BRAM， 位宽32bit,深度8192, 为weight mem coe
threhold 为BRAM ，位宽32bit，深度为256，为threshold mem coe

sim中仿真文件只发出了加速器启动信号

约束只对clock约束，
create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports clk]
