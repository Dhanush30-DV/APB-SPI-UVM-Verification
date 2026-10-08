class apb_sequence extends uvm_sequence#(apb_transaction);
`uvm_object_utils(apb_sequence)
function new(string name="apb_sequence");
super.new(name);
endfunction
endclass

class cpol_cpha_lsb_00 extends apb_sequence;

`uvm_object_utils(cpol_cpha_lsb_00)

function new(string name="cpol_cpha_lsb_00");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00010001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b10000000;})
finish_item(req);
endtask

endclass

class cpol_cpha_lsb_01 extends apb_sequence;

`uvm_object_utils(cpol_cpha_lsb_01)

function new(string name="cpol_cpha_lsb_01");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00010101;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b01000000;})
finish_item(req);
endtask

endclass


class cpol_cpha_lsb_10 extends apb_sequence;

`uvm_object_utils(cpol_cpha_lsb_10)

function new(string name="cpol_cpha_lsb_10");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00011001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00100000;})
finish_item(req);
endtask

endclass


class cpol_cpha_lsb_11 extends apb_sequence;

`uvm_object_utils(cpol_cpha_lsb_11)

function new(string name="cpol_cpha_lsb_11");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00011101;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00010000;})
finish_item(req);
endtask

endclass



class cpol_cpha_msb_00 extends apb_sequence;

`uvm_object_utils(cpol_cpha_msb_00)

function new(string name="cpol_cpha_msb_00");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00010000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00001000;})
finish_item(req);
endtask

endclass

class cpol_cpha_msb_01 extends apb_sequence;

`uvm_object_utils(cpol_cpha_msb_01)

function new(string name="cpol_cpha_msb_01");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00010100;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00000100;})
finish_item(req);
endtask

endclass


class cpol_cpha_msb_10 extends apb_sequence;

`uvm_object_utils(cpol_cpha_msb_10)

function new(string name="cpol_cpha_msb_10");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00011000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00000010;})
finish_item(req);
endtask

endclass


class cpol_cpha_msb_11 extends apb_sequence;

`uvm_object_utils(cpol_cpha_msb_11)

function new(string name="cpol_cpha_msb_11");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==0 ; PWDATA==8'b00011100;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==1 ; PWDATA==8'b00000000;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==2 ; PWDATA==8'b00000001;})
finish_item(req);

start_item(req);
assert(req.randomize() with {PWRITE==1 ; PADDR==5 ; PWDATA==8'b00000001;})
finish_item(req);
endtask

endclass

class apb_read extends apb_sequence;
`uvm_object_utils(apb_read)
function new(string name="apb_read");
super.new(name);
endfunction

virtual task body();
req=apb_transaction::type_id::create("req");
start_item(req);
assert(req.randomize() with { PWRITE==0 ; PADDR==5;})
finish_item(req);
endtask
endclass
