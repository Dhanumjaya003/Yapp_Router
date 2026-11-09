`include "disable_sequence.sv"
`include "disable_dut_sequence.sv"
class packet_virtual_seq extends uvm_sequence;
  `uvm_object_utils(packet_virtual_seq)
  `uvm_declare_p_sequencer(packet_virtual_sequencer)

  function new (string name="packet_virtual_seq");
    super.new(name);
  endfunction

  disable_sequence dis_seq;
  disable_dut_sequence regs_seq;
  enable_dut_sequence en_seq;
  task pre_body();
    if(starting_phase != null)
      starting_phase.raise_objection(this);
    `uvm_info(get_type_name(),"phase is shutting UP",UVM_LOW)
  endtask

  task body();

    repeat(5) begin
      `uvm_info(get_type_name(),"dis_seq has been starting",UVM_LOW)    
      dis_seq=disable_sequence::type_id::create("dis_seq");
      dis_seq.start(p_sequencer.yapp_tx_sqr);
      `uvm_info(get_type_name(),"dis_seq has been ended",UVM_LOW)
    end

    `uvm_info(get_type_name(),"disable_seq has been started",UVM_LOW)
    regs_seq=disable_dut_sequence::type_id::create("regs_seq");
    regs_seq.start(p_sequencer.hbus_mas_sqr);
    `uvm_info(get_type_name(),"disable_seq has been ended",UVM_LOW)

    #100;

    `uvm_info(get_type_name(),"enable_seq has been started",UVM_LOW)
    en_seq=enable_dut_sequence::type_id::create("en_seq");
    en_seq.start(p_sequencer.hbus_mas_sqr);
    `uvm_info(get_type_name(),"enable_seq has been ended",UVM_LOW)

  endtask

  task post_body();
    if(starting_phase != null)
      starting_phase.drop_objection(this);
    `uvm_info(get_type_name(),"phase is shutting UP",UVM_LOW)
  endtask

endclass
