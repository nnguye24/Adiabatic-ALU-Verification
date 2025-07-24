// Library - MIPS25, Cell - black_cell_inv2b, View - schematic
// LAST TIME SAVED: Jun 16 20:11:41 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module black_cell_inv2b ( Cout, Pout, G, Gprev, P, Pprev, clkneg,
     clkpos, vdd, vss );

output  Cout, Pout;

input  G, Gprev, P, Pprev, clkneg, clkpos, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "black_cell_inv2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(Cout), .g(G), .s(net018));
ctranif1  MN0 ( .b(vss), .d(net018), .g(Gprev), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(net018), .g(P), .s(clkneg));
ctranif1  MN5 ( .b(vss), .d(Pout), .g(Pprev), .s(clkneg));
ctranif1  MN6 ( .b(vss), .d(Pout), .g(P), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(Gprev), .d(Cout));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(P), .d(net016));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(G), .d(Cout));
ctranif0  MP5 ( .b(vdd), .s(clkpos), .g(Pprev), .d(net036));
ctranif0  MP6 ( .b(vdd), .s(net036), .g(P), .d(Pout));

endmodule
