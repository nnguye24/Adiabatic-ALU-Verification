class adder_sequence extends uvm_sequence#(adder_transaction)
    `uvm_object_utils(adder_sequence)

    adder_transaction txn;
    longint loop_count=5;
	
	function new(string name = "adder_sequence");
		super.new(name);
	endfunction: new

    virtual task body();
        repeat(loop_count)
        begin
            txn = adder_transaction::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize());
            finish_item(txn);
        end  
    endtask:body

endclass: adder_sequence


class adder_add_zero_a extends adder_sequence;
     
  `uvm_object_utils(adder_add_zero_a)      
  
  adder_transaction txn;
  longint loop_count=2;
  
  function new(string name="adder_add_zero_a");
      super.new(name);
  endfunction
  
  task body();
    repeat(loop_count)
      begin
        txn=adder_transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{
            txn.a == 0;
            });
        finish_item(txn);
      end
  endtask:body
endclass

class adder_add_zero_b extends adder_sequence;
     
  `uvm_object_utils(adder_add_zero_b)      
  
  adder_transaction txn;
  longint loop_count=2;
  
  function new(string name="adder_add_zero_b");
      super.new(name);
  endfunction
  
  task body();
    repeat(loop_count)
      begin
        txn=adder_transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{
            txn.b == 0;
            });
        finish_item(txn);
      end
  endtask:body
endclass

class adder_cin_1 extends adder_sequence;
     
  `uvm_object_utils(adder_cin_1)      
  
  adder_transaction txn;
  longint loop_count=2;
  
  function new(string name="adder_cin_1");
      super.new(name);
  endfunction
  
  task body();
    repeat(loop_count)
      begin
        txn=adder_transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{
            txn.cin == 1;
            });
        finish_item(txn);
      end
  endtask:body
endclass

class adder_boundary extends adder_sequence;
     
  `uvm_object_utils(adder_boundary)      
  
  adder_transaction txn;
  longint loop_count=1;
  
  function new(string name="adder_boundary");
      super.new(name);
  endfunction
  
  task body();
    repeat(loop_count)
      begin
        txn=adder_transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{
            txn.a == 16'hFFFF;
            txn.b == 16'h0001;
            txn.cin == 0;
            });
        finish_item(txn);
      end
  endtask:body
endclass

class adder_all_bits extends adder_sequence;
     
  `uvm_object_utils(adder_all_bits)      
  
  adder_transaction txn;
  longint loop_count=1;
  
  function new(string name="adder_all_bits");
      super.new(name);
  endfunction
  
  task body();
    repeat(loop_count)
      begin
        txn=adder_transaction::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{
            txn.a == 16'hFFFF;
            txn.b == 16'h0000;
            txn.cin == 0;
            });
        finish_item(txn);
      end
  endtask:body
endclass
class adder_propagate_test extends adder_sequence;
    `uvm_object_utils(adder_propagate_test)
    
    function new(string name="adder_propagate_test");
        super.new(name);
    endfunction
    
    // Patterns designed to test propagate signals specifically
    // These create interesting propagate patterns by setting specific values for a and b
    task body();
        txn = adder_transaction::type_id::create("txn");
        start_item(txn);
        
        // Test alternating 1s and 0s pattern 
        txn.a = 16'hAAAA;
        txn.b = 16'h5555; 
        txn.cin = 0;
        // propagate = all 1's
        finish_item(txn);
        
        start_item(txn);
        // Test pattern for all propagate signals = 0
        txn.a = 16'hAAAA; 
        txn.b = 16'hAAAA; 
        txn.cin = 0;
        finish_item(txn);
        
        start_item(txn);
        // propagate  = 0xF0F0
        txn.a = 16'hFFFF; 
        txn.b = 16'h0F0F; 
        txn.cin = 0;
        finish_item(txn);
        
        start_item(txn);
        // Test boundary values with propagate
        txn.a = 16'hFFFF; 
        txn.b = 16'h0000; 
        txn.cin = 0;
        finish_item(txn);
    endtask
endclass

