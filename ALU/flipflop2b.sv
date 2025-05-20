// Library - MIPS25, Cell - flipflop2b, View - schematic
// LAST TIME SAVED: Mar 31 16:45:14 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module flipflop2b ( Fclkneg, Fclkpos, In, Out, clkneg, clkpos, vdd, vss
     );

input  Fclkneg, Fclkpos, In, clkneg, clkpos, vdd, vss;
output Out;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "flipflop2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  M12 ( .b(vss), .d(vss), .g(Out), .s(net036));
ctranif1  M10 ( .b(vss), .d(Out), .g(net024), .s(vss));
ctranif1  M8 ( .b(vss), .d(net024), .g(Fclkneg), .s(net036));
ctranif1  M7 ( .b(vss), .d(net024), .g(Fclkpos), .s(net19));
ctranif1  M6 ( .b(vss), .d(net19), .g(net15), .s(clkneg));
ctranif1  M4 ( .b(vss), .d(clkneg), .g(net19), .s(net15));
ctranif1  M1 ( .b(vss), .d(net15), .g(clkpos), .s(In));
ctranif0  M11 ( .b(vdd), .s(net036), .g(Out), .d(vdd));
ctranif0  M9 ( .b(vdd), .s(vdd), .g(net024), .d(Out));
ctranif0  M5 ( .b(vdd), .s(clkpos), .g(net15), .d(net19));
ctranif0  M3 ( .b(vdd), .s(net15), .g(net19), .d(clkpos));
ctranif0  M2 ( .b(vdd), .s(In), .g(clkneg), .d(net15));

endmodule
