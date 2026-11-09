//`include "../sv/yapp_tx_seqs.sv"
class main_virtual_seq extends uvm_sequence;
  `uvm_object_utils(main_virtual_seq)
  `uvm_declare_p_sequencer(main_virtual_sequencer)

  function new(string name="main_virtual_seq");
    super.new(name);
  endfunction

  yapp_good_sequence good;
  yapp_bad_sequence bad;
  yapp_bad_size_sequence bad_size;

  task pre_body();
    if(starting_phase != null)
      starting_phase.raise_objection(this);
    `uvm_info(get_type_name(),"phase is shutting UP",UVM_LOW)
  endtask

  task body();
    good=yapp_good_sequence::type_id::create("good");
    good.start(p_sequencer.yapp_tx_sqr);

    bad=yapp_bad_sequence::type_id::create("bad");
    bad.start(p_sequencer.yapp_tx_sqr);

    bad_size=yapp_bad_size_sequence::type_id::create("bad_size");
    bad_size.start(p_sequencer.yapp_tx_sqr);
  endtask

  task post_body();
    if(starting_phase !=null)
      starting_phase.drop_objection(this);
    `uvm_info(get_type_name(),"phase is shutting DOWN",UVM_LOW)
  endtask

  
endclass
