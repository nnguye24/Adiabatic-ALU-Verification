class adder_sequence extends uvm_sequence#(adder_transaction)


	function new(string name = "adder_sequence");
		super.new(name);
	endfunction: new

    virtual task body();
        repeat(40)
        begin
            txn=adder_transaction::type_id::create("txn");
            start_item(txn);
            assert(txn.randomize());
            txn.rst=0;
            finish_item(txn);
        end  
    endtask:body
    

endclass: adder_sequence