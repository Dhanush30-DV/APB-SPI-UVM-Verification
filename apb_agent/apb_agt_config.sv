class apb_agent_configuration extends uvm_object;

`uvm_object_utils(apb_agent_configuration)
virtual apb_intf apb_interface;
int apb_mon_rcvd_xtn_cnt=0;
int number_of_apb_agent=1;
uvm_active_passive_enum is_active=UVM_ACTIVE;
function new(string name="apb_agent_configuration");
super.new(name);
endfunction
endclass
