// Library - MIPS25, Cell - gray_cell2b, View - schematic
// LAST TIME SAVED: Jun 16 20:19:01 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module gray_cell2b ( Cout, G, Gprev, P, clkneg, clkpos, vdd, vss );

output  Cout;

input  G, Gprev, P, clkneg, clkpos, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "gray_cell2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(Cout), .g(Gprev), .s(net018));
ctranif1  MN0 ( .b(vss), .d(Cout), .g(G), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(net018), .g(P), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(G), .d(Cout));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(P), .d(net016));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(Gprev), .d(net016));

endmodule
