
`include "adder_interface.sv"
`include "adder_pkg.sv"
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