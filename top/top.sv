module top;
  bit clock;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import test_pkg::*;
  initial begin
  clock=1'b0;
end
initial begin
forever begin
#5 clock=~clock;
end
end

apb_intf apb_interface(clock);
spi_intf spi_interface(clock);


spi_core DUT(.PCLK(apb_interface.PCLK),
             .PRESETn(apb_interface.PRESETn),
             .PWRITE(apb_interface.PWRITE),
             .PSEL(apb_interface.PSEL),
             .PENABLE(apb_interface.PENABLE),
             .PADDR(apb_interface.PADDR),
             .PWDATA(apb_interface.PWDATA),
             .PRDATA(apb_interface.PRDATA),
             .PSLVERR(apb_interface.PSLVERR),
             .PREADY(apb_interface.PREADY),
             .miso(spi_interface.miso),
             .ss(spi_interface.ss),
             .sclk(spi_interface.sclk),
             .mosi(spi_interface.mosi),
             .spi_interrupt_request(spi_interface.spi_interrupt_request));
initial begin
uvm_config_db#(virtual apb_intf)::set(null,"*","apb_interface",apb_interface);
uvm_config_db#(virtual spi_intf)::set(null,"*","spi_interface",spi_interface);
end
initial begin
`ifdef VCS
         $fsdbDumpfile("wave1.fsdb");
         $fsdbDumpvars(0, top);
         $fsdbDumpSVA(0, top);
       `endif
end
  initial begin
    run_test();
  end

endmodule
