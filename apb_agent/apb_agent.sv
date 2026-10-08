class apb_agent extends uvm_agent;

`uvm_component_utils(apb_agent)
apb_driver apb_dri;
apb_monitor apb_mon;
apb_sequencer apb_seqer;
apb_agent_configuration apb_configuration;
function new(string name="apb_agent",uvm_component parent=null);
super.new(name,parent);
endfunction


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
apb_mon=apb_monitor::type_id::create("apb_mon",this);
if(uvm_config_db #(apb_agent_configuration)::get(this,"","apb_configuration",apb_configuration)) begin
   `uvm_info("APB_AGENT","CONFIGURATION OBTAINED",UVM_LOW);
end
else begin

   `uvm_fatal("APB_AGENT","CONFIGURATION NOT OBTAINED");
end
 uvm_config_db #(apb_agent_configuration)::set(this, "*", "apb_agent_configuration", apb_configuration);
if(apb_configuration!=null && apb_configuration.is_active==UVM_ACTIVE) begin

apb_dri=apb_driver::type_id::create("apb_dri",this);
apb_seqer=apb_sequencer::type_id::create("apb_seqer",this);
end else
 begin
`uvm_info("APB_AGENT","ONLY MONITOR IS CREATED",UVM_LOW);
end
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(apb_configuration!=null && apb_configuration.is_active==UVM_ACTIVE) begin
apb_dri.seq_item_port.connect(apb_seqer.seq_item_export);
end
endfunction
endclass
