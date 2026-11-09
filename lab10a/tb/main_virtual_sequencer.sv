class main_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(main_virtual_sequencer)

  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  hbus_master_sequencer hbus_mas_sqr;
  yapp_tx_sequencer yapp_tx_sqr;   
endclass
