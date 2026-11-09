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
		uvm_config_wrapper::set(this,"rtb.vseqr.run_phase","default_sequence",disable_dut_sequence::type_id::get());

   // uvm_config_wrapper::set(this, "rtb.env.agent.sequencer.run_phase","default_sequence",yapp_012_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c1_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c2_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
    uvm_config_wrapper::set(this,"rtb.c3_env.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::type_id::get());
	  set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type());

	endfunction

endclass


