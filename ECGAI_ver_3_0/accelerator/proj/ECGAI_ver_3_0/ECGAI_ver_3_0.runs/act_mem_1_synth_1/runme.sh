#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=D:/Software/Programma/Vivado2020/Vivado/2020.2/ids_lite/ISE/bin/nt64;D:/Software/Programma/Vivado2020/Vivado/2020.2/ids_lite/ISE/lib/nt64:D:/Software/Programma/Vivado2020/Vivado/2020.2/bin
else
  PATH=D:/Software/Programma/Vivado2020/Vivado/2020.2/ids_lite/ISE/bin/nt64;D:/Software/Programma/Vivado2020/Vivado/2020.2/ids_lite/ISE/lib/nt64:D:/Software/Programma/Vivado2020/Vivado/2020.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='E:/Repository/SEU-ASIC-IOT-ECGAI/ECGAI_ver_3_0/accelerator/proj/ECGAI_ver_3_0/ECGAI_ver_3_0.runs/act_mem_1_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log act_mem_1.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source act_mem_1.tcl