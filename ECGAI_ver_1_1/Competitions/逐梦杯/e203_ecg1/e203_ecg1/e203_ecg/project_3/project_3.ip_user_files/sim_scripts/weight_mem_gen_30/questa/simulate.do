onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib weight_mem_gen_30_opt

do {wave.do}

view wave
view structure
view signals

do {weight_mem_gen_30.udo}

run -all

quit -force
