// Library - MIPS25, Cell - and16b, View - schematic
// LAST TIME SAVED: Apr  9 21:28:11 2025
// NETLIST TIME: Apr 10 21:08:23 2025
`timescale 1ns / 1ns 

module and16b ( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8],
     a[9], a[10], a[11], a[12], a[13], a[14], a[15], b[0], b[1], b[2],
     b[3], b[4], b[5], b[6], b[7], b[8], b[9], b[10], b[11], b[12],
     b[13], b[14], b[15], clkneg, clkneg2, clkpos, clkpos2, out[0],
     out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8],
     out[9], out[10], out[11], out[12], out[13], out[14], out[15], vdd,
     vss );

input  clkneg, clkneg2, clkpos, clkpos2, vdd, vss;

input [0:15]  b;
output [0:15]  out;
input [0:15]  a;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "and16b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

and2b I15 ( a[4], b[4], clkneg, clkneg2, clkpos, clkpos2, out[4], vdd,
     vss);
and2b I14 ( a[3], b[3], clkneg, clkneg2, clkpos, clkpos2, out[3], vdd,
     vss);
and2b I13 ( a[2], b[2], clkneg, clkneg2, clkpos, clkpos2, out[2], vdd,
     vss);
and2b I12 ( a[1], b[1], clkneg, clkneg2, clkpos, clkpos2, out[1], vdd,
     vss);
and2b I11 ( a[0], b[0], clkneg, clkneg2, clkpos, clkpos2, out[0], vdd,
     vss);
and2b I10 ( a[5], b[5], clkneg, clkneg2, clkpos, clkpos2, out[5], vdd,
     vss);
and2b I9 ( a[6], b[6], clkneg, clkneg2, clkpos, clkpos2, out[6], vdd,
     vss);
and2b I8 ( a[7], b[7], clkneg, clkneg2, clkpos, clkpos2, out[7], vdd,
     vss);
and2b I7 ( a[8], b[8], clkneg, clkneg2, clkpos, clkpos2, out[8], vdd,
     vss);
and2b I6 ( a[9], b[9], clkneg, clkneg2, clkpos, clkpos2, out[9], vdd,
     vss);
and2b I5 ( a[10], b[10], clkneg, clkneg2, clkpos, clkpos2, out[10],
     vdd, vss);
and2b I4 ( a[11], b[11], clkneg, clkneg2, clkpos, clkpos2, out[11],
     vdd, vss);
and2b I3 ( a[12], b[12], clkneg, clkneg2, clkpos, clkpos2, out[12],
     vdd, vss);
and2b I1 ( a[14], b[14], clkneg, clkneg2, clkpos, clkpos2, out[14],
     vdd, vss);
and2b I0 ( a[15], b[15], clkneg, clkneg2, clkpos, clkpos2, out[15],
     vdd, vss);
and2b I2 ( a[13], b[13], clkneg, clkneg2, clkpos, clkpos2, out[13],
     vdd, vss);

endmodule
