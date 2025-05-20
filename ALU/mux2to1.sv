// Library - MIPS25, Cell - mux2to1, View - schematic
// LAST TIME SAVED: Mar 31 15:15:18 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module mux2to1 ( a, b, clkneg, clkpos, in, out, vdd, vss );

input  a, b, clkneg, clkpos, in, vdd, vss;
output out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux2to1";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(b), .g(net35), .s(out));
ctranif1  MN0 ( .b(vss), .d(a), .g(in), .s(out));
ctranif1  MN1 ( .b(vss), .d(net35), .g(in), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(out), .g(in), .d(b));
ctranif0  MP0 ( .b(vdd), .s(out), .g(net35), .d(a));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(net35));

endmodule
