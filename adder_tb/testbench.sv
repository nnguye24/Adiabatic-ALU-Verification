
`include "adder_interface.sv"
`include "adder_pkg.sv"
module top;
  import uvm_pkg::*;
  import adder_pkg::*;
  
  bit clk; // external signal declaration

  
  bit reset;
  intf i_intf(clk, reset);
  

  
  adder_b DUT(.a(i_intf.a),
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
                 
  
  always #5 clk =~ clk;

  initial begin
    clk <= 0;
  end
  
  
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  
  initial begin
    run_test("adder_test");
  end
  
endmodule
