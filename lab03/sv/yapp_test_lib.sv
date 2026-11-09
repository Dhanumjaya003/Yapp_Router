class base_test extends uvm_test;
	`uvm_component_utils(base_test)

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	yapp_env env;

	function void build_phase(uvm_phase phase);
		uvm_config_wrapper::set(this, "env.agent.sequencer.run_phase",
                          "default_sequence",
                          yapp_5_packets::type_id::get());
		super.build_phase(phase);
		env=yapp_env::type_id::create("env",this);
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass
