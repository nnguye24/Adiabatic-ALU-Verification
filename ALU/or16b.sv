// Library - MIPS25, Cell - or16b, View - schematic
// LAST TIME SAVED: Jun 16 21:19:57 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 
`include "or2b.sv"

module or16b ( out, a, b, clkneg, clkneg2, clkpos, clkpos2, vdd, vss );


input  clkneg, clkneg2, clkpos, clkpos2, vdd, vss;

output [15:0]  out;

input [15:0]  b;
input [15:0]  a;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "or16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

or2b I0[15:0] ( out[15:0], a[15:0], b[15:0], clkneg, clkneg2, clkpos,
     clkpos2, vdd, vss);

endmodule
