// Library - MIPS25, Cell - xor16b, View - schematic
// LAST TIME SAVED: Jun 16 21:26:56 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module xor16b ( Cout, A, B, clkneg1, clkneg2, clkpos1, clkpos2, vdd,
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

xor2b I0[15:0] ( Cout[15:0], A[15:0], B[15:0], clkneg1, clkneg2,
     clkpos1, clkpos2, vdd, vss);

endmodule
