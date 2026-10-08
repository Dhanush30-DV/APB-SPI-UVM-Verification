class apb_spi_base_test extends uvm_test;
`uvm_component_utils(apb_spi_base_test)

environment env;
environment_configuration env_configuration;

function new(string name="apb_spi_base_test",uvm_component parent=null);
super.new(name,parent);
endfunction

//build_phase
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
//Modifying
 uvm_config_db #(bit[7:0])::set(null, "*", "control", 8'b0000_0100);
env_configuration=environment_configuration::type_id::create("env_configuration",this);
env_configuration.has_scoreboard=1;
env_configuration.has_virtual_sequencer=1;

//For APB
env_configuration.apb_configuration=apb_agent_configuration::type_id::create("apb_configuration",this);
uvm_config_db #(virtual apb_intf)::get(this,"","apb_interface",env_configuration.apb_configuration.apb_interface);
env_configuration.apb_configuration.is_active=UVM_ACTIVE;
env_configuration.apb_configuration.number_of_apb_agent=1;


//For SPI

env_configuration.spi_configuration=spi_agent_configuration::type_id::create("spi_configuration",this);
uvm_config_db #(virtual spi_intf)::get(this,"","spi_interface",env_configuration.spi_configuration.spi_interface);
env_configuration.spi_configuration.is_active=UVM_ACTIVE;
env_configuration.spi_configuration.number_of_spi_agent=1;
//env config
uvm_config_db #(environment_configuration)::set(null,"*","env_configuration",env_configuration);
env = environment::type_id::create("env",this);
endfunction

virtual function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_top.print_topology();
endfunction

endclass

class spi_write_test extends apb_spi_base_test;
`uvm_component_utils(spi_write_test)
write_virtual_sequence write_vseqs;
function new(string name="spi_write_test",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
write_vseqs=write_virtual_sequence::type_id::create("write_vseqs");
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
write_vseqs.start(env.v_seqer);
#10;
phase.drop_objection(this);
endtask
endclass


class spi_read_test extends apb_spi_base_test;
`uvm_component_utils(spi_read_test)
read_virtual_sequence read_vseqs;
function new(string name="spi_read_test",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
read_vseqs=read_virtual_sequence::type_id::create("read_vseqs");
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
read_vseqs.start(env.v_seqer);
#10;
phase.drop_objection(this);
endtask
endclass


class spi_write_read_test extends apb_spi_base_test;
`uvm_component_utils(spi_write_read_test)
write_read_virtual_sequence write_read_vseqs;
function new(string name="spi_write_read_test",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
write_read_vseqs=write_read_virtual_sequence::type_id::create("write_read_vseqs");
endfunction

virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
write_read_vseqs.start(env.v_seqer);
#10;
phase.drop_objection(this);
endtask
endclass
