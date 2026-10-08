class apb_driver extends uvm_driver #(apb_transaction);

`uvm_component_utils(apb_driver)
virtual apb_intf.APB_DRV_MP vapb_drv_intf;
apb_agent_configuration apb_configuration;
function new(string name="apb_driver",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(apb_agent_configuration)::get(this,"","apb_configuration",apb_configuration)) begin

  `uvm_fatal(get_type_name(),"FAILD TO GET THE APB CONFIG");
end
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
vapb_drv_intf=apb_configuration.apb_interface;
endfunction

task run_phase(uvm_phase phase);
 reset_dut();
forever begin

  seq_item_port.get_next_item(req);
     send_to_dut(req);
  seq_item_port.item_done();
end
endtask

task reset_dut();
    @(vapb_drv_intf.apb_drv_cb);
    vapb_drv_intf.apb_drv_cb.PRESETn <= 1'b0;
    vapb_drv_intf.apb_drv_cb.PSEL    <= 1'b0;
    vapb_drv_intf.apb_drv_cb.PENABLE <= 1'b0;
    vapb_drv_intf.apb_drv_cb.PADDR   <= '0;
    vapb_drv_intf.apb_drv_cb.PWRITE  <= 1'b0;
    vapb_drv_intf.apb_drv_cb.PWDATA  <= '0;
    repeat (2) @(vapb_drv_intf.apb_drv_cb);
    vapb_drv_intf.apb_drv_cb.PRESETn <= 1'b1;
  endtask

task send_to_dut(apb_transaction xtn);
@(vapb_drv_intf.apb_drv_cb);
vapb_drv_intf.apb_drv_cb.PSEL<=1'b1;
vapb_drv_intf.apb_drv_cb.PENABLE<=1'b0;
vapb_drv_intf.apb_drv_cb.PADDR<=xtn.PADDR;
vapb_drv_intf.apb_drv_cb.PWRITE<=xtn.PWRITE;
if(xtn.PWRITE) begin
vapb_drv_intf.apb_drv_cb.PWDATA<=xtn.PWDATA;
end
//access state
@(vapb_drv_intf.apb_drv_cb);
vapb_drv_intf.apb_drv_cb.PENABLE<=1'b1;
do begin
  @(vapb_drv_intf.apb_drv_cb);
end while (!vapb_drv_intf.apb_drv_cb.PREADY);//PREADY TELL THE APB TRANSACTION SENT   TO SPI COMPLETED
if(xtn.PWRITE==1'b0)begin
xtn.PRDATA=vapb_drv_intf.apb_drv_cb.PRDATA;
end
vapb_drv_intf.apb_drv_cb.PSEL<=1'b0;
vapb_drv_intf.apb_drv_cb.PENABLE<=1'b0;

endtask
endclass
