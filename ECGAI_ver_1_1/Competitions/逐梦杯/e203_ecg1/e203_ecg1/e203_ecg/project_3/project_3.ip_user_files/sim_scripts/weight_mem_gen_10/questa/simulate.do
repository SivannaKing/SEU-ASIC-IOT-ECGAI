onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib weight_mem_gen_10_opt

do {wave.do}

view wave
view structure
view signals

do {weight_mem_gen_10.udo}

run -all

quit -force
