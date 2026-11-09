
class yapp_base_seq extends uvm_sequence #(yapp_packet);
	`uvm_object_utils(yapp_base_seq)

	yapp_packet pkt;

	function new(string name="yapp_base_sequence");
		super.new(name);
		pkt=yapp_packet::type_id::create("pkt");
	endfunction

  task pre_body();
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask
  task post_body();
    if(starting_phase!=null)
      starting_phase.drop_objection(this);
  endtask
endclass

//class yapp_normal_seq extends uvm_sequence #(short_yapp_packet);
//	`uvm_object_utils(yapp_normal_seq)
//
//	short_yapp_packet s_pkt;
//
//	function new(string name="yapp_normal_seq");
//		super.new(name);
//		s_pkt=short_yapp_packet::type_id::create("s_pkt");
//	endfunction
//endclass
	
class yapp_5_packets extends yapp_base_seq;

  `uvm_object_utils(yapp_5_packets)

  function new(string name = "yapp_5_packets");
    super.new(name);
  endfunction


  virtual task body();
    repeat (5) begin
      yapp_packet pkt;
      //pkt = yapp_packet::type_id::create("pkt", this);
      `uvm_do(pkt)
    end
  endtask

endclass

class yapp_012_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_012_seq)

	function new(string name="yapp_012_seq");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_info(get_full_name(), "Executing yapp_012_seq sequence", UVM_LOW)
    	`uvm_do_with(pkt, { addr == 2'b00; })
   		`uvm_do_with(pkt, { addr == 2'b01; })
    	`uvm_do_with(pkt, { addr == 2'b10; })
	endtask
endclass

class yapp_1_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_1_seq)

	function new(string name="yapp_1_seq");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_info(get_full_name(), "Executing yapp_1_seq sequence", UVM_LOW)
 		`uvm_do_with(pkt, { addr == 2'b01; })
	endtask
endclass

class yapp_111_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_111_seq)
	
	yapp_1_seq s1;
	function new(string name="yapp_012_seq");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_info(get_full_name(), "Executing yapp_111_seq sequence", UVM_LOW)
 		repeat (3) `uvm_do(s1)
	endtask
endclass

class yapp_repeat_address_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_repeat_address_seq)
	
	int prev_address;
	function new(string name="yapp_012_seq");
		super.new(name);
	endfunction

	virtual task body();
		`uvm_info(get_full_name(), "Executing yapp_repeat_address_seq sequence", UVM_LOW)
	//	`uvm_do_with(pkt {addr!=3;})
		prev_address=pkt.addr;
		`uvm_do_with(pkt, {addr==prev_address;})
	endtask
endclass

//------------------------------------------------------------
// yapp_incr_payload_seq: payload bytes increment 0 .. length-1
//------------------------------------------------------------
class yapp_incr_payload_seq extends yapp_base_seq;
  `uvm_object_utils(yapp_incr_payload_seq)

  function new(string name = "yapp_incr_payload_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_full_name(), "Executing sequence yapp_incr_payload_seq", UVM_LOW)

	`uvm_create(pkt)

    assert(pkt.randomize());
	for(int i=0; i<pkt.length;i++)
		pkt.payload[i]=i;

	pkt.post_randomize();
	`uvm_send(pkt);
  endtask
endclass

class yapp_rnd_seq extends yapp_base_seq;
	`uvm_object_utils(yapp_rnd_seq)

	function new(string name="yapp_rnd_seq");
		super.new(name);
	endfunction

	rand int count;
	constraint count_c { count inside {[1:10]}; }
	virtual task body();
		`uvm_info(get_full_name(),
              $sformatf("Executing sequence yapp_rnd_seq with count = %0d", count),
              UVM_LOW)
    repeat (count)
      `uvm_do(pkt)	
	endtask
endclass

class six_yapp_seq extends yapp_base_seq;
	`uvm_object_utils(six_yapp_seq)

	function new(string name="six_yapp_seq");
		super.new(name);
	endfunction
	
//	yapp_rnd_seq seq_six;
	rand int count;
	constraint count_c { count==6; }
	virtual task body();
		`uvm_info(get_full_name(),
              $sformatf("Executing sequence six_yapp_seq with count = %0d", count),
              UVM_LOW)
    repeat (count)
      `uvm_do(pkt)	
	endtask

endclass
