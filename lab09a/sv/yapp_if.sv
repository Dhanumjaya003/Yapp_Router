/*-----------------------------------------------------------------
File name     : yapp_if.sv
Description   :
Notes         :
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2009 
-----------------------------------------------------------------*/

interface yapp_if (input logic clock, input logic reset );

  // Actual Signals
  logic              in_data_vld;
  logic              in_suspend;
  logic       [7:0]  in_data;
  
  // Control flags
  bit                has_checks = 1;
  bit                has_coverage = 1;

endinterface : yapp_if

