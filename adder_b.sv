module adder_b (
    input wire [15:0] a,      // Changed to 16-bit input
    input wire [15:0] b,      // Changed to 16-bit input
    input wire cin,
    input wire clk,      
    input wire reset,          
    output wire [15:0] out,   // Changed to 16-bit output
    output wire cout,
    output wire calculation_done  // Added to indicate when result is valid
);
    // Power supplies
    supply1 vdd;              // Added supply definitions
    supply0 vss;

    // Bennett clock signals
    wire instFlag;
    wire [7:0] clkneg;
    wire [7:0] clkpos;

    // Bennett clock generator
    bennett_clock #(
        .WIDTH(8)  
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .clkn(clkneg),
        .clkp(clkpos)
    );

    // Adder instance
    adder adder_inst ( 
        a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8],
        a[9], a[10], a[11], a[12], a[13], a[14], a[15], 
        b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], 
        b[9], b[10], b[11], b[12], b[13], b[14], b[15], 
        cin, clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], 
        clkneg[5], clkneg[6], clkneg[7], clkpos[0], clkpos[1], 
        clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6],
        clkpos[7], cout, out[0], out[1], out[2], out[3], out[4], 
        out[5], out[6], out[7], out[8], out[9], out[10], out[11], 
        out[12], out[13], out[14], out[15], vdd, vss
    );
    
    // Signal to indicate when calculation is complete
    assign calculation_done = instFlag;
    
endmodule