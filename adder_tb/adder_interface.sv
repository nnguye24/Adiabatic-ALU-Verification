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