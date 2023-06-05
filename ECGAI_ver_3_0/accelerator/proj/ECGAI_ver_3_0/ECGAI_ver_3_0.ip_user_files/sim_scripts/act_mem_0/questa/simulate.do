onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib act_mem_0_opt

do {wave.do}

view wave
view structure
view signals

do {act_mem_0.udo}

run -all

quit -force
