class adder_sequence extends uvm_sequence#(adder_transaction);
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

// Zero A sequence
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

// Zero B sequence
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

// CIN = 1 sequence
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

// Boundary test sequence
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

// All bits test sequence
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

// Propagate test sequence
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

// Generate test sequence
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

// Ripple-carry test sequence
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
        
        // Test 8: Incremental ripple - reduced to only key bits to minimize vectors
        for (int i = 0; i < 16; i += 4) begin
            start_item(txn);
            txn.a = (16'hFFFF - (1 << i));  // All 1's except bit i
            txn.b = (1 << i);               // Only bit i set
            txn.cin = 0;                    // No carry in
            // Expected result: 0xFFFF with cout = 0
            finish_item(txn);
        end
    endtask
endclass

class adder_bit_positions extends adder_sequence;
    `uvm_object_utils(adder_bit_positions)
    
    function new(string name="adder_bit_positions");
        super.new(name);
    endfunction
    // Bit positions 0 - 15
    task body();
        txn = adder_transaction::type_id::create("txn");
        // position 0
        start_item(txn);
        txn.a = 16'h0001;
        txn.b = 16'h0001; 
        txn.cin = 0;
        finish_item(txn);
        // position 1
        start_item(txn);
        txn.a = 16'h0002; 
        txn.b = 16'h0002; 
        txn.cin = 0;
        finish_item(txn);
        // position 2
        start_item(txn);
        txn.a = 16'h0004; 
        txn.b = 16'h0004; 
        txn.cin = 0;
        finish_item(txn);
        // position 3
        start_item(txn);
        txn.a = 16'h0008; 
        txn.b = 16'h0008; 
        txn.cin = 0;
        finish_item(txn);
        // position 4
        start_item(txn);
        txn.a = 16'h0010; 
        txn.b = 16'h0010; 
        txn.cin = 0;
        finish_item(txn);
        // position 5
        start_item(txn);
        txn.a = 16'h0020; 
        txn.b = 16'h0020; 
        txn.cin = 0;
        finish_item(txn);
        // position 6
        start_item(txn);
        txn.a = 16'h0040; 
        txn.b = 16'h0040; 
        txn.cin = 0;
        finish_item(txn);
        // position 7
        start_item(txn);
        txn.a = 16'h0080; 
        txn.b = 16'h0080; 
        txn.cin = 0;
        finish_item(txn);
        // position 8
        start_item(txn);
        txn.a = 16'h0100; 
        txn.b = 16'h0100; 
        txn.cin = 0;
        finish_item(txn);
        // position 9
        start_item(txn);
        txn.a = 16'h0200; 
        txn.b = 16'h0200; 
        txn.cin = 0;
        finish_item(txn);
        // position 10
        start_item(txn);
        txn.a = 16'h0400; 
        txn.b = 16'h0400; 
        txn.cin = 0;
        finish_item(txn);
        // position 11
        start_item(txn);
        txn.a = 16'h0800; 
        txn.b = 16'h0800; 
        txn.cin = 0;
        finish_item(txn);
        // position 12
        start_item(txn);
        txn.a = 16'h1000; 
        txn.b = 16'h1000; 
        txn.cin = 0;
        finish_item(txn);
        // position 13
        start_item(txn);
        txn.a = 16'h2000; 
        txn.b = 16'h2000; 
        txn.cin = 0;
        finish_item(txn);
        // position 14
        start_item(txn);
        txn.a = 16'h4000; 
        txn.b = 16'h4000; 
        txn.cin = 0;
        finish_item(txn);
        // position 15
        start_item(txn);
        txn.a = 16'h8000; 
        txn.b = 16'h8000; 
        txn.cin = 0;
        finish_item(txn);
    endtask
endclass