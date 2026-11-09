import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../sv/yapp.svh"
//`include "../sv/yapp_tx_env.sv"

//import yapp_pkg::*;
module tb_top;
//	yapp_env env;

	initial begin
	//	env=yapp_env::type_id::create("env",null);
	end

//	initial begin
//   	uvm_top.set_timeout(1000ns, 0);   // fail instead of hanging
//  	end
	
	initial begin
		run_test();
	end
endmodule
