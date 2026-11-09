typedef enum {GOOD_PARITY,BAD_PARITY}parity_t;
class yapp_packet extends uvm_sequence_item;
	rand bit[5:0] length;
	rand bit[1:0] address;
	rand bit[7:0] payload[];
	rand parity_t parity_type;
	rand int packet_delay;
	bit [7:0] parity;

	`uvm_object_utils_begin(yapp_packet)
	`uvm_field_int(length,UVM_ALL_ON)
	`uvm_field_int(address,UVM_ALL_ON)
	`uvm_field_array_int(payload,UVM_ALL_ON)
	`uvm_field_enum      (parity_t, parity_type, UVM_ALL_ON)
	`uvm_field_int       (parity,       UVM_ALL_ON)
	`uvm_field_int(packet_delay,UVM_ALL_ON)
	`uvm_object_utils_end

	constraint valid_address {address<3;}
	constraint valid_len{length inside{[1:5]};}
	constraint payload_length{payload.size==length;}
	constraint parity_gen{parity_type dist{GOOD_PARITY:=5, BAD_PARITY:=1};}
	constraint delay{packet_delay inside{[0:20]};}
	
	function new(string name= "yapp_packet");
		super.new(name);
	endfunction

	function bit[7:0] calc_parity();
		bit[7:0]parity={length,address};
		foreach(payload[i]) begin
			parity=parity^payload[i];
		end
		return parity;
	endfunction

	function void post_randomize();
		parity = (parity_type == GOOD_PARITY) ? calc_parity() : ~calc_parity();
	endfunction
endclass
