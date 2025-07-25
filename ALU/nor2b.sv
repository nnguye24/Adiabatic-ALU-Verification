// Library - MIPS25, Cell - nor2b, View - schematic
// LAST TIME SAVED: Jun 16 21:10:40 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module nor2b ( out, a, b, clkneg, clkpos, vdd, vss );

output  out;

input  a, b, clkneg, clkpos, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "nor2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(out), .g(b), .s(clkneg));
ctranif1  MN0 ( .b(vss), .d(out), .g(a), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(b), .d(out));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(a), .d(net016));

endmodule
