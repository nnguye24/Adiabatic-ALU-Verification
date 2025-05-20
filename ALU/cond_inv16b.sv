// Library - MIPS25, Cell - cond_inv16b, View - schematic
// LAST TIME SAVED: Apr 23 13:56:58 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module cond_inv16b ( a, b, clkneg, clkpos, out, vdd, vss );

input  clkneg, clkpos, vdd, vss;

input [15:0]  a;
input [15:0]  b;
output [15:0]  out;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "cond_inv16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

cond_inv2b I16[15:0] ( a[15:0], b[15:0], clkneg, clkpos, out[15:0],
     vdd, vss);

endmodule
