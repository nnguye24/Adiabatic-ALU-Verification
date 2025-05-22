// Library - MIPS25, Cell - xor16b, View - schematic
// LAST TIME SAVED: Apr 26 10:23:48 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 
`include "xor2b.sv"
module xor16b ( A, B, Cout, clkneg1, clkneg2, clkpos1, clkpos2, vdd,
     vss );

input  clkneg1, clkneg2, clkpos1, clkpos2, vdd, vss;

output [15:0]  Cout;
input [15:0]  A;
input [15:0]  B;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "xor16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

xor2b I0[15:0] ( A[15:0], B[15:0], Cout[15:0], clkneg1, clkneg2,
     clkpos1, clkpos2, vdd, vss);

endmodule
