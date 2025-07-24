// Library - MIPS25, Cell - inv, View - schematic
// LAST TIME SAVED: Jun 16 20:23:25 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module inv ( out, clkneg, clkpos, in, vdd, vss );

output  out;

input  clkneg, clkpos, in, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "inv";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN1 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(out));

endmodule
