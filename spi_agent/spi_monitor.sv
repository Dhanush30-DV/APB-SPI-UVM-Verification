class spi_monitor extends uvm_monitor;
`uvm_component_utils(spi_monitor)
spi_agent_configuration spi_configuration;
virtual spi_intf.SPI_MON_MP vspi_mmod_intf;
uvm_analysis_port #(spi_transaction) spi_analysis_port;
function new(string name="spi_monitor",uvm_component parent);
super.new(name,parent);
spi_analysis_port=new("spi_analysis_port",this);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!(uvm_config_db #(spi_agent_configuration)::get(this,"","spi_configuration",spi_configuration))) begin
 `uvm_fatal(get_type_name(),"failed to get the spi config");
 end
endfunction

virtual function void connect_phase(uvm_phase phase);
vspi_mmod_intf=spi_configuration.spi_interface;
endfunction

virtual task run_phase(uvm_phase phase);
forever begin

    collect_data();
end
endtask

virtual task collect_data();
spi_transaction req;
 bit [7:0] control;
 bit lsb;
 bit cpha;
 bit cpol;
 int index;

req=spi_transaction::type_id::create("req");
 if(!(uvm_config_db #(bit [7:0])::get(this,"","control",control))) begin
    `uvm_fatal (get_type_name(),"failed to get the control sigal value");
 end
lsb=control[0];
cpha= control[2];
cpol= control[3];
wait(!vspi_mmod_intf.spi_mon_cb.ss);


for(int i=0;i<8;i++) begin
index=(lsb?i:7-i);
 if(cpol^cpha) begin
  @(negedge vspi_mmod_intf.spi_mon_cb.sclk);
  end else begin

  @(posedge vspi_mmod_intf.spi_mon_cb.sclk);
 end

 req.miso[index]=vspi_mmod_intf.spi_mon_cb.miso;
 req.mosi[index]=vspi_mmod_intf.spi_mon_cb.mosi;
 req.ss=vspi_mmod_intf.spi_mon_cb.ss;
end
 `uvm_info(get_type_name(), $sformatf("The Data Collected from SPI Monitor is \n %s", req.sprint()), UVM_LOW)

 spi_analysis_port.write(req);

spi_configuration.spi_mon_observed_count++;
endtask
endclass
