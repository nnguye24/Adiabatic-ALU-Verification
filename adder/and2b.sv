// Library - MIPS25, Cell - and2b, View - schematic
// LAST TIME SAVED: Apr  9 21:08:08 2025
// NETLIST TIME: Apr 10 21:08:23 2025
`timescale 1ns / 1ns 

module and2b ( a, b, clkneg, clkneg2, clkpos, clkpos2, out, vdd, vss );

inout  a, b, clkneg, clkneg2, clkpos, clkpos2, out, vdd, vss;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "and2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

tranif1  MN0 ( .b(vss), .d(net014), .g(b), .s(clkneg));
tranif1  MN2 ( .b(vss), .d(out), .g(net017), .s(clkneg2));
tranif1  MN1 ( .b(vss), .d(net017), .g(a), .s(net014));
tranif0  MP0 ( .b(vdd), .s(clkpos), .g(a), .d(net017));
tranif0  MP2 ( .b(vdd), .s(clkpos2), .g(net017), .d(out));
tranif0  MP1 ( .b(vdd), .s(clkpos), .g(b), .d(net017));

endmodule
