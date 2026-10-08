class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(apb_transaction) apb_fifo[];
  uvm_tlm_analysis_fifo #(spi_transaction) spi_fifo[];
  apb_transaction apb_trans;
  spi_transaction spi_trans;
  apb_transaction apb_cov_transaction;
  spi_transaction spi_cov_transaction;

  environment_configuration env_configuration;

  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name,parent);
    apb_cov_transaction=new();
    spi_cov_transaction=new();
    apb_covergroup=new();
    spi_covergroup=new();
  endfunction

   covergroup apb_covergroup;
   option.per_instance=1;
   Preset:coverpoint apb_cov_transaction.PRESETn{
          bins preset={0,1};}
   Pwrite:coverpoint apb_cov_transaction.PWRITE{
          bins pwrite={0,1};}
   Psel:coverpoint apb_cov_transaction.PSEL{
          bins psel={0,1};}
   Penable:coverpoint apb_cov_transaction.PENABLE{
          bins penable={0,1};}
   Paddr:coverpoint apb_cov_transaction.PADDR{
          bins paddr={0,1,2,3,5};}
   Pwdata:coverpoint apb_cov_transaction.PWDATA{
          bins pwdata_low={[0:8'h80]};
          bins pwdata_high={[8'h81:8'hff]};
   }
   Prdata:coverpoint apb_cov_transaction.PRDATA{
          bins prdata_low={[0:8'h80]};
          bins prdata_high={[8'h81:8'hff]};
   }
   Pready:coverpoint apb_cov_transaction.PREADY{
          bins pready={0,1};}
   Pserror:coverpoint apb_cov_transaction.PSLVERR{
          bins pslaveerror={0,1};}
   cross_point: cross Psel,Penable;
   cross_point1:cross Psel,Penable,Pready;
   endgroup

   covergroup spi_covergroup;
    option.per_instance = 1;

    slave_select : coverpoint spi_cov_transaction.ss {
        bins ss = {[0:1]};
    }

    miso_data : coverpoint spi_cov_transaction.miso {
        bins miso_low  = {[8'h00:8'h80]};
        bins miso_high = {[8'h81:8'hff]};
    }

    mosi_data : coverpoint spi_cov_transaction.mosi {
        bins mosi_low  = {[8'h00:8'h80]};
        bins mosi_high = {[8'h81:8'hff]};
    }

endgroup


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(environment_configuration)::get(this,"","env_configuration",env_configuration))
      `uvm_fatal("SCOREBOARD","CONFIGURATION NOT OBTAINED");

    apb_fifo = new[env_configuration.apb_configuration.number_of_apb_agent];
    foreach(apb_fifo[i])
      apb_fifo[i] = new($sformatf("apb_fifo_%0d", i), this);

    spi_fifo = new[env_configuration.spi_configuration.number_of_spi_agent];
    foreach(spi_fifo[i])
      spi_fifo[i] = new($sformatf("spi_fifo_%0d", i), this);
  endfunction

 virtual task run_phase(uvm_phase phase);
 fork
     begin
       foreach(apb_fifo[i]) begin
       automatic int apb_index=i;
       fork
         forever
           begin
           apb_fifo[apb_index].get(apb_trans);
           apb_cov_transaction=apb_trans;
           apb_covergroup.sample();
           compare_logic1(apb_trans,spi_trans);
           end
       join_none
     end
     end
     begin
       foreach(spi_fifo[j]) begin
       automatic int spi_index=j;
       fork
         forever
           begin
           spi_fifo[spi_index].get(spi_trans);
           spi_cov_transaction= spi_trans;
           spi_covergroup.sample();
           compare_logic2(apb_trans,spi_trans);
           end
       join_none
     end
     end
join
 endtask
virtual task compare_logic1(apb_transaction apb_trans,spi_transaction spi_trans);
wait(apb_trans !=null);
wait(spi_trans !=null);

if(apb_trans.PWRITE && apb_trans.PADDR=='b101) begin
  if(apb_trans.PWDATA==spi_trans.mosi) begin
   `uvm_info("SCOREBOARD",$sformatf("The APB_PWDATA matches the SPI_MOSI:PWDATA=%0b | mosi=%0b",apb_trans.PWDATA,spi_trans.mosi),UVM_LOW);
  end else begin
   `uvm_error("SCOREBOARD",$sformatf("The APB_PWDATA does not matches the SPI_MOSI:PWDATA=%0b | mosi=%0b",apb_trans.PWDATA,spi_trans.mosi));
  end

   `uvm_info("SCOREBOARD",$sformatf("SCOREBOARD:\n APB_TRANSACTION:\n %s \n SPI_TRANSACTION: \n %s",apb_trans.sprint(),spi_trans.sprint()),UVM_LOW);
end
endtask


virtual task compare_logic2(apb_transaction apb_trans,spi_transaction spi_trans);
wait(apb_trans !=null);
wait(spi_trans !=null);


if(!(apb_trans.PWRITE) && apb_trans.PADDR=='b101) begin
  if(apb_trans.PRDATA==spi_trans.miso) begin
   `uvm_info("SCOREBOARD",$sformatf("The APB_PRDATA  matches the SPI_MISO:PRDATA=%0b | miso=%0b",apb_trans.PRDATA,spi_trans.miso),UVM_LOW);
  end else begin
   `uvm_error("SCOREBOARD",$sformatf("The APB_PRDATA does not matches the SPI_MISO:PRDATA=%0b | miso=%0b",apb_trans.PRDATA,spi_trans.miso));
  end

   `uvm_info("SCOREBOARD",$sformatf("SCOREBOARD:\n APB_TRANSACTION:\n %s \n SPI_TRANSACTION: \n %s",apb_trans.sprint(),spi_trans.sprint()),UVM_LOW);
end
endtask
endclass
