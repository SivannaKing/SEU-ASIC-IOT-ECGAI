onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib weight_mem_gen_00_opt

do {wave.do}

view wave
view structure
view signals

do {weight_mem_gen_00.udo}

run -all

quit -force
