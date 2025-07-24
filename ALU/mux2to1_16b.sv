// Library - MIPS25, Cell - mux2to1_16b, View - schematic
// LAST TIME SAVED: Jun 16 20:50:12 2025
// NETLIST TIME: Jul 10 17:04:17 2025
`timescale 1ns / 1ns 
`include "mux2to1.sv"

module mux2to1_16b ( out, a, b, clkneg, clkpos, in, vdd, vss );


input  clkneg, clkpos, in, vdd, vss;

output [15:0]  out;

input [15:0]  b;
input [15:0]  a;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux2to1_16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

mux2to1 I0[15:0] ( out[15:0], a[15:0], b[15:0], clkneg, clkpos, in,
     vdd, vss);

endmodule
