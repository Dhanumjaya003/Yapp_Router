TESTNAME ?= base_test
compile:
	rm -rf work
	vlib work
	vlog -sv top_dut.sv
	# vsim -c -coverage top_dut -do "coverage save -onexit yapp_cov.ucdb; run -all; quit"
	# vlog -sv +incdir+../sv +incdir+../../Encrypted_Design/... top_dut.sv

run:
	vsim -c -coverage top_dut -voptargs=+acc -wlf vsim.wlf +UVM_TESTNAME=$(TESTNAME) -do "coverage save -onexit yapp_cov.ucbd; log -r /*; run -all; quit -f"

wave:
	vsim -view vsim.wlf -do "add wave -r /*; wave zoom full"
