class adder_monitor extends uvm_monitor;

    function new(string name="",uvm_component parent);  
        super.new(name,parent);
    endfunction

    adder_transaction txn;
    virtual intf vif;
    uvm_analysis_port#(adder_transaction) ap_mon;   // analysis port monitor


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
        begin
            `uvm_fatal("monitor","unable to get interface")
        end
        ap_mon = new("ap_mon", this);
        txn=adder_transaction::type_id::create("txn",this);
    endfunction 

    task run_phase(uvm_phase phase);
        forever
        begin
            @(negedge vif.clk);
            txn.a = vif.a;
            txn.b = vif.b;
            txn.cin = vif.cin;
            txn.cout = vif.cout;  // Fixed syntax error (missing semicolon)
            txn.out = vif.out;
            txn.propagate = vif.propagate;  // Sample propagate signals
            txn.generate_ = vif.generate_;  // Sample generate signals
            
            // Calculate expected values for checking in scoreboard
            txn.calculatePG();
            
            // Send to scoreboard
            ap_mon.write(txn);
        end
    endtask




endclass: adder_monitor