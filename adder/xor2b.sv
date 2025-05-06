// Library - MIPS25, Cell - xor2b, View - schematic
// LAST TIME SAVED: Mar 31 14:55:13 2025
// NETLIST TIME: Apr 27 19:08:19 2025
`timescale 1ns / 1ns 

module xor2b ( A, B, Cout, clkneg1, clkneg2, clkpos1, clkpos2, vdd, vss
     );

input  A, B, clkneg1, clkneg2, clkpos1, clkpos2, vdd, vss;
output Cout;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "xor2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN7 ( .b(vss), .d(net022), .g(B), .s(clkneg1));
ctranif1  MN6 ( .b(vss), .d(Cout), .g(net027), .s(net042));
ctranif1  MN1 ( .b(vss), .d(net027), .g(A), .s(clkneg1));
ctranif1  MN2 ( .b(vss), .d(Cout), .g(A), .s(net018));
ctranif1  MN5 ( .b(vss), .d(net042), .g(net022), .s(clkneg2));
ctranif1  MN4 ( .b(vss), .d(net018), .g(B), .s(clkneg2));
ctranif0  MP7 ( .b(vdd), .s(clkpos1), .g(B), .d(net022));
ctranif0  MP1 ( .b(vdd), .s(clkpos1), .g(A), .d(net027));
ctranif0  MP6 ( .b(vdd), .s(net016), .g(A), .d(Cout));
ctranif0  MP0 ( .b(vdd), .s(clkpos2), .g(B), .d(net043));
ctranif0  MP4 ( .b(vdd), .s(clkpos2), .g(net022), .d(net016));
ctranif0  MP5 ( .b(vdd), .s(net043), .g(net027), .d(Cout));

endmodule
