class router_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(router_virtual_sequencer)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  //Handles for HBUS YAPP UVC sequencer classes
  hbus_master_sequencer hbus_mas_sqr;
  hbus_slave_sequencer hbus_slv_sqr;
  yapp_tx_sequencer yapp_tx_sqr;
endclass
