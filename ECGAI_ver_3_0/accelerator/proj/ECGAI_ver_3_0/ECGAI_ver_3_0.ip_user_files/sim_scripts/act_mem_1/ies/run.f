-makelib ies_lib/xpm -sv \
  "D:/Software/Programma/Vivado2020/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Software/Programma/Vivado2020/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../ECGAI_ver_3_0.gen/sources_1/ip/act_mem_1/sim/act_mem_1.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

