// Library - MIPS25, Cell - Register16b, View - schematic
// LAST TIME SAVED: Apr 24 21:41:02 2025
// NETLIST TIME: May 19 18:35:44 2025
`timescale 1ns / 1ns 

module Register16b ( Fclkneg, Fclkpos, clkneg, clkpos, in, out, vdd,
     vss );

input  Fclkneg, Fclkpos, clkneg, clkpos, vdd, vss;

output [15:0]  out;
input [15:0]  in;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "Register16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

flipflop2b I22[15:0] ( Fclkneg, Fclkpos, in[15:0], out[15:0], clkneg,
     clkpos, vdd, vss);

endmodule
