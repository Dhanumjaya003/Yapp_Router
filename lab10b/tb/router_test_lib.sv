//`include "../tb/yapp_seq_lib.sv"
class base_test extends uvm_test;
	`uvm_component_utils(base_test)

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	//yapp_env env;
	router_tb rtb;

	function void build_phase(uvm_phase phase);
//		uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase",
//                          "default_sequence",
//                          yapp_5_packets::type_id::get());
		super.build_phase(phase);
	//	env=yapp_env::type_id::create("env",this);
		rtb=router_tb::type_id::create("rtb",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction

	task run_phase(uvm_phase phase);
 //   yapp_012_seq seq;
//    yapp_5_packets seq;
    //phase.raise_objection(this);
  //  seq=yapp_012_seq::type_id::create("seq");
   // seq.start(rtb.env.agent.sequencer);
   // phase.drop_objection(this);
		phase.phase_done.set_drain_time(this,1000ns);
	endtask
endclass

class simple_test extends base_test;
  `uvm_component_utils(simple_test)
 // yapp_seq_lib seq_lib;
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    set_type_override_by_type(yapp_packet::get_type(),short_yapp_packet::get_type());

    uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase","default_sequence",yapp_012_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c1_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c2_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c3_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
     endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    factory.print();
  endfunction
endclass

class router_vtest_lib extends base_test;
	`uvm_component_utils(router_vtest_lib)

	//yapp_seq_lib seq_lib;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DEBUG",
          "Setting default sequence on virtual sequencer",
          UVM_NONE)
	/*	seq_lib = yapp_seq_lib::type_id::create("seq_lib");
		seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
		seq_lib.min_random_count = 5;
      	seq_lib.max_random_count = 5;*/
		uvm_config_wrapper::set(this,"rtb.vseqr.run_phase","default_sequence",router_simple_vseq::type_id::get());

   // uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase","default_sequence",yapp_012_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c1_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c2_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c3_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
	  //set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type());
	  set_type_override_by_type( yapp_packet::get_type(), dist_yapp_packet::get_type());

	endfunction


	function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass

class main_vtest_lib extends base_test;
	`uvm_component_utils(main_vtest_lib)

	//yapp_seq_lib seq_lib;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DEBUG",
          "Setting default sequence on virtual sequencer",
          UVM_NONE)
	/*	seq_lib = yapp_seq_lib::type_id::create("seq_lib");
		seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
		seq_lib.min_random_count = 5;
      	seq_lib.max_random_count = 5;*/
		uvm_config_wrapper::set(this,"rtb.vseqr.run_phase","default_sequence",main_virtual_seq::type_id::get());

   // uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase","default_sequence",yapp_012_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c1_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c2_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c3_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
	  set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type());

	endfunction


	function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass

class disable_test extends base_test;
	`uvm_component_utils(disable_test)

	//yapp_seq_lib seq_lib;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("DEBUG",
          "Setting default sequence on virtual sequencer",
          UVM_NONE)
	/*	seq_lib = yapp_seq_lib::type_id::create("seq_lib");
		seq_lib.selection_mode = UVM_SEQ_LIB_RANDC;
		seq_lib.min_random_count = 5;
      	seq_lib.max_random_count = 5;*/
		uvm_config_wrapper::set(this,"rtb.vseqr.run_phase","default_sequence",packet_virtual_seq::type_id::get());

   // uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase","default_sequence",yapp_012_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c1_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c2_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c3_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
	  set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type());

	endfunction

endclass



