-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/sofeware/vivado/vivado/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/sofeware/vivado/vivado/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../ECG_acc9.srcs/sources_1/ip/map_mem_gen_5/sim/map_mem_gen_5.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

