// Library - MIPS25, Cell - black_cell2b, View - schematic
// LAST TIME SAVED: Jun 16 20:08:49 2025
// NETLIST TIME: Jul 10 17:04:16 2025
`timescale 1ns / 1ns 

module black_cell2b ( Gout, Pout, G, Gprev, P, Pin, clkneg, clkpos,
     vdd, vss );

output  Gout, Pout;

input  G, Gprev, P, Pin, clkneg, clkpos, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "black_cell2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(Gout), .g(Gprev), .s(net018));
ctranif1  MN0 ( .b(vss), .d(Gout), .g(G), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(net018), .g(P), .s(clkneg));
ctranif1  MN5 ( .b(vss), .d(net039), .g(Pin), .s(clkneg));
ctranif1  MN1 ( .b(vss), .d(Pout), .g(P), .s(net039));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(G), .d(Gout));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(P), .d(net016));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(Gprev), .d(net016));
ctranif0  MP1 ( .b(vdd), .s(clkpos), .g(P), .d(Pout));
ctranif0  MP5 ( .b(vdd), .s(clkpos), .g(Pin), .d(Pout));

endmodule
