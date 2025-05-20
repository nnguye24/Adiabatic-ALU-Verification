// Library - MIPS25, Cell - mux4to1_16b, View - schematic
// LAST TIME SAVED: May 15 22:08:18 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module mux4to1_16b ( a, b, c, clkneg, clkneg1, clkpos, clkpos1, d, in0,
     in1, out, vdd, vss );

input clkneg, clkneg1, clkpos, clkpos1, in0, in1, vdd, vss;

input [15:0]  a;
input [15:0]  b;
output [15:0]  out;
input [15:0]  c;
input [15:0]  d;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux4to1_16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux4to1 I17[15:0] ( a[15:0], b[15:0], c[15:0], clkneg, clkneg1, clkpos,
     clkpos1, d[15:0], in0, in1, out[15:0], vdd, vss);

endmodule
