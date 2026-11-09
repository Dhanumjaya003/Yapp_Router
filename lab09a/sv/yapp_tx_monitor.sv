class yapp_tx_monitor extends uvm_monitor;
	`uvm_component_utils(yapp_tx_monitor)

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
  	int num_pkt_col;
	virtual yapp_if vif;

	yapp_packet packet_collected;
	uvm_analysis_port #(yapp_packet) tx_item_colleted_port;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    tx_item_colleted_port=new("tx_item_colleted_port",this);
		if (!(uvm_config_db#(virtual yapp_if)::get(this,"","vif", vif)))
      `uvm_fatal("NOVIF",{"vif not set for: ",get_full_name()}) 
	endfunction
	

  task run_phase(uvm_phase phase);
    	`uvm_info(get_type_name(), "Inside the RUN_phase", UVM_MEDIUM)
		packet_collected=yapp_packet::type_id::create("packet_collected",this);
		@(negedge vif.reset)
		`uvm_info(get_type_name(),"Detected Reset Done",UVM_MEDIUM)
		forever 
			collect_packet();
	endtask
	
	 // Collect Packets
  task collect_packet();
      //Monitor looks at the bus on posedge (Driver uses negedge)
      @(posedge vif.in_data_vld);

      @(posedge vif.clock iff (!vif.in_suspend))

      // Begin transaction recording
      void'(this.begin_tr(packet_collected, "Monitor_YAPP_Packet"));

      `uvm_info(get_type_name(), "Collecting a packet", UVM_HIGH)
      // Collect Header {Length, Addr}
      { packet_collected.length, packet_collected.addr }  = vif.in_data;
      packet_collected.payload = new[packet_collected.length]; // Allocate the payload
      // Collect the Payload
      for (int i=0; i< packet_collected.length; i++) begin
         @(posedge vif.clock iff (!vif.in_suspend))
         packet_collected.payload[i] = vif.in_data;
      end

      // Collect Parity and Compute Parity Type
       @(posedge vif.clock iff !vif.in_suspend)
         packet_collected.parity = vif.in_data;
       packet_collected.parity_type = (packet_collected.parity == packet_collected.calc_parity()) ? GOOD_PARITY : BAD_PARITY;
      // End transaction recording
      this.end_tr(packet_collected);
      `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", packet_collected.sprint()), UVM_LOW)
      num_pkt_col++;
      tx_item_colleted_port.write(packet_collected);
  endtask 
	function void start_of_simulation_phase(uvm_phase phase);
		super.start_of_simulation_phase(phase);
		`uvm_info(get_type_name(),"IN MONITOR",UVM_HIGH)
	endfunction
// UVM report_phase
	function void report_phase(uvm_phase phase);
    	`uvm_info(get_type_name(), $sformatf("Report: YAPP Monitor Collected %0d Packets", num_pkt_col), UVM_LOW)
  	endfunction : report_phase
	
endclass : yapp_tx_monitor
