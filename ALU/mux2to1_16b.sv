// Library - MIPS25, Cell - mux2to1_16b, View - schematic
// LAST TIME SAVED: Apr 27 19:30:06 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 
`include "mux2to1.sv"
module mux2to1_16b ( a, b, clkneg, clkpos, in, out, vdd, vss );

input  clkneg, clkpos, in, vdd, vss;

input [15:0]  b;
output [15:0]  out;
input [15:0]  a;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux2to1_16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux2to1 I0[15:0] ( a[15:0], b[15:0], clkneg, clkpos, in, out[15:0],
     vdd, vss);

endmodule
