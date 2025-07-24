// Library - MIPS25, Cell - mux4to1_16b, View - schematic
// LAST TIME SAVED: Jun 16 21:01:39 2025
// NETLIST TIME: Jul 10 17:04:17 2025
`timescale 1ns / 1ns 
`include "mux4to1.sv"
module mux4to1_16b ( out, a, b, c, clkneg, clkneg1, clkpos, clkpos1, d,
     in0, in1, vdd, vss );


input  clkneg, clkneg1, clkpos, clkpos1, in0, in1, vdd, vss;

output [15:0]  out;

input [15:0]  a;
input [15:0]  b;
input [15:0]  c;
input [15:0]  d;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux4to1_16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux4to1 I17[15:0] ( out[15:0], a[15:0], b[15:0], c[15:0], clkneg,
     clkneg1, clkpos, clkpos1, d[15:0], in0, in1, vdd, vss);

endmodule
