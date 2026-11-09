class yapp_tx_driver extends uvm_driver #(yapp_packet);
	`uvm_component_utils(yapp_tx_driver)
	yapp_packet packet;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction
	virtual task run_phase(uvm_phase phase);
		yapp_packet pkt;
		forever begin
			seq_item_port.get_next_item(pkt);
			send_to_dut(pkt);
			seq_item_port.item_done();
		end
	endtask
	task send_to_dut(yapp_packet pkt);
  		`uvm_info(get_type_name(),$sformatf("Packet is \n%s", pkt.sprint()),UVM_LOW)
	endtask

	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		`uvm_info(get_type_name(),"IN DRIVER",UVM_HIGH)
	endfunction

endclass
