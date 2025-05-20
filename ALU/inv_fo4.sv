// Library - MIPS25, Cell - inv_fo4, View - schematic
// LAST TIME SAVED: Mar 27 12:31:35 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 

module inv_fo4 ( clkneg, clkpos, in, out, vdd, vss );

input  clkneg, clkpos, in, vdd, vss;
output out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "inv_fo4";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN3 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN0 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN2 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN1 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif0  MP3 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP2 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(out));

endmodule
