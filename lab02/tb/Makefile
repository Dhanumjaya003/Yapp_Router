export PATH := $(PATH):$(HOME)/Downloads/questasim/linux_x86_64
export LM_LICENSE_FILE := $(HOME)/Downloads/questasim/license.dat

TOP = tb_top

all: clean compile run

clean:
	rm -rf work transcript vsim.wlf

compile:
	vlib work
	vlog -sv +incdir+. $(TOP).sv

run:
	vsim -c $(TOP) -do "run -all; quit"

.PHONY: all clean compile run
