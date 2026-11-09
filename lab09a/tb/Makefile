TESTNAME ?= base_test
compile:
	rm -rf work
	vlib work
	vlog -sv +incdir+../sv +incdir+../../Encrypted_Design/... top_dut.sv

run:
	vsim -c top_dut -voptargs=+acc -wlf vsim.wlf +UVM_TESTNAME=$(TESTNAME) -do "log -r /*; run -all; quit -f"

wave:
	vsim -view vsim.wlf -do "add wave -r /*; wave zoom full"
