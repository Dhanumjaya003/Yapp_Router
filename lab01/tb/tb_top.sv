import uvm_pkg::*;
`include "uvm_macros.svh"
`include "../sv/yapp_packet.sv"
module tb_top;
yapp_packet pack;
initial begin
	repeat(5) begin
		pack=new();
		pack.randomize();
		pack.print();
	end
end
endmodule

