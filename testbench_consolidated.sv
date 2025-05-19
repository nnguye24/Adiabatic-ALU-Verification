`default_nettype wire
// UVM Testbench for EDA Playground
// Include necessary UVM macros & packages
`include "uvm_macros.svh"
import uvm_pkg::*;

// Interface definition
interface intf(input logic clk, reset);
    // Inputs
    logic [15:0] a;
    logic [15:0] b;
    logic cin;
    
    // Outputs
    logic [15:0] out;
    logic cout;
    logic calculation_done;
    logic [7:0] clkp_out;
    logic [7:0] clkn_out;
    
    // Verification signals
    logic [15:0] propagate;  
    logic [15:0] generate_;   // trailing underscore to avoid keyword
    
    // Modport for TB
    modport TB (
        input out, cout, calculation_done, clkp_out, clkn_out, propagate, generate_,
        output a, b, cin,
        input clk, reset
    );
endinterface : intf

// Transaction class
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

// Base sequence
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



// Sequencer
class adder_sequencer extends uvm_sequencer#(adder_transaction);
  `uvm_component_utils(adder_sequencer)  
  
  function new(string name="",uvm_component parent);  
    super.new(name,parent);
  endfunction
endclass

// Monitor
class adder_monitor extends uvm_monitor;
    `uvm_component_utils(adder_monitor)

    adder_transaction txn;
    virtual intf vif;
    uvm_analysis_port#(adder_transaction) ap_mon;   // analysis port monitor

    function new(string name="",uvm_component parent);  
        super.new(name,parent);
        ap_mon = new("ap_mon", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif)))
        begin
            `uvm_fatal("monitor","unable to get interface")
        end
        txn=adder_transaction::type_id::create("txn",this);
    endfunction 

    task run_phase(uvm_phase phase);
        forever
        begin
            @(negedge vif.clk);
            
            // Use the existing transaction object
            txn.a = vif.a;
            txn.b = vif.b;
            txn.cin = vif.cin;
            txn.cout = vif.cout;
            txn.out = vif.out;
            txn.propagate = vif.propagate;
            txn.generate_ = vif.generate_;
            txn.clkp_out = vif.clkp_out;  // Capture clock signals
            txn.clkn_out = vif.clkn_out;
            
            // Calculate expected values for checking in scoreboard
            txn.calculatePG();
            
            // Send to scoreboard
            ap_mon.write(txn);
        end
    endtask
endclass

// Driver - use non-parameterized version for better compatibility
class adder_driver extends uvm_driver #(adder_transaction);
    `uvm_component_utils(adder_driver)
    
    uvm_analysis_port #(adder_transaction) drv2sb;

    function new(string name="",uvm_component parent);
        super.new(name,parent);
        drv2sb=new("drv2sb",this);
    endfunction

    virtual intf vif;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!(uvm_config_db#(virtual intf)::get(this,"*","vif",vif))) begin
            `uvm_fatal(get_type_name(),"unable to get interface");
        end
    endfunction

    task run_phase(uvm_phase phase);
        adder_transaction txn;
        forever begin
            seq_item_port.get_next_item(txn);

            // Wait for calculation_done to be asserted
            @(posedge vif.calculation_done);
            
            // Set input values
            vif.a <= txn.a;
            vif.b <= txn.b;
            vif.cin <= txn.cin;
            
            // Wait for at least one valid output state before proceeding
            // Either when clkn_out is all 0s or clkp_out is all 1s
            wait((vif.clkn_out == 8'h00) || (vif.clkp_out == 8'hFF));
            
            drv2sb.write(txn);
            seq_item_port.item_done();    
        end
    endtask
endclass

// Agent
class adder_agent extends uvm_agent;
    `uvm_component_utils(adder_agent)
    adder_sequencer sequencer;
    adder_driver driver;  // Non-parameterized version
    adder_monitor monitor;
    
    // Constructor
    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Instantiate components with proper type specification
        sequencer = adder_sequencer::type_id::create("sequencer", this);
        driver = adder_driver::type_id::create("driver", this);
        monitor = adder_monitor::type_id::create("monitor", this);
    endfunction

    // Connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        // Connect sequencer to driver
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass

// Analysis port definitions for scoreboard
`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

// Scoreboard
class adder_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(adder_scoreboard)
    
    uvm_analysis_imp_drv#(adder_transaction, adder_scoreboard) ap_driver;
    uvm_analysis_imp_mon#(adder_transaction, adder_scoreboard) ap_monitor;

    uvm_tlm_fifo #(adder_transaction) expfifo;  // Expected Output FIFO
    uvm_tlm_fifo #(adder_transaction) outfifo;  // Actual Output FIFO

    int vec, pass, error;   // Counter for number of vectors, passes, and errors

    reg [15:0]t_out;
    reg [15:0]t_a, t_b, t_cin;
    
    virtual intf vif;  // Virtual interface for clock access

    function new(string name="adder_scoreboard",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_driver = new("ap_driver", this);
        ap_monitor = new("ap_monitor", this);
        expfifo= new("expfifo",this);
        outfifo= new("outfifo",this);
        
        // Get interface handle
        if(!uvm_config_db#(virtual intf)::get(this, "*", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Failed to get virtual interface")
        end
    endfunction

    // Expected Values
    function void write_drv(adder_transaction tr);
        `uvm_info("write_drv STIM", tr.convert2string(), UVM_MEDIUM)
        // Process transaction
        t_a = tr.a;
        t_b = tr.b;
        t_cin = tr.cin;
        t_out = t_a + t_b + t_cin;
        // Calculate expected propagate and generate values
        tr.expected_propagate = t_a ^ t_b;
        tr.expected_generate = t_a & t_b;
        tr.out = t_out;
        void'(expfifo.try_put(tr));
    endfunction

    // Write outputs of monitor
    function void write_mon(adder_transaction tr);
        `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
        void'(outfifo.try_put(tr));
    endfunction

    task run_phase(uvm_phase phase);
        adder_transaction exp_tr, out_tr;

        forever begin
            `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
            expfifo.get(exp_tr);
            `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
            outfifo.get(out_tr);
            
            // Check if outputs are valid (when clkn_out is all 0s or clkp_out is all 1s)
            // We skip validation when the outputs are not valid
            if ((out_tr.clkn_out == 8'h00) || (out_tr.clkp_out == 8'hFF)) begin
                // Check output, propagate, and generate signals when valid
                @(posedge vif.clk); // before, the scoreboard would check the output when it transitions from invalid to a valid state
                // this led to false alarms!
                // added a 1 clock delay so that the scoreboard polls a valid output
                if ((out_tr.out == exp_tr.out) && 
                    (out_tr.propagate == exp_tr.expected_propagate) &&
                    (out_tr.generate_ == exp_tr.expected_generate))  begin
                    
                    PASS();
                    `uvm_info ("PASS ", $sformatf(
                        "Transaction PASSED:\n  Inputs: a=%h, b=%h, cin=%b\n  Outputs: out=%h, cout=%b\n  Propagate: actual=%h, expected=%h\n  Generate: actual=%h, expected=%h\n  Clock state: clkp_out=%h, clkn_out=%h", 
                        out_tr.a, out_tr.b, out_tr.cin,
                        out_tr.out, out_tr.cout,
                        out_tr.propagate, exp_tr.expected_propagate,
                        out_tr.generate_, exp_tr.expected_generate,
                        out_tr.clkp_out, out_tr.clkn_out), UVM_MEDIUM)
                end
                else begin
                    ERROR();
                    if (out_tr.out != exp_tr.out) begin
                        `uvm_error("OUTPUT_MISMATCH", $sformatf("Actual out: %h, Expected out: %h", 
                                                              out_tr.out, exp_tr.out))
                    end
                    if (out_tr.propagate != exp_tr.expected_propagate) begin
                        `uvm_error("PROPAGATE_MISMATCH", $sformatf("Actual propagate: %h, Expected propagate: %h", 
                                                                 out_tr.propagate, exp_tr.expected_propagate))
                    end
                    if (out_tr.generate_ != exp_tr.expected_generate) begin
                        `uvm_error("GENERATE_MISMATCH", $sformatf("Actual generate: %h, Expected generate: %h", 
                                                                out_tr.generate_, exp_tr.expected_generate))
                    end
                    `uvm_info("ERROR", $sformatf("Transaction with errors: a=%h, b=%h, cin=%b", 
                                               out_tr.a, out_tr.b, out_tr.cin), UVM_LOW)
                end
            end
            else begin
                // Skip validation when outputs are not valid
                `uvm_info("SKIPPED", $sformatf("Skipping validation: clkn_out=%h, clkp_out=%h - outputs not valid", 
                                              out_tr.clkn_out, out_tr.clkp_out), UVM_MEDIUM)
            end
        end
    endtask

    function void PASS();
        vec++;
        pass++;
    endfunction

    function void ERROR();
        vec++;
        error++;
    endfunction
endclass

// Coverage
class adder_coverage extends uvm_subscriber #(adder_transaction);
  `uvm_component_utils(adder_coverage)

  // Declare the covergroup instance first
  adder_transaction txn;
  real cov;
  covergroup dut_cov;
    option.per_instance=1;
    
    // Input value coverpoints
    A: coverpoint txn.a { 
      bins zero = {16'h0000};
      bins all_ones = {16'hFFFF};
      bins upper_byte_ones = {16'hFF00};
      bins lower_byte_ones = {16'h00FF};
      bins pattern_A = {16'hAAAA};
      bins pattern_5 = {16'h5555};
      bins other = default;  // Catch all other values
    }
    
    B: coverpoint txn.b { 
      bins zero = {16'h0000};
      bins all_ones = {16'hFFFF};
      bins upper_byte_ones = {16'hFF00};
      bins lower_byte_ones = {16'h00FF};
      bins pattern_A = {16'hAAAA};
      bins pattern_5 = {16'h5555};
      bins other = default;  // Catch all other values
    }
    
    // Propagate signal coverpoints 
    PROPAGATE: coverpoint txn.propagate {
      // Look for all-zeros, all-ones, and mixed patterns
      bins all_zeros = {16'h0000};
      bins all_ones = {16'hFFFF};
      bins mixed = {[16'h0001:16'hFFFE]};
      
      // Cross propagate with inputs
      bins random_cases[] = {16'h5555, 16'hAAAA, 16'h3333, 16'hCCCC};
    }
    
    // Generate signal coverpoints
    GENERATEz: coverpoint txn.generate_ {
      // Look for all-zeros, all-ones, and mixed patterns
      bins all_zeros = {16'h0000};
      bins all_ones = {16'hFFFF};
      bins mixed = {[16'h0001:16'hFFFE]};
      
      // random generate patterns
      bins random_cases[] = {16'h5555, 16'hAAAA, 16'h3333, 16'hCCCC};
    }
    
    // Cross coverage between propagate and generate
    PROP_GEN_CROSS: cross PROPAGATE, GENERATEz {
      // Key patterns where propagate and generate values are inversely related
      bins p1_g0 = binsof(PROPAGATE.all_ones) && binsof(GENERATEz.all_zeros);
      bins p0_g1 = binsof(PROPAGATE.all_zeros) && binsof(GENERATEz.all_ones);
      
      // Other random relationships
      bins alternating = binsof(PROPAGATE.random_cases) && binsof(GENERATEz.random_cases);
    }
    
    // Propagate pattern coverage
    PROP_PATTERN: coverpoint txn.propagate[3:0] {
      bins patterns[] = {[0:15]};  // Cover all 4-bit propagate patterns
    }
    
    // Carry ripple coverage
    CIN: coverpoint txn.cin {
      bins zero = {0};
      bins one = {1};
    }
    
    // Ripple carry conditions - when inputs would cause ripple carry
    RIPPLECONDITION: coverpoint {txn.a[0], txn.b[0], txn.cin} {
      bins ripple_start = {3'b111, 3'b110, 3'b101, 3'b011}; // Inputs that generate carry
    }
    
    // random ripple patterns
    RIPPLE_PATTERNS: coverpoint txn.a {
      bins all_ones = {16'hFFFF};
      bins lower_half = {16'h00FF};
      bins upper_half = {16'hFF00};
      bins alternate_ones = {16'h5555, 16'hAAAA};
      bins single_bits[] = {16'h0001, 16'h0002, 16'h0004, 16'h0008, 
                           16'h0010, 16'h0020, 16'h0040, 16'h0080,
                           16'h0100, 16'h0200, 16'h0400, 16'h0800,
                           16'h1000, 16'h2000, 16'h4000, 16'h8000};
    }
    
    // Cross coverage for ripple scenarios
    RIPPLE_CROSS: cross RIPPLE_PATTERNS, CIN;
  endgroup: dut_cov

  function new(string name="",uvm_component parent);
    super.new(name,parent);
    
    dut_cov=new();
    `uvm_info(get_type_name(), "Coverage model created", UVM_LOW)
    dut_cov.set_inst_name($sformatf("%s.dut_cov", get_full_name()));
    dut_cov.stop();   // First stop it (in case it's in an error state)
    dut_cov.start();  // Then restart it to ensure it's enabled
  endfunction

  function void write(adder_transaction t);
    
    txn = t;
    //`uvm_info(get_type_name(), $sformatf("Received transaction: a=%h, b=%h", txn.a, txn.b), UVM_LOW)
    dut_cov.sample();
  endfunction
  
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov = dut_cov.get_coverage();
  endfunction
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
endclass

// Environment
class adder_env extends uvm_env;
    `uvm_component_utils(adder_env) // register

    adder_agent agent;
    adder_coverage coverage;
    adder_scoreboard scoreboard;

    function new(string name = "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Instantiate sub-components
        agent = adder_agent::type_id::create("agent", this);
        scoreboard = adder_scoreboard::type_id::create("scoreboard", this);
        coverage = adder_coverage::type_id::create("coverage", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agent.monitor.ap_mon.connect(coverage.analysis_export);
        agent.monitor.ap_mon.connect(scoreboard.ap_monitor);
        agent.driver.drv2sb.connect(scoreboard.ap_driver);
    endfunction
endclass

// Test class
class adder_test extends uvm_test;
    `uvm_component_utils(adder_test)
    
    function new(string name="",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    adder_env env;
    int file;

    // Base sequence
    adder_sequence seq;
    
    // Sequences with specific constraints
    adder_add_zero_a seq1_1;
    adder_add_zero_a seq1_2;
    adder_add_zero_b seq2_1;
    adder_add_zero_b seq2_2;
    adder_cin_1 seq3_1;
    adder_cin_1 seq3_2;
    adder_boundary seq4_1;
    adder_all_bits seq5_1;
    
    // Add specific sequences for propagate, generate, and ripple carry verification
    adder_propagate_test seq_prop;
    adder_generate_test seq_gen;
    adder_ripple_carry_test seq_ripple;

    adder_bit_positions seq_bit_pos;
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = adder_env::type_id::create("env",this);

      seq = adder_sequence::type_id::create("seq");
      seq1_1 = adder_add_zero_a::type_id::create("seq1_1");
      seq1_2 = adder_add_zero_a::type_id::create("seq1_2");
      seq2_1 = adder_add_zero_b::type_id::create("seq2_1");
      seq2_2 = adder_add_zero_b::type_id::create("seq2_2");
      seq3_1 = adder_cin_1::type_id::create("seq3_1");
      seq3_2 = adder_cin_1::type_id::create("seq3_2");
      seq4_1 = adder_boundary::type_id::create("seq4_1");
      seq5_1 = adder_all_bits::type_id::create("seq5_1");
      seq_prop = adder_propagate_test::type_id::create("seq_prop");
      seq_gen = adder_generate_test::type_id::create("seq_gen");
      seq_ripple = adder_ripple_carry_test::type_id::create("seq_ripple");
      seq_bit_pos = adder_bit_positions::type_id::create("seq_bit_pos");
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      //factory.print();
      $display("End of elaboration phase in agent");
    endfunction
    
    function void start_of_simulation_phase(uvm_phase phase);
      super.start_of_simulation_phase(phase);
      $display("start_of_simulation_phase");
      file=$fopen("LOG_FILE.log","w");
      set_report_default_file(file);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env.set_report_verbosity_level_hier(UVM_MEDIUM);
      seq.loop_count=3; // Further reduced to minimize test vectors
    endfunction
    
    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        // Run base random sequence
        seq.start(env.agent.sequencer);
        
        // Run constrained sequences (selected key test cases only)
        seq1_1.start(env.agent.sequencer); // a=0
        seq3_1.start(env.agent.sequencer); // cin=1
        seq4_1.start(env.agent.sequencer); // Boundary values
        seq5_1.start(env.agent.sequencer); // All bits
        
        // Run propagate pattern specific tests (these are already minimal)
        seq_prop.start(env.agent.sequencer); // Special propagate patterns
        
        // Run selected essential test patterns
        seq_gen.start(env.agent.sequencer); // Special generate patterns
        seq_ripple.start(env.agent.sequencer); // Ripple carry patterns

        seq_bit_pos.start(env.agent.sequencer); // Bit positions 0-15 test.
        
        #10;
        phase.drop_objection(this);
    endtask
endclass

// Top module
module top;
  import uvm_pkg::*;  // Repeat import for safety
  
  bit clk = 0; // initialize
  bit reset = 0;
  
  // Interface instance
  intf i_intf(clk, reset);
  
  // DUT instance
  adder_b DUT(
    .a(i_intf.a),
    .b(i_intf.b),
    .cin(i_intf.cin),
    .clk(i_intf.clk),
    .reset(i_intf.reset),
    .out(i_intf.out),
    .cout(i_intf.cout),
    .calculation_done(i_intf.calculation_done),
    .clkp_out(i_intf.clkp_out),
    .clkn_out(i_intf.clkn_out),
    .propagate(i_intf.propagate),
    .generate_(i_intf.generate_)
  );
         
  // Clock generation
  always #5 clk =~ clk;

  initial begin
    // Clock is already initialized
  end
  
  // Waveform dump
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  
  // Register interface with UVM - set it for the full hierarchy
  initial begin
    uvm_config_db#(virtual intf)::set(null,"*","vif",i_intf);
  end
  
  // Start the test
  initial begin
    run_test("adder_test");
  end
endmodule