class adder_driver extends uvm_driver #(adder_transaction);
    uvm_analysis_port #(adder_transaction) drv2sb;

    function new(string name="",uvm_component parent);
        super.new(name,parent);
        drv2sb=new("drv2sb",this);
    endfunction


    virtual intf vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
        `uvm_fatal(get_type_name(),"unable to get interface");
        end
    endfunction

    task run_phase(uvm_phase phase);
        adder_transaction txn;
        forever begin
            seq_item_port.get_next_item(txn);
           
            vif.a <= txn.a;
            vif.b <= txn.b;
            vif.cin <= txn.cin;
            @(posedge vif.calculation_done);    // wait for calculation_done to write transaction
            drv2sb.write(txn);
            
            seq_item_port.item_done();    
        end

    endtask


endclass: adder_driver