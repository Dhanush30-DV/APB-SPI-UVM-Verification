class apb_transaction extends uvm_sequence_item;
`uvm_object_utils(apb_transaction)
 function new(string name="apb_transaction");
super.new(name);
endfunction
bit PCLK;
bit PRESETn;
rand bit [2:0]PADDR;
rand bit PWRITE;
bit PSEL;
bit PENABLE;
rand bit [7:0]PWDATA;
bit PREADY;
bit PSLVERR;
bit [7:0] PRDATA;
constraint c1{(PWRITE==1)->PADDR inside{[0:2],5};
              (PWRITE==0)->PADDR inside{[0:3],5};
             }
function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("PCLK",     this.PCLK,     1, UVM_BIN);
    printer.print_field("PRESETn",  this.PRESETn,  1, UVM_BIN);
    printer.print_field("PADDR",    this.PADDR,    3, UVM_HEX);
    printer.print_field("PWRITE",   this.PWRITE,   1, UVM_BIN);
    printer.print_field("PSEL",     this.PSEL,     1, UVM_BIN);
    printer.print_field("PENABLE",  this.PENABLE,  1, UVM_BIN);
    printer.print_field("PWDATA",   this.PWDATA,   8, UVM_HEX);
    printer.print_field("PREADY",   this.PREADY,   1, UVM_BIN);
    printer.print_field("PSLVERR",  this.PSLVERR,  1, UVM_BIN);
    printer.print_field("PRDATA",   this.PRDATA,   8, UVM_HEX);
endfunction
endclass
