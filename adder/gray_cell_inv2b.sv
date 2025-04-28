// Library - MIPS25, Cell - gray_cell_inv2b, View - schematic
// LAST TIME SAVED: Mar 31 16:36:32 2025
// NETLIST TIME: Apr 27 19:08:19 2025
`timescale 1ns / 1ns 

module gray_cell_inv2b ( Cout, G, Gprev, P, clkneg, clkpos, vdd, vss );

input  G, Gprev, P, clkneg, clkpos, vdd, vss;
output Cout;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "gray_cell_inv2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(Cout), .g(G), .s(net018));
ctranif1  MN0 ( .b(vss), .d(net018), .g(Gprev), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(net018), .g(P), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(Gprev), .d(Cout));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(P), .d(net016));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(G), .d(Cout));

endmodule
