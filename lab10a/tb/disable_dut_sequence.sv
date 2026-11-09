class disable_dut_sequence extends uvm_sequence;
  `uvm_object_utils(disable_dut_sequence)

  function new(string name="disable_dut_sequence");
    super.new(name);
  endfunction

  hbus_set_yapp_regs_seq yapp_dis_regs;
  //task pre_body();
  //  if(starting_phase !=null)
  //    starting_phase.raise_objection(this);
  //endtask
  virtual task body();
    yapp_dis_regs=hbus_set_yapp_regs_seq::type_id::create("yapp_dis_regs");
    `uvm_do_with(yapp_dis_regs, {enable_reg==0;})
  endtask
  //task post_body();
  //  if(starting_phase !=null)
  //    starting_phase.drop_objection(this);
  //endtask

endclass

class enable_dut_sequence extends uvm_sequence;
  `uvm_object_utils(enable_dut_sequence)

  function new(string name="enable_dut_sequence");
    super.new(name);
  endfunction

  hbus_set_yapp_regs_seq yapp_en_regs;
  //task pre_body();
  //  if(starting_phase !=null)
  //    starting_phase.raise_objection(this);
  //endtask
  virtual task body();
    yapp_en_regs=hbus_set_yapp_regs_seq::type_id::create("yapp_en_regs");
    `uvm_do_with(yapp_en_regs, {enable_reg==1;})
  endtask
  //task post_body();
  //  if(starting_phase !=null)
  //    starting_phase.drop_objection(this);
  //endtask

endclass
