// Library - MIPS25, Cell - zero_detector, View - schematic
// LAST TIME SAVED: May 15 19:21:34 2025
// NETLIST TIME: May 19 18:35:43 2025
`timescale 1ns / 1ns 
`include "nor2b.sv"
`include "inv_fo4.sv"
`include "xor16b.sv"
`include "nand2b.sv"
module zero_detector ( A[15:0], B[15:0], clkneg[0], clkneg[1],
     clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkpos[0],
     clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6],
     out, vdd, vss );

input vdd, vss;
output out;
input [15:0]  A;
input [15:0]  B;
input [0:6]  clkpos;
input [0:6]  clkneg;

// Buses in the design

wire  [15:0]  Cout;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "zero_detector";
    specparam CDS_VIEWNAME = "schematic";
endspecify

nor2b I15 ( net76, net017, clkneg[4], clkpos[4], net013, vdd, vss);
nor2b I14 ( net52, net08, clkneg[4], clkpos[4], net038, vdd, vss);
nor2b I8 ( Cout[1], Cout[0], clkneg[2], clkpos[2], net019, vdd, vss);
nor2b I7 ( Cout[3], Cout[2], clkneg[2], clkpos[2], net041, vdd, vss);
nor2b I6 ( Cout[5], Cout[4], clkneg[2], clkpos[2], net016, vdd, vss);
nor2b I5 ( Cout[7], Cout[6], clkneg[2], clkpos[2], net039, vdd, vss);
nor2b I4 ( Cout[9], Cout[8], clkneg[2], clkpos[2], net010, vdd, vss);
nor2b I3 ( Cout[11], Cout[10], clkneg[2], clkpos[2], net027, vdd, vss);
nor2b I2 ( Cout[13], Cout[12], clkneg[2], clkpos[2], net06, vdd, vss);
nor2b I1 ( Cout[15], Cout[14], clkneg[2], clkpos[2], net49, vdd, vss);
inv_fo4 I17 ( clkneg[6], clkpos[6], net011, out, vdd, vss);
xor16b I9 ( A[15:0], B[15:0], Cout[15:0], clkneg[0], clkneg[1],
     clkpos[0], clkpos[1], vdd, vss);
nand2b I16 ( net038, net013, clkneg[5], clkpos[5], net011, vdd, vss);
nand2b I13 ( net041, net019, clkneg[3], clkpos[3], net017, vdd, vss);
nand2b I12 ( net039, net016, clkneg[3], clkpos[3], net76, vdd, vss);
nand2b I11 ( net027, net010, clkneg[3], clkpos[3], net08, vdd, vss);
nand2b I10 ( net49, net06, clkneg[3], clkpos[3], net52, vdd, vss);

endmodule
