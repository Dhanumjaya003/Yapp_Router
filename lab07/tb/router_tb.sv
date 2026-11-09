import uvm_pkg::*;
`include "uvm_macros.svh"

import yapp_pkg::*;
import channel_pkg::*;
import hbus_pkg::*;  
class router_tb extends uvm_component;
	`uvm_component_utils(router_tb)

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
  
  yapp_env env;
  channel_env c1_env;
  channel_env c2_env;
  channel_env c3_env;
  hbus_env h_b;

	function void build_phase(uvm_phase phase);
		uvm_config_db#(int)::set(null,"*","recording detail",1);

    //Added in LAB07 
    uvm_config_db#(int)::set(this,"c1_env","has_tx",0);
    uvm_config_db#(int)::set(this,"c2_env","has_tx",0);
    uvm_config_db#(int)::set(this,"c3_env","has_tx",0);
    uvm_config_db#(int)::set(this,"h_b","num_masters",1);
    uvm_config_db#(int)::set(this,"h_b","num_slaves",0);    
		super.build_phase(phase);
		env=yapp_env::type_id::create("env",this);
    c1_env=channel_env::type_id::create("c1_env",this);
    c2_env=channel_env::type_id::create("c2_env",this);
    c3_env=channel_env::type_id::create("c3_env",this);
    h_b=hbus_env::type_id::create("h_b",this);
	endfunction
endclass
