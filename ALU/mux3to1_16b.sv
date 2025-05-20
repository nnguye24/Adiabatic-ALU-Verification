// Library - MIPS25, Cell - mux3to1_16b, View - schematic
// LAST TIME SAVED: May 19 11:08:44 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module mux3to1_16b ( b, c, clkneg, clkneg1, clkpos, clkpos1, d, in0,
     in1, out, vdd, vss );

input  clkneg, clkneg1, clkpos, clkpos1, in0, in1, vdd, vss;

output [15:0]  out;
input [15:0]  d;
input [15:0]  b;
input [15:0]  c;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux3to1_16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux4to1 I17[15:0] ( vss, b[15:0], c[15:0], clkneg, clkneg1, clkpos,
     clkpos1, d[15:0], in0, in1, out[15:0], vdd, vss);

endmodule
