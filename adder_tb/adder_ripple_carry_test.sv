class adder_ripple_carry_test extends adder_sequence;
    `uvm_object_utils(adder_ripple_carry_test)
    
    function new(string name="adder_ripple_carry_test");
        super.new(name);
    endfunction
    
    // Test patterns to force carry propagation through multiple bits
    task body();
        txn = adder_transaction::type_id::create("txn");
        
        // Test 1: Full ripple carry through all 16 bits
        // When a = 0xFFFF and b = 0x0001 with cin = 0
        // Each carry bit must ripple from LSB to MSB
        start_item(txn);
        txn.a = 16'hFFFF;  // All 1's
        txn.b = 16'h0001;  // Only LSB set
        txn.cin = 0;       // No carry in
        // Expected result: 0x0000 with cout = 1
        finish_item(txn);
        
        // Test 2: Full ripple carry with carry-in
        // When a = 0xFFFF and b = 0x0000 with cin = 1
        // Same ripple effect but initiated by cin
        start_item(txn);
        txn.a = 16'hFFFF;  // All 1's
        txn.b = 16'h0000;  // All 0's
        txn.cin = 1;       // Carry in = 1
        // Expected result: 0x0000 with cout = 1
        finish_item(txn);
        
        // Test 3: Partial ripple through lower byte
        // When a = 0x00FF and b = 0x0001
        start_item(txn);
        txn.a = 16'h00FF;  // Lower byte all 1's
        txn.b = 16'h0001;  // Only LSB set
        txn.cin = 0;       // No carry in
        // Expected result: 0x0100 (carry ripples through lower byte)
        finish_item(txn);
        
        // Test 4: Partial ripple through upper byte
        start_item(txn);
        txn.a = 16'hFF00;  // Upper byte all 1's
        txn.b = 16'h0100;  // Bit 8 set
        txn.cin = 0;       // No carry in
        // Expected result: 0x0000 with bit 16 (cout) = 1
        finish_item(txn);
        
        // Test 5: Ripple carry triggered in the middle
        start_item(txn);
        txn.a = 16'h0FF0;  // Middle bits are 1's
        txn.b = 16'h0010;  // Bit 4 set
        txn.cin = 0;       // No carry in
        // Carry ripples through middle bits
        finish_item(txn);
        
        // Test 6: Long chain of 1's (alternating)
        // Forces carry to skip through multiple bit positions
        start_item(txn);
        txn.a = 16'hAAAA;  // 1010...
        txn.b = 16'h5555;  // 0101...
        txn.cin = 1;       // Carry in = 1
        // Expected result: All 1's with cout = 1
        finish_item(txn);
        
        // Test 7: Multi-bit carries - important for fast adders
        // Forces multiple simultaneous propagation paths
        start_item(txn);
        txn.a = 16'h7FFF;  // All bits except MSB are 1's
        txn.b = 16'h7FFF;  // All bits except MSB are 1's
        txn.cin = 1;       // Carry in = 1
        // Expected result: 0xFFFF with cout = 0
        finish_item(txn);
        
        // Test 8: Incremental ripple - walks a single 1 bit through all positions
        for (int i = 0; i < 16; i++) begin
            start_item(txn);
            txn.a = (16'hFFFF - (1 << i));  // All 1's except bit i
            txn.b = (1 << i);               // Only bit i set
            txn.cin = 0;                    // No carry in
            // Expected result: 0xFFFF with cout = 0
            finish_item(txn);
        end
    endtask
endclass