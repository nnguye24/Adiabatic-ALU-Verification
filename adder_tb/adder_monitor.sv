class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)

    adder_transaction txn;
    virtual intf vif;
    uvm_analysis_port#(adder_transaction) ap_mon;   // analysis port monitor

    function new(string name="",uvm_component parent);  
        super.new(name,parent);
        ap_mon = new("ap_mon", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif)))
        begin
            `uvm_fatal("monitor","unable to get interface")
        end
        txn=adder_transaction::type_id::create("txn",this);
    endfunction 

    task run_phase(uvm_phase phase);
        forever
        begin
            @(negedge vif.clk);
            
            // Use the existing transaction object
            txn.a = vif.a;
            txn.b = vif.b;
            txn.cin = vif.cin;
            txn.cout = vif.cout;
            txn.out = vif.out;
            txn.propagate = vif.propagate;
            txn.generate_ = vif.generate_;
            txn.clkp_out = vif.clkp_out;  // Capture clock signals
            txn.clkn_out = vif.clkn_out;
            
            // Calculate expected values for checking in scoreboard
            txn.calculatePG();
            
            // Send to scoreboard
            ap_mon.write(txn);
        end
    endtask
endclass