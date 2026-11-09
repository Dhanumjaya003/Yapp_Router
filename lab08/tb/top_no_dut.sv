module top_no_dut;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
//	import yapp_pkg::*;
//	`include "yapp_tx_seqs.sv"
	`include "../sv/yapp.svh"
	`include "router_tb.sv"
	`include "router_test_lib.sv"

	bit clock,reset,in_suspend;

	yapp_if vif(clock,reset);

	always #5 clock=~clock;
	initial begin
		clock=1'b1;
		reset=1'b1;
		#10
		reset=1'b0;
	end

	initial begin
		uvm_config_db#(virtual yapp_if)::set(null,"*","vif",vif);
		run_test();
	end

endmodule
