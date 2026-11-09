import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../sv/yapp_if.sv"                // interface, file scope, before the package
`include "./../../yapp/sv/yapp_pkg.sv"
`include "../../Encrypted_Design/hbus/sv/hbus_pkg.svp"
`include "../../Encrypted_Design/channel/sv/channel_pkg.sv"
`include "../../Encrypted_Design/channel/sv/channel_if.sv"
`include "../../Encrypted_Design/hbus/sv/hbus_if.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"

`include "./../../Encrypted_Design/Encrypted/yapp_router.svh"

module top_dut;
	
	bit clock,reset,error;

	yapp_if vif(clock,reset);
  channel_if ch_1(clock,reset);
  channel_if ch_2(clock,reset);
  channel_if ch_3(clock,reset);
  hbus_if h_bus(clock,reset);

  yapp_router dut(.clock(clock),
    .reset(reset),
    .error(error),

    .in_data(vif.in_data),
    .in_data_vld(vif.in_data_vld),
    .in_suspend(vif.in_suspend),

    .hdata(h_bus.hdata),
    .haddr(h_bus.haddr),
    .hen(h_bus.hen),
    .hwr_rd(h_bus.hwr_rd),

    .data_0(ch_1.data),
    .data_vld_0(ch_1.data_vld),
    .suspend_0(ch_1.suspend),
    .data_1(ch_2.data),
    .data_vld_1(ch_2.data_vld),
    .suspend_1(ch_2.suspend),
    .data_2(ch_3.data),
    .data_vld_2(ch_3.data_vld),
    .suspend_2(ch_3.suspend));

	always #5 clock=~clock;
	initial begin
    #1;
		clock=1'b1;
		reset=1'b1;
		#10
		reset=1'b0;
	end
  initial begin
   // ch_1.suspend=1'b0;
   // ch_2.suspend=1'b0;
    //ch_3.suspend=1'b0;
  end
	initial begin
		uvm_config_db#(virtual yapp_if)::set(null,"uvm_test_top.rtb.env.agent.*","vif",vif);
    uvm_config_db#(virtual channel_if)::set(null,"uvm_test_top.rtb.c1_env.*","vif",ch_1);
    uvm_config_db#(virtual channel_if)::set(null,"uvm_test_top.rtb.c2_env.*","vif",ch_2);
    uvm_config_db#(virtual channel_if)::set(null,"uvm_test_top.rtb.c3_env.*","vif",ch_3);
    uvm_config_db#(virtual hbus_if)::set(null,"uvm_test_top.rtb.h_b*","vif",h_bus);    
		run_test();
	end

endmodule
