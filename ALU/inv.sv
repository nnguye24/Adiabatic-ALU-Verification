// Library - MIPS25, Cell - inv, View - schematic
// LAST TIME SAVED: May 15 15:20:17 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module inv ( clkneg, clkpos, in, out, vdd, vss );

input  clkneg, clkpos, in, vdd, vss;
output out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "inv";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN1 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(out));

endmodule
