class spi_agent extends uvm_agent;
`uvm_component_utils(spi_agent)
spi_sequencer spi_seqer;
spi_driver spi_dri;
spi_monitor spi_mon;
spi_agent_configuration spi_configuration;
function new(string name="spi_agent",uvm_component parent);
super.new(name,parent);
endfunction
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
spi_mon=spi_monitor::type_id::create("spi_mon",this);
if(uvm_config_db #(spi_agent_configuration)::get(this,"","spi_configuration",spi_configuration)) begin
   `uvm_info("SPI_AGENT","CONFIGURATION OBTAINED",UVM_LOW);
end
else begin

   `uvm_fatal("SPI_AGENT","CONFIGURATION NOT OBTAINED");
end
if(spi_configuration!=null && spi_configuration.is_active==UVM_ACTIVE) begin

spi_dri=spi_driver::type_id::create("spi_dri",this);
spi_seqer=spi_sequencer::type_id::create("spi_seqer",this);
end else
 begin
`uvm_info("SPI_AGENT","ONLY MONITOR IS CREATED",UVM_LOW);
end
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(spi_configuration!=null && spi_configuration.is_active==UVM_ACTIVE) begin
spi_dri.seq_item_port.connect(spi_seqer.seq_item_export);
end
endfunction
endclass
