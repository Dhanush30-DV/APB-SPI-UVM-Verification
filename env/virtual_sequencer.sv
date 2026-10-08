class virtual_sequencer extends uvm_sequencer;

   `uvm_component_utils(virtual_sequencer)

   apb_sequencer apb_seqer[];
   spi_sequencer spi_seqer[];

   function new(string name="virtual_sequencer",
                uvm_component parent=null);
      super.new(name,parent);
   endfunction

endclass
