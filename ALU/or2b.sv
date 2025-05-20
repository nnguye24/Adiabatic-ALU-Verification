// Library - MIPS25, Cell - or2b, View - schematic
// LAST TIME SAVED: Mar 29 18:05:52 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module or2b ( a, b, clkneg, clkneg2, clkpos, clkpos2, out, vdd, vss );

input  a, b, clkneg, clkneg2, clkpos, clkpos2, vdd, vss;
output out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "or2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(net017), .g(b), .s(clkneg));
ctranif1  MN0 ( .b(vss), .d(net017), .g(a), .s(clkneg));
ctranif1  MN1 ( .b(vss), .d(out), .g(net017), .s(clkneg2));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(b), .d(net017));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(a), .d(net016));
ctranif0  MP1 ( .b(vdd), .s(clkpos2), .g(net017), .d(out));

endmodule
