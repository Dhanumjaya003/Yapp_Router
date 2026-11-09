class packet_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(packet_virtual_sequencer)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  yapp_tx_sequencer yapp_tx_sqr;
  hbus_master_sequencer hbus_mas_sqr;
endclass
