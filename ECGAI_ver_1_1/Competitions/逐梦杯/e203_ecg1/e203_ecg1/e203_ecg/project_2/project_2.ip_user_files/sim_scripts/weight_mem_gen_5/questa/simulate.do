onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib weight_mem_gen_5_opt

do {wave.do}

view wave
view structure
view signals

do {weight_mem_gen_5.udo}

run -all

quit -force
