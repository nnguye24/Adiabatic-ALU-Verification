class adder_agent extends uvm_agent;


    `uvm_component_utils(adder_agent)
    adder_sequencer sequencer;
    adder_driver    driver;
    adder_monitor   monitor;
    // Constructor
    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Instantiate components
        sequencer = adder_sequencer::type_id::create("sequencer", this);
        driver = adder_driver::type_id::create("driver", this);
        monitor = adder_monitor::type_id::create("monitor", this);
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect sequencer to driver
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass: adder_agent
