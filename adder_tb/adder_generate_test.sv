class adder_generate_test extends adder_sequence;
    `uvm_object_utils(adder_generate_test)
    
    function new(string name="adder_generate_test");
        super.new(name);
    endfunction
    
    // Patterns designed to test generate signals specifically
    // These create interesting generate patterns by setting specific values for a and b
    task body();
        txn = adder_transaction::type_id::create("txn");
        
        // Test 1: All generate bits = 0
        // When a = 0x0000 or b = 0x0000
        start_item(txn);
        txn.a = 16'h0000;  // All 0's
        txn.b = 16'hFFFF;  // All 1's
        txn.cin = 0;       // No carry in
        // Expected generate = 0x0000 (since a AND b = 0)
        finish_item(txn);
        
        // Test 2: All generate bits = 1
        // When a = 0xFFFF and b = 0xFFFF
        start_item(txn);
        txn.a = 16'hFFFF;  // All 1's
        txn.b = 16'hFFFF;  // All 1's
        txn.cin = 0;       // No carry in
        // Expected generate = 0xFFFF (since a AND b = 1)
        finish_item(txn);
        
        // Test 3: Alternating generate bits = 0b0101...
        // When a = 0xFFFF and b = 0x5555
        start_item(txn);
        txn.a = 16'hFFFF;  // All 1's
        txn.b = 16'h5555;  // 0101...
        txn.cin = 0;       // No carry in
        // Expected generate = 0x5555 (only where b has 1's)
        finish_item(txn);
        
        // Test 4: Alternating generate bits = 0b1010...
        // When a = 0xFFFF and b = 0xAAAA
        start_item(txn);
        txn.a = 16'hFFFF;  // All 1's
        txn.b = 16'hAAAA;  // 1010...
        txn.cin = 0;       // No carry in
        // Expected generate = 0xAAAA (only where b has 1's)
        finish_item(txn);
        
        // Test 5: Interesting pattern with both a and b having patterns
        start_item(txn);
        txn.a = 16'hAAAA;  // 1010...
        txn.b = 16'h5555;  // 0101...
        txn.cin = 0;       // No carry in
        // Expected generate = 0x0000 (all bits 0 because no overlap)
        finish_item(txn);
        
        // Test 6: Upper byte generate 
        start_item(txn);
        txn.a = 16'hFF00;  // Upper byte all 1's
        txn.b = 16'hFF00;  // Upper byte all 1's
        txn.cin = 0;       // No carry in
        // Expected generate = 0xFF00 (upper byte all 1's)
        finish_item(txn);
        
        // Test 7: Lower byte generate
        start_item(txn);
        txn.a = 16'h00FF;  // Lower byte all 1's
        txn.b = 16'h00FF;  // Lower byte all 1's
        txn.cin = 1;       // Carry in = 1
        // Expected generate = 0x00FF (lower byte all 1's)
        finish_item(txn);
        
        // Test 8: Isolated single bit generates
        for (int i = 0; i < 16; i += 4) begin
            start_item(txn);
            txn.a = (1 << i);           // Only bit i set
            txn.b = (1 << i);           // Only bit i set
            txn.cin = 0;                // No carry in
            // Expected generate = only bit i is 1
            finish_item(txn);
        end
    endtask
endclass