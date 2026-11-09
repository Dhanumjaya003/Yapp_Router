class simple_test extends base_test;
  `uvm_component_utils(simple_test)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
                            "default_sequence", yapp_5_packets::get_type());
    super.build_phase(phase);
  endfunction
endclass
