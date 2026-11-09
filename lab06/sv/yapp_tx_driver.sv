/*
//------------------------------------------------------------------------------
// File name   : yapp_tx_driver.sv
// Description : Transmit driver for YAPP protocol
//------------------------------------------------------------------------------

// Import UVM
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_tx_driver extends uvm_driver #(yapp_packet);

  // Register with factory
  `uvm_component_utils(yapp_tx_driver)
  int num_sent = 0;

  // Constructor
  function new(string name = "yapp_tx_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual yapp_if vif;
  yapp_packet packet;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db#(virtual yapp_if)::get(this,"","vif",vif)))
      `uvm_fatal("VIFE", "vif not set")

    packet = yapp_packet::type_id::create("packet");
    
  endfunction

  // UVM run_phase
  task run_phase(uvm_phase phase);
    yapp_packet pkt;

    forever begin
      // Get next item from sequencer
      seq_item_port.get_next_item(pkt);

      // Send to DUT (currently just prints)
      send_to_dut(pkt);

      // Indicate transaction is complete
      seq_item_port.item_done();
    end
  endtask : run_phase

  
  function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Inside start_of_simulation_phase : %s", get_full_name()),UVM_HIGH)
  endfunction

  // Send packet to DUT (placeholder implementation)
  task reset_signals();
    forever begin
      @(posedge vif.reset);
       `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
      vif.in_data           <=  'hz;
      vif.in_data_vld       <= 1'b0;
      disable send_to_dut;
    end
  endtask : reset_signals

  // Gets a packet and drive it into the DUT
  task send_to_dut(yapp_packet packet);

    // Wait for packet delay
    repeat(packet.packet_delay)
      @(negedge vif.clock);

    // Start to send packet if not in_suspend signal
      @(negedge vif.clock iff (!vif.in_suspend));

    // Begin Transaction recording
    void'(this.begin_tr(packet, "Input_YAPP_Packet"));

    // Enable start packet signal
    vif.in_data_vld <= 1'b1;

    // Drive the Header {Length, Addr}
    vif.in_data <= { packet.length, packet.addr };

    // Drive Payload
    for (int i=0; i<packet.payload.size(); i++) begin
      @(negedge vif.clock iff (!vif.in_suspend))
      vif.in_data <= packet.payload[i];
    end
    // Drive Parity and reset Valid
    @(negedge vif.clock iff (!vif.in_suspend))
    vif.in_data_vld <= 1'b0;
    vif.in_data  <= packet.parity;

    @(negedge  vif.clock)
      vif.in_data  <= 8'bz;
    num_sent++;

    // End transaction recording
    this.end_tr(packet);

  endtask : send_to_dut

endclass : yapp_tx_driver*/


/*-----------------------------------------------------------------
File name     : driver_example.sv
Description   : This files supplies example yapp_tx_driver methods for lab06
Notes         : 
-------------------------------------------------------------------
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// yapp_tx_driver methods and properties
//
//------------------------------------------------------------------------------

class yapp_tx_driver extends uvm_driver #(yapp_packet);
  `uvm_component_utils(yapp_tx_driver)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction
  // Declare this property to count packets sent
  int num_sent;
  virtual yapp_if vif;
  yapp_packet packet;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!(uvm_config_db#(virtual yapp_if)::get(this,"","vif",vif)))
      `uvm_fatal("NOVIF",{"vif is not set for:",get_full_name()})
  endfunction

  // Replace your run_phase() method with this:
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Inside run phase of driver",UVM_MEDIUM)
    fork
      reset_signals();
      get_and_drive();
     join
  endtask : run_phase

  // Gets packets from the sequencer and passes them to the driver. 
  task get_and_drive();
    `uvm_info(get_type_name(), "waiting for reset to drop", UVM_LOW)
    
    @(negedge vif.reset);
    `uvm_info(get_type_name(), "Reset dropped", UVM_LOW)
    forever begin

      seq_item_port.get_next_item(packet);
          `uvm_info(get_type_name(), $sformatf("Packet:\n%s", packet.sprint()), UVM_LOW)
      send_to_dut(packet);
      seq_item_port.item_done();
     //  Add your code here to:
     //  Get new item from the sequencer
      // Drive the item
       //Communicate item done to the sequencer
    end
  endtask : get_and_drive

  // Reset all TX signals
  task reset_signals();
    forever begin
      @(posedge vif.reset);
       `uvm_info(get_type_name(), "Reset observed", UVM_MEDIUM)
      vif.in_data           <=  'hz;
      vif.in_data_vld       <= 1'b0;
     // disable send_to_dut;
    end
  endtask : reset_signals

  // Gets a packet and drive it into the DUT
  task send_to_dut(yapp_packet packet);

    // Wait for packet delay
    repeat(packet.packet_delay)
      @(negedge vif.clock);
    `uvm_info(get_type_name(),"Delay done",UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("in_suspend=%b,clock=%b", vif.in_suspend,vif.clock), UVM_LOW)
    // Start to send packet if not in_suspend signal
      @(negedge vif.clock iff (!vif.in_suspend));

    // Begin Transaction recording
    void'(this.begin_tr(packet, "Input_YAPP_Packet"));

    // Enable start packet signal
    vif.in_data_vld <= 1'b1;

    // Drive the Header {Length, Addr}
    vif.in_data <= { packet.length, packet.addr };

    // Drive Payload
    for (int i=0; i<packet.payload.size(); i++) begin
      @(negedge vif.clock iff (!vif.in_suspend))
      vif.in_data <= packet.payload[i];
    end
    // Drive Parity and reset Valid
    @(negedge vif.clock iff (!vif.in_suspend))
    vif.in_data_vld <= 1'b0;
    vif.in_data  <= packet.parity;

    @(negedge  vif.clock)
      vif.in_data  <= 8'bz;
    num_sent++;

    // End transaction recording
    this.end_tr(packet);

  endtask : send_to_dut

  // UVM report_phase() 
  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: YAPP TX driver sent %0d packets", num_sent), UVM_LOW)
  endfunction : report_phase
endclass

