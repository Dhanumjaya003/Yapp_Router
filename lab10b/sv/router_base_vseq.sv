class router_base_vseq extends uvm_sequence;
  `uvm_object_utils(router_base_vseq)

  function new(string name="router_base_vseq");
    super.new(name);
  endfunction

  hbus_transaction hbus_tr;
  yapp_packet pkt;
  bit [7:0] max_pkt_size;

  task pre_body();
    if(starting_phase !=null)
      starting_phase.raise_objection(this);
  endtask

  task post_body();
    if(starting_phase !=null)
      starting_phase.drop_objection(this);
  endtask
endclass
