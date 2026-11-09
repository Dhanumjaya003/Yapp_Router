class router_module_env extends uvm_component;
  `uvm_component_utils(router_module_env)
  
  router_scoreboard rt_scb;
  router_reference rt_ref;
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rt_scb=router_scoreboard::type_id::create("rt_scb",this);
    rt_ref=router_reference::type_id::create("rt_ref",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    rt_ref.valid_yapp.connect(rt_scb.yapp_imp);
  endfunction
endclass
