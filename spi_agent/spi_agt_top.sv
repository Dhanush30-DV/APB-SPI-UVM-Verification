class spi_agt_top extends uvm_env;

  `uvm_component_utils(spi_agt_top)

  spi_agent spi_age[];
spi_agent_configuration spi_configuration;
  function new(string name="spi_agt_top",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
uvm_config_db #(spi_agent_configuration)::get(this,"","spi_configuration",spi_configuration);
spi_age=new[spi_configuration.number_of_spi_agent];
foreach(spi_age[i]) begin
    uvm_config_db #(spi_agent_configuration)::set(this,$sformatf("spi_age_%0d",i),"spi_configuration",spi_configuration);
    spi_age[i] =spi_agent::type_id::create($sformatf("spi_age_%0d",i),this);
end
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"run phase of  spi_agent_top",UVM_LOW)
  endtask

endclass
