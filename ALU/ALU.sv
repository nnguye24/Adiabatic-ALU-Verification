// Library - MIPS25, Cell - ALU, View - schematic
// LAST TIME SAVED: May 19 11:21:05 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module ALU ( ALU_Control0, ALU_Control1, ALU_OUT_Fclkneg,
     ALU_O_Fclkpos, A_Fclkneg_out, A_Fclkpos, A_mux, Adder_Cin, B_mux0,
     B_mux1, PC_in, SRAM_in, STL, SUB, a, alu_out, b, clkneg, clkpos,
     instr_in, mux3_0, mux3_1, out, out_Zero_Detect, vdd, vss );

input  ALU_Control0, ALU_Control1, ALU_OUT_Fclkneg, ALU_O_Fclkpos,
     A_Fclkneg_out, A_Fclkpos, A_mux, Adder_Cin, B_mux0, B_mux1, STL,
     SUB, mux3_0, mux3_1, out_Zero_Detect, vdd, vss;

input [15:0]  b;
output [15:0]  out;
input [15:0]  PC_in;
input [15:0]  SRAM_in;
input [15:0]  instr_in;
input [15:0]  a;
input [0:16]  clkpos;
output [15:0]  alu_out;
input [0:16]  clkneg;

// Buses in the design

wire  [15:0]  or_out;

wire  [15:0]  and_out;

wire  [15:0]  a_muxout;

wire  [15:0]  b_regout;

wire  [15:0]  alu_muxout;

wire  [15:0]  b_muxout;

wire  [15:0]  adder_out;

wire  [15:0]  b_invout;

wire  [15:0]  a_invout;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "ALU";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux3to1_16b I13 ( {vss, instr_in[15:1]}, alu_out[15:0], clkneg[15],
     clkneg[16], clkpos[15], clkpos[16], alu_muxout[15:0], mux3_0,
     mux3_1, out[15:0], vdd, vss);
cond_inv16b I7 ( b_muxout[15:0], {STL, STL, STL, STL, STL, STL, STL,
     STL, STL, STL, STL, STL, STL, STL, STL, STL}, clkneg[3],
     clkpos[3], b_invout[15:0], vdd, vss);
cond_inv16b I6 ( a_muxout[15:0], {SUB, SUB, SUB, SUB, SUB, SUB, SUB,
     SUB, SUB, SUB, SUB, SUB, SUB, SUB, SUB, SUB}, clkneg[3],
     clkpos[3], a_invout[15:0], vdd, vss);
and16b I9 ( a_muxout[15:0], b_muxout[15:0], clkneg[4], clkneg[5],
     clkpos[4], clkpos[5], and_out[15:0], vdd, vss);
zero_detector I14 ( a_muxout[15:0], b_muxout[15:0], clkneg[4],
     clkneg[5], clkneg[6], clkneg[7], clkneg[8], clkneg[9], clkneg[10],
     clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9],
     clkpos[10], out_Zero_Detect, vdd, vss);
or16b I10 ( a_muxout[15:0], b_muxout[15:0], clkneg[4], clkneg[5],
     clkpos[4], clkpos[5], or_out[15:0], vdd, vss);
adder I8 ( a_invout[0], a_invout[1], a_invout[2], a_invout[3],
     a_invout[4], a_invout[5], a_invout[6], a_invout[7], a_invout[8],
     a_invout[9], a_invout[10], a_invout[11], a_invout[12],
     a_invout[13], a_invout[14], a_invout[15], b_invout[0],
     b_invout[1], b_invout[2], b_invout[3], b_invout[4], b_invout[5],
     b_invout[6], b_invout[7], b_invout[8], b_invout[9], b_invout[10],
     b_invout[11], b_invout[12], b_invout[13], b_invout[14],
     b_invout[15], Adder_Cin, clkneg[4], clkneg[5], clkneg[6],
     clkneg[7], clkneg[8], clkneg[9], clkneg[10], clkneg[11],
     clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9],
     clkpos[10], clkpos[11], adder_cout, adder_out[0], adder_out[1],
     adder_out[2], adder_out[3], adder_out[4], adder_out[5],
     adder_out[6], adder_out[7], adder_out[8], adder_out[9],
     adder_out[10], adder_out[11], adder_out[12], adder_out[13],
     adder_out[14], adder_out[15], vdd, vss);
inv_fo16_irr I16 ( A_Fclkpos, A_Fclkneg_out, vdd, vss);
inv_fo16_irr I15 ( ALU_O_Fclkpos, ALU_OUT_Fclkneg, vdd, vss);
Register16b I12 ( ALU_OUT_Fclkneg, ALU_O_Fclkpos, clkneg[14],
     clkpos[14], alu_muxout[15:0], alu_out[15:0], vdd, vss);
Register16b I2 ( A_Fclkneg_out, A_Fclkpos, clkneg[0], clkpos[0],
     a[15:0], SRAM_in[15:0], vdd, vss);
Register16b I3 ( A_Fclkneg_out, A_Fclkpos, clkneg[0], clkpos[0],
     b[15:0], b_regout[15:0], vdd, vss);
mux4to1_16b I11 ( and_out[15:0], or_out[15:0], adder_out[15:0],
     clkneg[12], clkneg[13], clkpos[12], clkpos[13], {adder_cout,
     adder_cout, adder_cout, adder_cout, adder_cout, adder_cout,
     adder_cout, adder_cout, adder_cout, adder_cout, adder_cout,
     adder_cout, adder_cout, adder_cout, adder_cout, adder_cout},
     ALU_Control0, ALU_Control1, alu_muxout[15:0], vdd, vss);
mux4to1_16b I4 ( {vss, instr_in[15:1]}, instr_in[15:0], {vss, vss, vss,
     vss, vss, vss, vss, vss, vss, vss, vss, vss, vss, vss, vdd, vss},
     clkneg[1], clkneg[2], clkpos[1], clkpos[2], SRAM_in[15:0], B_mux0,
     B_mux1, a_muxout[15:0], vdd, vss);
mux2to1_16b I5 ( PC_in[15:0], b_regout[15:0], clkneg[1], clkpos[1],
     A_mux, b_muxout[15:0], vdd, vss);

endmodule
