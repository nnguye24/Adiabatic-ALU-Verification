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
    `uvm_info(get_type_name(), $sformatf("Received transaction: a=%h, b=%h", txn.a, txn.b), UVM_LOW)
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