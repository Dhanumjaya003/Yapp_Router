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

  //Added in LAB08
  router_simple_vseq vseq;
  router_virtual_sequencer vseqr;
 
  //Added in LAB09A
  //router_scoreboard rt_scb;  //commented in LAB09B
  //Added in LAB09B
  router_module_env rt_env;

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
    vseqr=router_virtual_sequencer::type_id::create("vseqr",this);
    //rt_scb=router_scoreboard::type_id::create("rt_scb",this);
    rt_env=router_module_env::type_id::create("rt_env",this);
	endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vseqr.hbus_mas_sqr = h_b.masters[0].sequencer;
    vseqr.yapp_tx_sqr = env.agent.sequencer;
    env.agent.monitor.tx_item_colleted_port.connect(rt_env.rt_ref.yapp_imp1);
    c1_env.monitor.item_collected_port.connect(rt_env.rt_scb.ch0_imp);
    c2_env.monitor.item_collected_port.connect(rt_env.rt_scb.ch1_imp);
    c3_env.monitor.item_collected_port.connect(rt_env.rt_scb.ch2_imp);
    h_b.bus_monitor.item_collected_port.connect(rt_env.rt_ref.hbus_imp);
  endfunction
endclass
