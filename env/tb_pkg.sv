package tb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import apb_agent_pkg::*;
  import spi_agent_pkg::*;

  `include "env_config.sv"
  `include "virtual_sequencer.sv"
  `include "scoreboard.sv"
  `include "env.sv"
  `include "write_virtual_sequence.sv"
  `include "read_virtual_sequence.sv"
  `include "write_read_virtual_sequence.sv"

endpackage : tb_pkg
