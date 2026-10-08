class spi_transaction extends uvm_sequence_item;
`uvm_object_utils(spi_transaction)
function new(string name="spi_transaction");
super.new(name);
endfunction

bit ss;
bit sclk;
bit [7:0]mosi;
rand bit [7:0]miso;

virtual function void do_print(uvm_printer printer);
printer.print_field("ss",this.ss,1,UVM_BIN);
printer.print_field("sclk",this.sclk,1,UVM_BIN);
printer.print_field("mosi",this.mosi,8,UVM_HEX);
printer.print_field("miso",this.miso,8,UVM_HEX);
endfunction

endclass
