class yapp_tx_monitor extends uvm_monitor;
	`uvm_component_utils(yapp_tx_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
    	`uvm_info(get_type_name(), "Inside the YAPP TX Monitor", UVM_LOW)
	endtask

	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		`uvm_info(get_type_name(),"IN MONITOR",UVM_HIGH)
	endfunction

	endclass : yapp_tx_monitor
