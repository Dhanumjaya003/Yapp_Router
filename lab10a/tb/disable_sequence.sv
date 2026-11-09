class disable_sequence extends uvm_sequence;
  `uvm_object_utils(disable_sequence)

  function new (string name ="disable_sequence");
    super.new(name);
  endfunction
  yapp_packet pkt;
  task pre_body();
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask

  virtual task body();
      pkt=yapp_packet::type_id::create("pkt");
      `uvm_do_with(pkt, {length<=20; parity_type==GOOD_PARITY;})
      //`uvm_do_with(pkt, {addr==0;})
      `uvm_do_with(pkt, {length<=20; parity_type==GOOD_PARITY;})
  endtask

  task post_body();
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask

endclass
