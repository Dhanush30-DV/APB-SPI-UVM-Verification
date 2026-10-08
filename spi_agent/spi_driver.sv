class spi_driver extends uvm_driver #(spi_transaction);
`uvm_component_utils(spi_driver)
virtual spi_intf.SPI_DRV_MP vspi_dmod_intf;
spi_agent_configuration spi_configuration;
function new(string name="spi_driver",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!(uvm_config_db #(spi_agent_configuration)::get(this,"","spi_configuration",spi_configuration))) begin
 `uvm_fatal(get_type_name(),"failed to get the spi config");
 end
endfunction

virtual function void connect_phase(uvm_phase phase);
vspi_dmod_intf=spi_configuration.spi_interface;
endfunction

virtual task run_phase(uvm_phase phase);
forever begin
 seq_item_port.get_next_item(req);
    send_to_dut(req);
 seq_item_port.item_done();
end
endtask

virtual task send_to_dut(spi_transaction req);
 bit [7:0] control1;
 bit lsb;
 bit cpha;
 bit cpol;
 if(!(uvm_config_db #(bit [7:0])::get(this,"","control",control1))) begin
    `uvm_fatal (get_type_name(),"failed to get the control sigal value");
 end
lsb=control1[0];
cpha= control1[2];
cpol= control1[3];
wait(!vspi_dmod_intf.spi_drv_cb.ss);
if(!cpha) begin
 vspi_dmod_intf.spi_drv_cb.miso<=req.miso[lsb?0:7];
 end

for(int i=(cpha?0:1);i<8;i++) begin
 if(cpol^cpha) begin
  @(posedge vspi_dmod_intf.spi_drv_cb.sclk);
  end else begin

  @(negedge vspi_dmod_intf.spi_drv_cb.sclk);
 end

 vspi_dmod_intf.spi_drv_cb.miso<=req.miso[lsb?i:7-i];
end
endtask
endclass
