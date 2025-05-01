class adder_env extends uvm_env;
    `uvm_component_utils(adder_env) // register

    adder_agent agent;
    adder_coverage coverage;
    adder_scoreboard scoreboard;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Instantiate sub-components
        agent = uvm_agent::type_id::create("agent", this);
        scoreboard = uvm_scoreboard::type_id::create("scoreboard", this);
        coverage = uvm_coverage::type_id::create("coverage", this);

    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.ap_mon.connect(coverage_h.analysis_export);

        agent.monitor.ap_mon.connect(scoreboard_h.ap_monitor);
        agent.driver.drv2sb.connect(scoreboard_h.ap_driver);
    endfunction

endclass: adder_env
