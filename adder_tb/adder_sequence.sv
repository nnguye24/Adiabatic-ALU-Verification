class adder_sequence extends uvm_sequence#(adder_transaction)
    `uvm_object_utils(adder_sequence)

    adder_transaction txn;
    longint loop_count=40;
	
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
  longint loop_count=30;
  
  
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
  longint loop_count=30;
  
  
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
  longint loop_count=30;
  
  
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
  longint loop_count=30;
  
  
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
            txn.a == 16'h0001;
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
            txn.a == 16'h0000;
            txn.cin == 0;
            });
        finish_item(txn);
      end
  endtask:body
endclass