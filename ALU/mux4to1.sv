// Library - MIPS25, Cell - mux4to1, View - schematic
// LAST TIME SAVED: Jun 16 20:56:11 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module mux4to1 ( out, a, b, c, clkneg, clkneg1, clkpos, clkpos1, d,
     in0, in1, vdd, vss );

output  out;

input  a, b, c, clkneg, clkneg1, clkpos, clkpos1, d, in0, in1, vdd,
     vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "mux4to1";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN8 ( .b(vss), .d(net0105), .g(in1), .s(clkneg1));
ctranif1  MN7 ( .b(vss), .d(net072), .g(in1), .s(out));
ctranif1  MN6 ( .b(vss), .d(net079), .g(net0105), .s(out));
ctranif1  MN5 ( .b(vss), .d(d), .g(net097), .s(net079));
ctranif1  MN4 ( .b(vss), .d(c), .g(in0), .s(net079));
ctranif1  MN3 ( .b(vss), .d(net097), .g(in0), .s(clkneg));
ctranif1  MN2 ( .b(vss), .d(b), .g(net098), .s(net072));
ctranif1  MN0 ( .b(vss), .d(a), .g(in0), .s(net072));
ctranif1  MN1 ( .b(vss), .d(net098), .g(in0), .s(clkneg));
ctranif0  MP8 ( .b(vdd), .s(out), .g(in1), .d(net079));
ctranif0  MP7 ( .b(vdd), .s(clkpos1), .g(in1), .d(net0105));
ctranif0  MP6 ( .b(vdd), .s(out), .g(net0105), .d(net072));
ctranif0  MP5 ( .b(vdd), .s(net079), .g(net097), .d(c));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(in0), .d(net097));
ctranif0  MP3 ( .b(vdd), .s(net079), .g(in0), .d(d));
ctranif0  MP2 ( .b(vdd), .s(net072), .g(in0), .d(b));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(in0), .d(net098));
ctranif0  MP0 ( .b(vdd), .s(net072), .g(net098), .d(a));

endmodule
