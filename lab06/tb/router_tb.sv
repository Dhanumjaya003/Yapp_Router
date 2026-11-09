class router_tb extends uvm_component;
	`uvm_component_utils(router_tb);

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	yapp_env env;

	function void build_phase(uvm_phase phase);
		uvm_config_db#(int)::set(null,"*","recording detail",1);
		super.build_phase(phase);
		env=yapp_env::type_id::create("env",this);
	endfunction
endclass
