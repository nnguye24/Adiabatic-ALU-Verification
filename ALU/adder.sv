`include "black_cell2b.sv"
`include "black_cell_inv2b.sv"
`include "gray_cell2b.sv"
`include "gray_cell_inv2b.sv"
`include "inv.sv"
`include "inv_fo16.sv"
`include "and2b.sv"
`include "xor2b.sv"

// Library - MIPS25, Cell - adder, View - schematic
// LAST TIME SAVED: Jun 16 21:33:02 2025
// NETLIST TIME: Jul 10 17:04:17 2025
`timescale 1ns / 1ns 

module adder ( cout, out[0], out[1], out[2], out[3], out[4], out[5],
     out[6], out[7], out[8], out[9], out[10], out[11], out[12],
     out[13], out[14], out[15], a[0], a[1], a[2], a[3], a[4], a[5],
     a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15],
     b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], b[9], b[10],
     b[11], b[12], b[13], b[14], b[15], cin, clkneg[0], clkneg[1],
     clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7],
     clkpos[0], clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5],
     clkpos[6], clkpos[7], vdd, vss );

output  cout;

input  cin, vdd, vss;

output [0:15]  out;

input [0:7]  clkneg;
input [0:7]  clkpos;
input [0:15]  b;
input [0:15]  a;

// Buses in the design

wire  [0:15]  p1;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "adder";
    specparam CDS_VIEWNAME = "schematic";
endspecify

black_cell2b I87 ( net279, net0301, net0342, net327, net0338, net0743,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I86 ( net0361, net283, net0711, net333, net0449, net0359,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I85 ( net291, net289, net0705, net458, net0441, net0731,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I84 ( net378, net377, net0699, net345, net0313, net0345,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I83 ( net386, net301, net0311, net0342, net0425, net0338,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I82 ( net0629, net393, net0687, net0711, net513, net0449,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I81 ( net0326, net313, net0681, net0705, net521, net0441,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I80 ( net0617, net319, net0675, net0699, net0314, net0313,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I79 ( net0666, net417, net0308, net0311, net414, net0425,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I61 ( net439, net551, net557, net549, p1[1], p1[0],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I60 ( net0736, net559, net734, net557, p1[2], p1[1],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I59 ( net455, net0382, net573, net734, p1[3], p1[2],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I58 ( net463, net0377, net574, net573, p1[4], p1[3],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I57 ( net456, net0373, net746, net574, p1[5], p1[4],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I56 ( net0726, net591, net0526, net746, p1[6], p1[5],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I55 ( net487, net0353, net754, net0526, p1[7], p1[6],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I54 ( net480, net607, net758, net754, p1[8], p1[7],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I53 ( net503, net486, net762, net758, p1[9], p1[8],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I52 ( net496, net494, net629, net762, p1[10], p1[9],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I51 ( net504, net517, net630, net629, p1[11], p1[10],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I50 ( net640, net525, net638, net630, p1[12], p1[11],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I49 ( net0684, net647, net0470, net638, p1[13], p1[12],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I48 ( net528, net0316, net779, net0470, p1[14], p1[13],
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I47 ( net664, net663, net780, net779, p1[15], p1[14],
     clkneg[2], clkpos[2], vdd, vss);
inv I126 ( cin_inv, clkneg[0], clkpos[0], cin, vdd, vss);
inv I125 ( net0287, clkneg[4], clkpos[4], net434, vdd, vss);
inv I124 ( net338, clkneg[4], clkpos[4], net0318, vdd, vss);
inv I104 ( net172, clkneg[5], clkpos[5], net0341, vdd, vss);
inv I103 ( net266, clkneg[5], clkpos[5], net0866, vdd, vss);
inv I102 ( net186, clkneg[5], clkpos[5], net0197, vdd, vss);
inv I101 ( net193, clkneg[5], clkpos[5], net0878, vdd, vss);
inv I78 ( net0324, clkneg[3], clkpos[3], net0385, vdd, vss);
gray_cell_inv2b I100 ( net280, net279, cin_inv, net0301, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I99 ( net0652, net0361, net0385, net283, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I98 ( net214, net291, net338, net289, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I97 ( net298, net378, net0287, net377, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I96 ( net228, net386, net0341, net301, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I95 ( net0628, net0629, net0866, net393, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I94 ( net316, net0326, net0197, net313, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I93 ( net136, net0617, net0878, net319, clkneg[5],
     clkpos[5], vdd, vss);
gray_cell_inv2b I77 ( net0318, net439, cin_inv, net551, clkneg[3],
     clkpos[3], vdd, vss);
gray_cell_inv2b I76 ( net434, net0736, net0385, net559, clkneg[3],
     clkpos[3], vdd, vss);
black_cell_inv2b I105 ( net0300, net0298, net0666, net279, net417,
     net0301, clkneg[5], clkpos[5], vdd, vss);
black_cell_inv2b I75 ( net327, net0743, net455, net439, net0382,
     net551, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I74 ( net333, net0359, net463, net0736, net0377,
     net559, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I73 ( net458, net0731, net456, net455, net0373,
     net0382, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I72 ( net345, net0345, net0726, net463, net591,
     net0377, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I71 ( net0342, net0338, net487, net456, net0353,
     net0373, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I70 ( net0711, net0449, net480, net0726, net607,
     net591, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I69 ( net0705, net0441, net503, net487, net486,
     net0353, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I68 ( net0699, net0313, net496, net480, net494,
     net607, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I67 ( net0311, net0425, net504, net503, net517,
     net486, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I66 ( net0687, net513, net640, net496, net525, net494,
     clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I65 ( net0681, net521, net0684, net504, net647,
     net517, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I64 ( net0675, net0314, net528, net640, net0316,
     net525, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I63 ( net0308, net414, net664, net0684, net663,
     net647, clkneg[3], clkpos[3], vdd, vss);
inv_fo16 I123 ( cout, clkneg[7], clkpos[7], net0848, vdd, vss);
and2b I30 ( net549, a[0], b[0], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I29 ( net557, a[1], b[1], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I28 ( net734, a[2], b[2], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I27 ( net573, a[3], b[3], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I26 ( net574, a[4], b[4], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I25 ( net746, a[5], b[5], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I24 ( net0526, a[6], b[6], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I23 ( net754, a[7], b[7], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I22 ( net758, a[8], b[8], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I21 ( net762, a[9], b[9], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I20 ( net629, a[10], b[10], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I19 ( net630, a[11], b[11], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I18 ( net638, a[12], b[12], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I17 ( net0470, a[13], b[13], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I16 ( net779, a[14], b[14], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
and2b I15 ( net780, a[15], b[15], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I121 ( out[0], p1[0], cin, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I120 ( out[1], p1[1], net0324, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I119 ( out[2], p1[2], net0318, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I118 ( out[3], p1[3], net434, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I117 ( out[4], p1[4], net172, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I116 ( out[5], p1[5], net266, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I115 ( out[6], p1[6], net186, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I114 ( out[7], p1[7], net193, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I113 ( out[8], p1[8], net280, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I112 ( out[9], p1[9], net0652, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I111 ( out[10], p1[10], net214, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I110 ( out[11], p1[11], net298, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I109 ( out[12], p1[12], net228, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I108 ( out[13], p1[13], net0628, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I107 ( out[14], p1[14], net316, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I106 ( out[15], p1[15], net136, clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I46 ( p1[0], a[0], b[0], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I45 ( p1[1], a[1], b[1], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I44 ( p1[2], a[2], b[2], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I43 ( p1[3], a[3], b[3], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I42 ( p1[4], a[4], b[4], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I41 ( p1[5], a[5], b[5], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I40 ( p1[6], a[6], b[6], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I39 ( p1[7], a[7], b[7], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I38 ( p1[8], a[8], b[8], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I37 ( p1[9], a[9], b[9], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I36 ( p1[10], a[10], b[10], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I35 ( p1[11], a[11], b[11], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I34 ( p1[12], a[12], b[12], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I33 ( p1[13], a[13], b[13], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I32 ( p1[14], a[14], b[14], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I31 ( p1[15], a[15], b[15], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
gray_cell2b I122 ( net0848, net0300, net136, net0298, clkneg[6],
     clkpos[6], vdd, vss);
gray_cell2b I91 ( net0341, net327, cin, net0743, clkneg[4], clkpos[4],
     vdd, vss);
gray_cell2b I90 ( net0866, net333, net0324, net0359, clkneg[4],
     clkpos[4], vdd, vss);
gray_cell2b I89 ( net0197, net458, net0318, net0731, clkneg[4],
     clkpos[4], vdd, vss);
gray_cell2b I88 ( net0878, net345, net434, net0345, clkneg[4],
     clkpos[4], vdd, vss);
gray_cell2b I62 ( net0385, net549, cin, p1[0], clkneg[2], clkpos[2],
     vdd, vss);

endmodule

