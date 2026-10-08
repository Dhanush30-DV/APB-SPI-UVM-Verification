class read_virtual_sequence extends uvm_sequence;
`uvm_object_utils(read_virtual_sequence)
`uvm_declare_p_sequencer(virtual_sequencer)
apb_read apb_r;
function new(string name="read_virtual_sequence");
super.new(name);
endfunction

virtual task body();
repeat(8)begin
 apb_r=apb_read::type_id::create("apb_r");
 apb_r.start(p_sequencer.apb_seqer[0]);
#5000;
end
endtask
endclass
