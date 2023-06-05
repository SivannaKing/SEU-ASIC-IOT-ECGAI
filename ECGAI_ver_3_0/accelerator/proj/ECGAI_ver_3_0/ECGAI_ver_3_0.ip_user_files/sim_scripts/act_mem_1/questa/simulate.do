onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib act_mem_1_opt

do {wave.do}

view wave
view structure
view signals

do {act_mem_1.udo}

run -all

quit -force
