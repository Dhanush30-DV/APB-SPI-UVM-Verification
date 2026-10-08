class write_read_virtual_sequence extends uvm_sequence;
`uvm_object_utils(write_read_virtual_sequence)
`uvm_declare_p_sequencer(virtual_sequencer)
environment_configuration env_configuration;
apb_read apb_r;

cpol_cpha_lsb_00 lsb_00;
cpol_cpha_lsb_01 lsb_01;
cpol_cpha_lsb_10 lsb_10;
cpol_cpha_lsb_11 lsb_11;
cpol_cpha_msb_00 msb_00;
cpol_cpha_msb_01 msb_01;
cpol_cpha_msb_10 msb_10;
cpol_cpha_msb_11 msb_11;

spi_cpol_cpha_lsb_00 spi_lsb_00;
spi_cpol_cpha_lsb_01 spi_lsb_01;
spi_cpol_cpha_lsb_10 spi_lsb_10;
spi_cpol_cpha_lsb_11 spi_lsb_11;
spi_cpol_cpha_msb_00 spi_msb_00;
spi_cpol_cpha_msb_01 spi_msb_01;
spi_cpol_cpha_msb_10 spi_msb_10;
spi_cpol_cpha_msb_11 spi_msb_11;


function new(string name="write_read_virtual_sequence");
  super.new(name);
endfunction

virtual task control_bit(bit [7:0] control);
  uvm_config_db #(bit [7:0])::set(null,"*","control",control);
endtask

virtual task body();
  if(!uvm_config_db #(environment_configuration)::get(null,"","env_configuration",env_configuration))begin
    `uvm_fatal("VIRTUAL_SEQUENCE","failed to get the environment configuration");
  end

  //--------------------------------------------------------------
  control_bit(8'b00010001);
  fork
    begin
      lsb_00=cpol_cpha_lsb_00::type_id::create("lsb_00");
      lsb_00.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_lsb_00=spi_cpol_cpha_lsb_00::type_id::create("spi_lsb_00");
      spi_lsb_00.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00010101);
  fork
    begin
      lsb_01=cpol_cpha_lsb_01::type_id::create("lsb_01");
      lsb_01.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_lsb_01=spi_cpol_cpha_lsb_01::type_id::create("spi_lsb_01");
      spi_lsb_01.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00011001);
  fork
    begin
      lsb_10=cpol_cpha_lsb_10::type_id::create("lsb_10");
      lsb_10.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_lsb_10=spi_cpol_cpha_lsb_10::type_id::create("spi_lsb_10");
      spi_lsb_10.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00011101);
  fork
    begin
      lsb_11=cpol_cpha_lsb_11::type_id::create("lsb_11");
      lsb_11.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_lsb_11=spi_cpol_cpha_lsb_11::type_id::create("spi_lsb_11");
      spi_lsb_11.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00010000);
  fork
    begin
      msb_00=cpol_cpha_msb_00::type_id::create("msb_00");
      msb_00.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_msb_00=spi_cpol_cpha_msb_00::type_id::create("spi_msb_00");
      spi_msb_00.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00010100);
  fork
    begin
      msb_01=cpol_cpha_msb_01::type_id::create("msb_01");
      msb_01.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_msb_01=spi_cpol_cpha_msb_01::type_id::create("spi_msb_01");
      spi_msb_01.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00011000);
  fork
    begin
      msb_10=cpol_cpha_msb_10::type_id::create("msb_10");
      msb_10.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_msb_10=spi_cpol_cpha_msb_10::type_id::create("spi_msb_10");
      spi_msb_10.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

  //--------------------------------------------------------------
  control_bit(8'b00011100);
  fork
    begin
      msb_11=cpol_cpha_msb_11::type_id::create("msb_11");
      msb_11.start(p_sequencer.apb_seqer[0]);
    end
    begin
      spi_msb_11=spi_cpol_cpha_msb_11::type_id::create("spi_msb_11");
      spi_msb_11.start(p_sequencer.spi_seqer[0]);
    end
  join
  #5000;
  apb_r=apb_read::type_id::create("apb_r");
  apb_r.start(p_sequencer.apb_seqer[0]);
  #5000;

endtask
endclass
