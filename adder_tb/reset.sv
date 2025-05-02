class reset extends uvm_sequence#(adder_transaction);
  `uvm_object_utils(reset)
  
  function new(string name="reset");
    super.new(name);
  endfunction
  
  virtual task body();
    adder_transaction txn;
    txn = adder_transaction::type_id::create("txn");
    
    // Start reset sequence
    start_item(txn);
    
    // Initialize inputs to 0
    txn.a = 16'h0000;
    txn.b = 16'h0000;
    txn.cin = 1'b0;
    
    // Calculate expected values
    txn.calculatePG();
    
    finish_item(txn);
    
    // Allow some time for reset to propagate
    #10;
  endtask
endclass : reset