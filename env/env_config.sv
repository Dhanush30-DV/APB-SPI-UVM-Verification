class environment_configuration extends uvm_object;

`uvm_object_utils(environment_configuration)

apb_agent_configuration apb_configuration;
spi_agent_configuration spi_configuration;
bit has_scoreboard=1;
bit has_virtual_sequencer=1;
 function new(string name="env_configuration");
super.new(name);
endfunction
endclass
