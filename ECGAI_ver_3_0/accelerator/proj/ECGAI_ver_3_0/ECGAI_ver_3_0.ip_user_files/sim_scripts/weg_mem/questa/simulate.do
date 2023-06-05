onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib weg_mem_opt

do {wave.do}

view wave
view structure
view signals

do {weg_mem.udo}

run -all

quit -force
