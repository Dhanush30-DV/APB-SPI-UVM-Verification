class apb_agt_top extends uvm_env;
  `uvm_component_utils(apb_agt_top)
  apb_agent apb_age[];
apb_agent_configuration apb_configuration;
  function new(string name="apb_agt_top",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
uvm_config_db #(apb_agent_configuration)::get(this,"","apb_configuration",apb_configuration);
apb_age=new[apb_configuration.number_of_apb_agent];
foreach(apb_age[i]) begin

    uvm_config_db #(apb_agent_configuration)::set(this,$sformatf("apb_age_%0d",i),"apb_configuration",apb_configuration);
    apb_age[i] =apb_agent::type_id::create($sformatf("apb_age_%0d",i),this);
  end
endfunction
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"run phase of  apb_agent_top",UVM_LOW)
  endtask
endclass
