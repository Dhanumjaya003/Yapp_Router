`uvm_analysis_imp_decl(_yapp)
`uvm_analysis_imp_decl(_ch0)
`uvm_analysis_imp_decl(_ch1)
`uvm_analysis_imp_decl(_ch2)
class router_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(router_scoreboard)
  
  yapp_packet que_0[$],que_1[$],que_2[$];

  uvm_analysis_imp_yapp #(yapp_packet, router_scoreboard) yapp_imp;
  uvm_analysis_imp_ch0 #(yapp_packet, router_scoreboard) ch0_imp;
  uvm_analysis_imp_ch1 #(yapp_packet, router_scoreboard) ch1_imp;
  uvm_analysis_imp_ch2 #(yapp_packet, router_scoreboard) ch2_imp;

  function new(string name,uvm_component parent);
    super.new(name,parent);
    yapp_imp=new("yapp_imp",this);
    ch0_imp=new("ch0_imp",this);
    ch1_imp=new("ch1_imp",this);
    ch2_imp=new("ch2_imp",this);
  endfunction

 
  int total_packets;
  int correct_packets;
  int wrong_packets;

  function void write_yapp(yapp_packet pkt);
    yapp_packet temp;
    $cast(temp,pkt.clone());
    case(pkt.addr)
      2'b00: que_0.push_back(temp);
      2'b01: que_1.push_back(temp);
      2'b10: que_2.push_back(temp);
    endcase
  endfunction

  function void write_ch0(yapp_packet pkt);
    yapp_packet temp_0;
    if(que_0.size()==0) begin
      `uvm_error("Scb","channel_0 is empty")
      return;
    end
    else
      temp_0=que_0.pop_front();
    if(temp_0.compare(pkt)) begin
      total_packets++;
      correct_packets++;
      `uvm_info(get_type_name(),"channel 0 data is matched",UVM_LOW)
    end
    else begin
      total_packets++;
      wrong_packets++;
      `uvm_error(get_type_name(),"channel 0 data is NOT matched")
    end
  endfunction

function void write_ch1(yapp_packet pkt);
    yapp_packet temp_1;
    if(que_1.size()==0) begin
      `uvm_error("SCB","channel1 is empty")
      return;
    end
    temp_1=que_1.pop_front();
    if(temp_1.compare(pkt)) begin
      total_packets++;
      correct_packets++;
      `uvm_info(get_type_name(),"channel 1 data is matched",UVM_LOW)
    end
    else begin
      total_packets++;
      wrong_packets++;
      `uvm_error(get_type_name(),"channel 1 data is NOT matched")
    end
  endfunction

  function void write_ch2(yapp_packet pkt);
    yapp_packet temp_2;
    if(que_2.size()==0) begin
      `uvm_error("SCB","Channel_2 is empty")
      return;
    end
    temp_2=que_2.pop_front();
    if(temp_2.compare(pkt)) begin
      total_packets++;
      correct_packets++;
      `uvm_info(get_type_name(),"channel 2 data is matched",UVM_LOW)
    end
    else begin
      total_packets++;
      wrong_packets++;
      `uvm_error(get_type_name(),"channel 2 data is NOT matched")
    end
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
     `uvm_info("SCBD", $sformatf("Total Packets= %0d, Correct_packets= %0d, Wrong_packets= %0d", total_packets,correct_packets,wrong_packets),  UVM_LOW)
  endfunction

endclass
