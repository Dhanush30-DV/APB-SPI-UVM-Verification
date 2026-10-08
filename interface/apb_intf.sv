

 `timescale 1ns / 1ps
 interface apb_intf(input bit clock);
   bit PCLK;
   logic PRESETn;
   logic PWRITE;
   logic PSEL;
   logic PENABLE;
   logic [2:0] PADDR;
   logic [7:0] PWDATA;
   logic [7:0] PRDATA;
   logic PREADY;
   logic PSLVERR;

   assign PCLK = clock;

   //APB Driver Clocking Block
   clocking apb_drv_cb @(posedge clock);
     default input #1 output #1;
     output PRESETn;
     output PWRITE;
     output PSEL;
     output PENABLE;
     output PADDR;
     output PWDATA;
     input PRDATA;
     input PREADY;
     input PSLVERR;
   endclocking

   //APB Monitor Clocking Block
   clocking apb_mon_cb @(posedge clock);
     default input #1 output #1;
     input PRESETn;
     input PWRITE;
     input PSEL;
     input PENABLE;
     input PADDR;
     input PWDATA;
     input PRDATA;
     input PREADY;
     input PSLVERR;
   endclocking

   modport APB_DRV_MP (clocking apb_drv_cb);
   modport APB_MON_MP (clocking apb_mon_cb);

   //-------------- Assertions -------------
   property signals_stable;
     @(posedge clock) $rose(PSEL)|-> ($stable(PWRITE) &&
                                        $stable(PADDR) &&
                                        $stable(PWDATA)) until PREADY[->1];
   endproperty

   property penable_stable;
     @(posedge clock) $rose(PENABLE)|->($stable(PSEL) &&
                        $stable(PENABLE)) until PREADY [->1];
   endproperty

   property psel_to_pready;
     @(posedge clock) (PSEL && PENABLE ) |->##[0:$] PREADY;
   endproperty

   property address_reserved;
     @(posedge clock) PSEL |-> ((PADDR!=3'b100) || (PADDR !=3'b110)||(PADDR!=3'b111));
   endproperty

   property penable_deassert;
     @(posedge clock) (!PSEL) |-> (!PENABLE);
   endproperty

   property valid_write_data_transfer;
     @(posedge clock) (PSEL && PENABLE && PWRITE) |->(PWDATA !== 'hx);
   endproperty

   property valid_read_data_transfer;
     @(posedge clock) (PSEL && PENABLE && (!PWRITE)) |-> (PRDATA !== 'hx);
   endproperty

   property pready_low_at_start;
     @(posedge clock) (PSEL && (!PENABLE))|-> (!PREADY);
   endproperty

   property pready_deassert;
     @(posedge clock) (!PSEL) |-> (!PREADY);
   endproperty

   SIGNAL_STABLE        : assert property(signals_stable);
   PENABLE_STABLE       : assert property(penable_stable);
   PSEL_TO_PREADY       : assert property(psel_to_pready);
   ADDRESS_RESERVED     : assert property(address_reserved);
   PENABLE_DEASSERT     : assert property(penable_deassert);
   PWDATA_TRANSFER      : assert property(valid_write_data_transfer);
   PRDATA_TRANSFER      : assert property(valid_read_data_transfer);
   PREADY_START         : assert property(pready_low_at_start);
   PREADY_DEASSERT      : assert property(pready_deassert);
 endinterface
