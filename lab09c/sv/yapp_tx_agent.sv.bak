class yapp_tx_agent extends uvm_agent;
	`uvm_component_utils(yapp_tx_agent)

	yapp_tx_sequencer sequencer;
	yapp_tx_driver driver;
	yapp_tx_monitor monitor;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
  
  	uvm_active_passive_enum is_active  = UVM_ACTIVE;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		monitor=yapp_tx_monitor::type_id::create("monitor",this);
		if(is_active==UVM_ACTIVE) begin
			sequencer=yapp_tx_sequencer::type_id::create("sequencer",this);
			driver=yapp_tx_driver::type_id::create("driver",this);
		end
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(is_active==UVM_ACTIVE)
			driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
	
	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		`uvm_info(get_type_name(),"IN AGENT",UVM_HIGH)
	endfunction

endclass
