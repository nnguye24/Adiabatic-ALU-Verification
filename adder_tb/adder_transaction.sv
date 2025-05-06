class adder_transaction extends uvm_sequence_item;

    rand bit[15:0] a;
	rand bit[15:0] b;
	rand bit cin;
	bit cout;
	bit[15:0] out;
	bit[15:0] propagate;    
	bit[15:0] expected_propagate;  
	bit[15:0] generate_;           // trailing underscore to avoid keyword
	bit[15:0] expected_generate;
	bit[7:0] clkp_out;             // Added clock signals
	bit[7:0] clkn_out;

	function new(string name = "adder_transaction");
		super.new(name);
	endfunction: new
	
	// Register with factory
	`uvm_object_utils_begin(adder_transaction)
		`uvm_field_int(a, UVM_ALL_ON)
		`uvm_field_int(b, UVM_ALL_ON)
		`uvm_field_int(cin, UVM_ALL_ON)
		`uvm_field_int(out, UVM_ALL_ON)
		`uvm_field_int(cout, UVM_ALL_ON)
		`uvm_field_int(propagate, UVM_ALL_ON)
		`uvm_field_int(expected_propagate, UVM_ALL_ON)
		`uvm_field_int(generate_, UVM_ALL_ON)
		`uvm_field_int(expected_generate, UVM_ALL_ON)
		`uvm_field_int(clkp_out, UVM_ALL_ON)
		`uvm_field_int(clkn_out, UVM_ALL_ON)
	`uvm_object_utils_end
	
	// Function to calculate expected propagate and generate values 
	function void calculatePG();
		// P = a XOR b
		expected_propagate = a ^ b;
		// G = a AND b
		expected_generate = a & b;
	endfunction: calculatePG

endclass: adder_transaction


