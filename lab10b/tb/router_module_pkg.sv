package router_module_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import yapp_pkg::*;
  import hbus_pkg::*;
 `include "packet_virtual_sequencer.sv"
  `include "packet_virtual_seq.sv"

  `include "router_virtual_sequencer.sv"
  `include "router_virtual_seqs.sv"
  `include "main_virtual_sequencer.sv"
  `include "main_virtual_seqs.sv"
 endpackage
