class spi_sequence extends uvm_sequence #(spi_transaction);
`uvm_object_utils(spi_sequence)
function new(string name="spi_sequence");
super.new(name);
endfunction
endclass

class spi_cpol_cpha_lsb_00 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_lsb_00)
function  new(string name="spi_cpol_cpha_lsb_00");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_lsb_01 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_lsb_01)
function  new(string name="spi_cpol_cpha_lsb_01");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_lsb_10 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_lsb_10)
function  new(string name="spi_cpol_cpha_lsb_10");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_lsb_11 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_lsb_11)
function  new(string name="spi_cpol_cpha_lsb_11");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_msb_00 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_msb_00)
function new(string name="spi_cpol_cpha_msb_00");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_msb_01 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_msb_01)
function new(string name="spi_cpol_cpha_msb_01");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_msb_10 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_msb_10)
function new(string name="spi_cpol_cpha_msb_10");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass

class spi_cpol_cpha_msb_11 extends spi_sequence;
 `uvm_object_utils(spi_cpol_cpha_msb_11)
function  new(string name="spi_cpol_cpha_msb_11");
super.new(name);
endfunction
virtual task body();
 spi_transaction req;
req=spi_transaction::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass
