// Library - MIPS25, Cell - inv_fo16, View - schematic
// LAST TIME SAVED: Mar 27 12:52:11 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module inv_fo16 ( clkneg, clkpos, in, out, vdd, vss );

inout  clkneg, clkpos, in , vdd, vss;
output out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "inv_fo16";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN15 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN14 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN13 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN12 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN11 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN10 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN9 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN8 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN7 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN6 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN5 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN0 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN2 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN3 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif1  MN1 ( .b(vss), .d(out), .g(in), .s(clkneg));
ctranif0  MP15 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP14 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP13 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP12 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP11 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP10 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP9 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP8 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP7 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP6 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP5 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP3 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP2 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(in), .d(out));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in), .d(out));

endmodule
