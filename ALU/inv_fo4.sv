// Library - MIPS25, Cell - inv_fo4, View - schematic
// LAST TIME SAVED: Jun 16 20:25:19 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module inv_fo4 ( out, clkneg, clkpos, in, vdd, vss );

output  out;

input  clkneg, clkpos, in, vdd, vss;


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
