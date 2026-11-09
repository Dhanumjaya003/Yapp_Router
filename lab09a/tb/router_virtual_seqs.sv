//`include "../sv/yapp_tx_seqs.sv"
class router_simple_vseq extends uvm_sequence;
  `uvm_object_utils(router_simple_vseq)
  `uvm_declare_p_sequencer(router_virtual_sequencer)

  function new(string name="router_simple_vseq");
    super.new(name);
  endfunction

  hbus_small_packet_seq small_pkt_seq;
  hbus_read_max_pkt_seq read_max_pkt_seq;
  hbus_set_default_regs_seq set_def_regs_seq;
  yapp_012_seq seq_012; 
  six_yapp_seq seq_six;

  task pre_body();
    if(starting_phase != null)
      starting_phase.raise_objection(this);
    `uvm_info(get_type_name(),"phase is shutting UP",UVM_LOW)
  endtask

  task body();  
    //to accept small_packets payload length <21
    `uvm_info(get_type_name(),"small_pkt_seq is starting",UVM_LOW)
    small_pkt_seq=hbus_small_packet_seq::type_id::create("small_pkt_seq");
    small_pkt_seq.start(p_sequencer.hbus_mas_sqr);
    `uvm_info(get_type_name(),"small_pkt_seq is ended",UVM_LOW)

  
    //to read the MAXPKTSIZE register to make sure it is correctly set or not
    `uvm_info(get_type_name(),"MAXPKTSIZE register sequence is starting",UVM_LOW)
    read_max_pkt_seq=hbus_read_max_pkt_seq::type_id::create("ream_max_pkt_seq");
    read_max_pkt_seq.start(p_sequencer.hbus_mas_sqr);
    `uvm_info(get_type_name(),"MAXPKTSIZE register sequence is ended",UVM_LOW)
    
    //six consecutive packets to address 0,1,2, cycling the address
    repeat (2) begin
      `uvm_info(get_type_name(),"six consecutive packets seq is starting",UVM_LOW)
      seq_012=yapp_012_seq::type_id::create("seq_012");
      seq_012.start(p_sequencer.yapp_tx_sqr);
      `uvm_info(get_type_name(),"six consecutive packets seq is ended",UVM_LOW)

    end

    //to accept large packets payload length <64
    `uvm_info(get_type_name(),"Large packets payload length is starting",UVM_LOW)
    set_def_regs_seq=hbus_set_default_regs_seq::type_id::create("set_def_regs_seq");
    set_def_regs_seq.start(p_sequencer.hbus_mas_sqr);
    `uvm_info(get_type_name(),"Large packets payload length is ended",UVM_LOW)


    //random sequence of six packets
    `uvm_info(get_type_name(),"seq_six is starting",UVM_LOW)
    seq_six=six_yapp_seq::type_id::create("seq_six");
    seq_six.randomize();
    seq_six.start(p_sequencer.yapp_tx_sqr);
    `uvm_info(get_type_name(),"seq_six is ended",UVM_LOW)

  endtask

  task post_body();
    if(starting_phase !=null)
      starting_phase.drop_objection(this);
    `uvm_info(get_type_name(),"phase is dropping down",UVM_LOW)
  endtask

endclass    
