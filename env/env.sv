class environment extends uvm_env;

`uvm_component_utils(environment)

apb_agt_top apb_top;
spi_agt_top spi_top;
scoreboard score;
virtual_sequencer v_seqer;
environment_configuration env_configuration;

function new(string name="environment",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(uvm_config_db #(environment_configuration)::get(this," ","env_configuration",env_configuration)) begin
 `uvm_info("ENVIRONMENT","CONFIGURATION OBTAINED",UVM_LOW);
end
else begin
 `uvm_fatal("ENVIRONMENT","CONFIGURATION FAILED TO OBTAINE");
end


uvm_config_db #(apb_agent_configuration)::set(this,"apb_top*","apb_configuration",env_configuration.apb_configuration);
apb_top=apb_agt_top::type_id::create("apb_top",this);

uvm_config_db #(spi_agent_configuration)::set(this,"spi_top*","spi_configuration",env_configuration.spi_configuration);
spi_top=spi_agt_top::type_id::create("spi_top",this);




if(env_configuration!=null && env_configuration.has_scoreboard==1) begin
score=scoreboard::type_id::create("score",this);
end else begin

 `uvm_fatal("ENVIRONENT","FAILED TO CREATE THE SCOREBOARD");
end

if(env_configuration!=null && env_configuration.has_virtual_sequencer==1) begin
v_seqer=virtual_sequencer::type_id::create("v_seqer",this);
end else begin
 `uvm_fatal("ENVIRONENT","FAILED TO CREATE THE VIRTUAL SEQUENCER");
end
endfunction
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(v_seqer!=null) begin
v_seqer.apb_seqer=new[env_configuration.apb_configuration.number_of_apb_agent];
foreach(apb_top.apb_age[i]) begin
v_seqer.apb_seqer[i]=apb_top.apb_age[i].apb_seqer;
end

v_seqer.spi_seqer=new[env_configuration.spi_configuration.number_of_spi_agent];
foreach(spi_top.spi_age[i]) begin
v_seqer.spi_seqer[i]=spi_top.spi_age[i].spi_seqer;
end
end
if(score!=null) begin
foreach(apb_top.apb_age[i]) begin
apb_top.apb_age[i].apb_mon.apb_analysis_port.connect(score.apb_fifo[i].analysis_export);
end
foreach(spi_top.spi_age[i]) begin
spi_top.spi_age[i].spi_mon.spi_analysis_port.connect(score.spi_fifo[i].analysis_export);
end
end
endfunction
endclass
