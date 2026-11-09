`uvm_analysis_imp_decl(_yappr)
`uvm_analysis_imp_decl(_hbus)
class router_reference extends uvm_component;
  `uvm_component_utils(router_reference)
  
  function new(string name,uvm_component parent);
    super.new(name,parent);
  endfunction

  int dropped;

  uvm_analysis_imp_yappr #(yapp_packet, router_reference) yapp_imp1;
  uvm_analysis_imp_hbus #(hbus_transaction, router_reference) hbus_imp;
  uvm_analysis_port #(yapp_packet) valid_yapp;

  //default values of MAXPKTSIZE and ENABLE
  bit [7:0]maxpktsize='h3f;
  bit router_enable='h1;

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    yapp_imp1=new("yapp_imp1",this);
    hbus_imp=new("hbus_imp",this);
    valid_yapp=new("valid_yapp",this);
  endfunction

  function void write_hbus(hbus_transaction tr);
    hbus_transaction temp=tr;
    if(temp.haddr==0)
      maxpktsize=tr.hdata;
    else if(temp.haddr==1) begin
      router_enable=tr.hdata;
    $display("router_en=%d,tr.hdata=%d",router_enable,tr.hdata);
  end
  endfunction

  function void write_yappr(yapp_packet pkt);
    `uvm_info(get_type_name(),$sformatf("pkt.length=%d,maxpktsize=%d,pkt.addr=%d",pkt.length,maxpktsize,pkt.addr),UVM_LOW)
    `uvm_info(get_type_name(),$sformatf("router_en=%d",router_enable),UVM_LOW)
    if(!router_enable) begin
      dropped++;
      `uvm_info(get_type_name(),$sformatf("dropped=%d",dropped),UVM_LOW)
      return;       
    end
   
    if(pkt.length>maxpktsize) begin
      dropped++;
      `uvm_info(get_type_name(),$sformatf("dropped=%d",dropped),UVM_LOW)
      return;
    end

    if(pkt.addr==3) begin
      dropped++;
      `uvm_info(get_type_name(),$sformatf("dropped=%d",dropped),UVM_LOW)
      return;
       
    end
    valid_yapp.write(pkt);
     endfunction

  function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(),$sformatf("dropped=%d",dropped),UVM_LOW)
  endfunction
endclass

