// router_pkg.sv (or at the top of router_tb.sv, inside a package)
package router_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import yapp_pkg::*;          // brings in the ONE yapp_packet

  `uvm_analysis_imp_decl(_yapp)
  `uvm_analysis_imp_decl(_ch0)
  `uvm_analysis_imp_decl(_ch1)
  `uvm_analysis_imp_decl(_ch2)

  `include "router_scoreboard.sv"
  `include "router_tb.sv"      // the tb class, not the top module
endpackage
