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
      `uvm_do_with(pkt, {length==63; parity_type==GOOD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length==63; parity_type==GOOD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length==63; parity_type==GOOD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length==63; parity_type==BAD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length==63; parity_type==BAD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length==63; parity_type==BAD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=41;    length<=62; parity_type==GOOD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=41;    length<=62; parity_type==GOOD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=41;    length<=62; parity_type==GOOD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=41;    length<=62; parity_type==BAD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=41;    length<=62; parity_type==BAD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=41; length<=62; parity_type==BAD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length==1; parity_type==GOOD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length==1; parity_type==GOOD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length==1; parity_type==GOOD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length==1; parity_type==BAD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length==1; parity_type==BAD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length==1; parity_type==BAD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==GOOD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==GOOD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==GOOD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==BAD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==BAD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=2;    length<=10; parity_type==BAD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==GOOD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==GOOD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==GOOD_PARITY; addr==2;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==BAD_PARITY; addr==0;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==BAD_PARITY; addr==1;})
      `uvm_do_with(pkt, {length>=11;    length<=40; parity_type==BAD_PARITY; addr==2;})
      
  endtask

  task post_body();
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask

endclass
