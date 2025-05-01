class adder_transaction extends uvm_sequence_item;

    rand bit[15:0] a;
	rand bit[15:0] b;
	rand bit cin;
	bit cout;
	bit[15:0] out;

	function new(string name = "adder_transaction");
		super.new(name);
	endfunction: new
	// register with factor
	`uvm_object_utils_begin(adder_transaction)
		`uvm_field_int(a, UVM_ALL_ON)
		`uvm_field_int(b, UVM_ALL_ON)
		`uvm_field_int(cin, UVM_ALL_ON)
		`uvm_field_int(out, UVM_ALL_ON)
		`uvm_field_int(cout, UVM_ALL_ON)
	`uvm_object_utils_end

endclass: adder_transaction


