// Library - MIPS25, Cell - cond_inv16b, View - schematic
// LAST TIME SAVED: Jun 16 20:15:52 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 
`include "cond_inv2b.sv"
module cond_inv16b ( out, a, b, clkneg, clkpos, vdd, vss );


input  clkneg, clkpos, vdd, vss;

output [15:0]  out;

input [15:0]  a;
input [15:0]  b;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "cond_inv16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

cond_inv2b I16[15:0] ( out[15:0], a[15:0], b[15:0], clkneg, clkpos,
     vdd, vss);

endmodule
