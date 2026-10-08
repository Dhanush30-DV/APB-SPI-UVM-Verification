class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  apb_agent_configuration apb_configuration;
  uvm_analysis_port #(apb_transaction) apb_analysis_port;

  virtual apb_intf.APB_MON_MP apb_if;

  extern function new(string name = "apb_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task collect_data();
  extern function void report_phase(uvm_phase phase);
endclass

function apb_monitor::new(string name = "apb_monitor", uvm_component parent);
  super.new(name, parent);
  apb_analysis_port = new("apb_analysis_port", this);
endfunction

function void apb_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db #(apb_agent_configuration)::get(this, "", "apb_agent_configuration", apb_configuration))
    `uvm_fatal(get_type_name(), "Cannot get apb_configuration from uvm_config_db. Have you set it?")
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  apb_if = apb_configuration.apb_interface;
endfunction

task apb_monitor::run_phase(uvm_phase phase);
  forever begin
    collect_data();
  end
endtask

task apb_monitor::collect_data();
  apb_transaction xtn;
  xtn = apb_transaction::type_id::create("xtn");

  do begin
    @(apb_if.apb_mon_cb);
  end while (!(apb_if.apb_mon_cb.PENABLE && apb_if.apb_mon_cb.PREADY));

  xtn.PRESETn = apb_if.apb_mon_cb.PRESETn;
  xtn.PADDR   = apb_if.apb_mon_cb.PADDR;
  xtn.PWRITE  = apb_if.apb_mon_cb.PWRITE;
  xtn.PSEL    = apb_if.apb_mon_cb.PSEL;
  xtn.PENABLE = apb_if.apb_mon_cb.PENABLE;

  if (apb_if.apb_mon_cb.PWRITE)
    xtn.PWDATA = apb_if.apb_mon_cb.PWDATA;
  else
    xtn.PRDATA = apb_if.apb_mon_cb.PRDATA;

  xtn.PREADY  = apb_if.apb_mon_cb.PREADY;
  xtn.PSLVERR = apb_if.apb_mon_cb.PSLVERR;

  `uvm_info(get_type_name(), $sformatf("The Data Collected from APB Monitor is \n %s", xtn.sprint()), UVM_LOW)

  apb_analysis_port.write(xtn);
  apb_configuration.apb_mon_rcvd_xtn_cnt++;

  @(apb_if.apb_mon_cb);
endtask

function void apb_monitor::report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info(get_type_name(), $sformatf("APB Monitor : The no of transactions collected are %0d", apb_configuration.apb_mon_rcvd_xtn_cnt), UVM_LOW)
endfunction
