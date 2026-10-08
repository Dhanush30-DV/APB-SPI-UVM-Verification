class spi_agent_configuration extends uvm_object;
`uvm_object_utils(spi_agent_configuration)
uvm_active_passive_enum is_active=UVM_ACTIVE;
int number_of_spi_agent=1;
virtual spi_intf spi_interface;
int spi_mon_observed_count=0;
function new(string name="spi_agent_configuration");
super.new(name);
endfunction
endclass
