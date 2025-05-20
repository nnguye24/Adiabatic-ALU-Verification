// Library - MIPS25, Cell - or16b, View - schematic
// LAST TIME SAVED: Apr 26 10:32:31 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module or16b ( a, b, clkneg, clkneg2, clkpos, clkpos2, out, vdd, vss );

input  clkneg, clkneg2, clkpos, clkpos2, vdd, vss;

input [15:0]  b;
output [15:0]  out;
input [15:0]  a;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "or16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

or2b I0[15:0] ( a[15:0], b[15:0], clkneg, clkneg2, clkpos, clkpos2,
     out[15:0], vdd, vss);

endmodule
