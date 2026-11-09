TOP = top_no_dut

all: run

lib:
	vlib work

compile: lib
	vlog -sv $(TOP).sv

run: compile
	vsim -c $(TOP) +UVM_TESTNAME=base_test -do "run -all; quit" +UVM_VERBOSITY=UVM_HIGH

gui: compile
	vsim $(TOP)

clean:
	rm -rf work transcript vsim.wlf modelsim.ini

.PHONY: all compile run gui clean lib
