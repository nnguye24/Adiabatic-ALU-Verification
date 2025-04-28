// Library - MIPS25, Cell - inv, View - schematic
// LAST TIME SAVED: Mar 26 22:12:26 2025
// NETLIST TIME: Apr 27 19:08:19 2025
`timescale 1ns / 1ns 

module inv ( clkneg, clkpos, in, out, vdd, vss );

inout  clkneg, clkpos, in, out, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "inv";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN1 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(out));

endmodule
