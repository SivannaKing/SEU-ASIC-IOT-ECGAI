onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib threshold_mem_opt

do {wave.do}

view wave
view structure
view signals

do {threshold_mem.udo}

run -all

quit -force
