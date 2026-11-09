/*-----------------------------------------------------------------
File name     : top_dut.sv
Description   : Top-level testbench module instantiating DUT and connecting all interfaces
Notes         :
-------------------------------------------------------------------
-----------------------------------------------------------------*/

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../sv/yapp.svh"

// `include "../sv/yapp_seq_lib.sv"
`include "router_tb.sv"
`include "router_test_lib.sv"
`include "../../Encrypted_Design/Encrypted/yapp_router.svh"
// Top-level testbench module instantiating DUT and connecting all interfaces
module top_no_dut;

 // clock, reset are generated here for this DUT
  bit reset;
  bit clock;

  // YAPP Interface to the DUT
  yapp_if vif (
      clock,
      reset,
      in_data_vld,
      in_suspend,
      in_data);

  yapp_router yapp(.in_data(vif.in_data), 
    .suspend_0  (1'b0),
    .suspend_1  (1'b0),
    .suspend_2  (1'b0));
    //assign in0.in_suspend=0;
  initial begin
    // put interface into config_db for driver + monitor
    uvm_config_db#(virtual yapp_if)::set(null, "*", "vif", vif);
    run_test();
  end
  initial vif.in_suspend=1'b0;


  // Reset generation
  initial begin
    reset=1'b0;
    clock=1'b0;
    #1 reset=1'b1;
    #50 reset=1'b0;
  end

  // Generate Clock
  always #10 clock = ~clock;

endmodule : top_no_dut
