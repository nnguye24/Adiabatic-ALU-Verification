`include "bennettClock.sv"
`include "ALU.sv"
module alu_wrapper (
    // Data inputs
    input wire [15:0] a,
    input wire [15:0] b,
    input wire [15:0] PC_in,
    input wire [15:0] instr_in,
    
    // Control signals
    input wire ALU_Control0, ALU_Control1,
    input wire A_mux, Adder_Cin, B_mux0, B_mux1,
    input wire STL, SUB, mux3_0, mux3_1,
    
    // Clock and reset
    input wire clk,
    input wire reset,
    
    // Outputs
    output wire [15:0] out,
    output wire [15:0] alu_out,
    output wire [15:0] SRAM_in,
    output wire out_Zero_Detect,
    output wire instFlag
);

    // Power supplies
    supply1 vdd;
    supply0 vss;
    
    // Bennett clock signals
    wire Mclk;
    wire [11:0] clkneg;
    wire [11:0] clkpos;
    wire Mclkn;
    wire Tclkpos;
    
    // Bennett clock generator
    bennett_clock #(
        .WIDTH(12)
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .Mclk(Mclk),
        .clkn(clkneg),
        .clkp(clkpos)
    );
    
    // Clock assignments
    assign Mclkn = ~Mclk;
    assign Tclkpos = (clkpos[11] === 1'bX) ? 1'b0 : clkpos[11];
    
    // ALU instance
    ALU dut (
        .ALU_Control0(ALU_Control0),
        .ALU_Control1(ALU_Control1),
        .ALU_O_Fclkpos(instFlag),        // Connect instFlag to Fclk
        .A_Fclkpos(instFlag),            // Connect instFlag to Fclk
        .A_mux(A_mux),
        .Adder_Cin(Adder_Cin),
        .B_mux0(B_mux0),
        .B_mux1(B_mux1),
        .PC_in(PC_in),
        .SRAM_in(SRAM_in),
        .STL(STL),
        .SUB(SUB),
        .a(a),
        .alu_out(alu_out),
        .b(b),
        .clkneg({Mclkn, clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkneg[8], clkneg[9], clkneg[10], vss, vss, Mclkn, vss, vss}),
        .clkpos({Mclk, clkpos[0], clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9], clkpos[10], vdd, vdd, Mclk, vdd, vdd}),
        .instr_in(instr_in),
        .mux3_0(mux3_0),
        .mux3_1(mux3_1),
        .out(out),
        .out_Zero_Detect(out_Zero_Detect),
        .vdd(vdd),
        .vss(vss),
        .Tclkpos(Tclkpos)
    );

endmodule