TOP = tb_top

all: run

lib:
	vlib work

compile: lib
	vlog -sv $(TOP).sv

run: compile
	vsim -c $(TOP) +UVM_TESTNAME=exhaustive_seq_test -do "run -all; quit"

gui: compile
	vsim $(TOP)

clean:
	rm -rf work transcript vsim.wlf modelsim.ini

.PHONY: all compile run gui clean lib
