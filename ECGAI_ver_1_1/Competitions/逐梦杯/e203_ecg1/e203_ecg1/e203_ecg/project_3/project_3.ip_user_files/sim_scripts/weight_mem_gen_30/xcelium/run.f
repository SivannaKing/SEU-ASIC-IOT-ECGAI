-makelib xcelium_lib/xil_defaultlib -sv \
  "D:/vivado/vivado_install/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/vivado/vivado_install/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/vivado/vivado_install/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_2.srcs/sources_1/ip/weight_mem_gen_30/sim/weight_mem_gen_30.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

