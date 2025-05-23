// Library - MIPS25, Cell - cond_inv2b, View - schematic
// LAST TIME SAVED: Apr  8 19:13:19 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module cond_inv2b ( a, b, clkneg, clkpos, out, vdd, vss );

input  a, b, clkneg, clkpos, vdd, vss;
output out;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "cond_inv2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif0  MP1 ( .b(vdd), .s(net30), .g(a), .d(out));
ctranif0  MP2 ( .b(vdd), .s(clkpos), .g(net23), .d(net30));
ctranif0  M6 ( .b(vdd), .s(net31), .g(net18), .d(out));
ctranif0  M4 ( .b(vdd), .s(clkpos), .g(b), .d(net31));
ctranif0  M12 ( .b(vdd), .s(clkpos), .g(b), .d(net23));
ctranif0  M0 ( .b(vdd), .s(clkpos), .g(a), .d(net18));
ctranif1  M10 ( .b(vss), .d(out), .g(net18), .s(net28));
ctranif1  M8 ( .b(vss), .d(net28), .g(net23), .s(clkneg));
ctranif1  M7 ( .b(vss), .d(net29), .g(b), .s(clkneg));
ctranif1  M5 ( .b(vss), .d(out), .g(a), .s(net29));
ctranif1  M3 ( .b(vss), .d(net23), .g(b), .s(clkneg));
ctranif1  M13 ( .b(vss), .d(net18), .g(a), .s(clkneg));

endmodule
