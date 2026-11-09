class router_module_env extends uvm_component;
  `uvm_component_utils(router_module_env)
  
  router_scoreboard rt_scb;
  router_reference rt_ref;
  uvm_analysis_export #(yapp_packet) yapp_exp;
  uvm_analysis_export #(hbus_transaction) hbus_exp;

  uvm_analysis_export #(yapp_packet) ch0_exp;
  uvm_analysis_export #(yapp_packet) ch1_exp;
  uvm_analysis_export #(yapp_packet) ch2_exp;
  function new(string name,uvm_component parent);
    super.new(name,parent);
    yapp_exp=new("yapp_exp",this);
    hbus_exp=new("hbus_exp",this);

    ch0_exp=new("ch0_exp",this);
    ch1_exp=new("ch1_exp",this);
    ch2_exp=new("ch2_exp",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rt_scb=router_scoreboard::type_id::create("rt_scb",this);
    rt_ref=router_reference::type_id::create("rt_ref",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    rt_ref.valid_yapp.connect(rt_scb.yapp_imp);

    yapp_exp.connect(rt_ref.yapp_imp1);
    hbus_exp.connect(rt_ref.hbus_imp);

    ch0_exp.connect(rt_scb.ch0_imp);
    ch1_exp.connect(rt_scb.ch1_imp);
    ch2_exp.connect(rt_scb.ch2_imp);
  endfunction
endclass
