// Consolidated adder modules for EDA Playground

module ctranif1(b, d, g, s);  // NMOS
    supply1 vdd;
    supply0 vss;

    input b, g, d;
    output s;

    tranif1 n1(d, s, g);
endmodule

module ctranif0(b, s, g, d);  // PMOS
    supply1 vdd;
    supply0 vss;
    input b, g, s;
    output d;

    tranif0 p1(s, d, g);
endmodule

// Inverter
module inv(clkneg, clkpos, in, out, vdd, vss);
    input clkneg, clkpos, in, vdd, vss;
	output out;
    specify 
        specparam CDS_LIBNAME  = "MIPS25";
        specparam CDS_CELLNAME = "inv";
        specparam CDS_VIEWNAME = "schematic";
    endspecify

    ctranif1 MN1(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif0 MP1(.b(vdd), .s(clkpos), .g(in), .d(out));
endmodule

// High fanout inverter
module inv_fo16(clkneg, clkpos, in, out, vdd, vss);
    input clkneg, clkpos, in, vdd, vss;
    output out;

    specify 
        specparam CDS_LIBNAME  = "MIPS25";
        specparam CDS_CELLNAME = "inv_fo16";
        specparam CDS_VIEWNAME = "schematic";
    endspecify

    ctranif1 MN15(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN14(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN13(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN12(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN11(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN10(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN9(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN8(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN7(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN6(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN5(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN4(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN0(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN2(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN3(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif1 MN1(.b(vss), .d(out), .g(in), .s(clkneg));
    ctranif0 MP15(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP14(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP13(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP12(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP11(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP10(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP9(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP8(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP7(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP6(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP5(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP4(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP3(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP2(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP0(.b(vdd), .s(clkpos), .g(in), .d(out));
    ctranif0 MP1(.b(vdd), .s(clkpos), .g(in), .d(out));
endmodule

// 2-input AND gate
module and2b(a, b, clkneg, clkneg2, clkpos, clkpos2, out, vdd, vss);
    input a, b, clkneg, clkneg2, clkpos, clkpos2, vdd, vss;
    output out;

    specify 
        specparam CDS_LIBNAME  = "MIPS25";
        specparam CDS_CELLNAME = "and2b";
        specparam CDS_VIEWNAME = "schematic";
    endspecify

    ctranif1 MN0(.b(vss), .d(net014), .g(b), .s(clkneg));
    ctranif1 MN2(.b(vss), .d(out), .g(net017), .s(clkneg2));
    ctranif1 MN1(.b(vss), .d(net017), .g(a), .s(net014));
    ctranif0 MP0(.b(vdd), .s(clkpos), .g(a), .d(net017));
    ctranif0 MP2(.b(vdd), .s(clkpos2), .g(net017), .d(out));
    ctranif0 MP1(.b(vdd), .s(clkpos), .g(b), .d(net017));
endmodule

// Black cell for Brent-Kung adder
module black_cell2b ( G, Gout, Gprev, P, Pin, Pout, clkneg, clkpos,
     vdd, vss );

	input  G,  Gprev, P, Pin, clkneg, clkpos, vdd, vss;
	output Gout, Pout;

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


// Black cell with inverter for Brent-Kung adder
module black_cell_inv2b ( Cout, G, Gprev, P, Pout, Pprev, clkneg,
     clkpos, vdd, vss );

input   G, Gprev, P,  Pprev, clkneg, clkpos, vdd, vss;
output Cout, Pout;

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

// Gray cell for Brent-Kung adder
module gray_cell2b ( Cout, G, Gprev, P, clkneg, clkpos, vdd, vss );

input   G, Gprev, P, clkneg, clkpos, vdd, vss;
output Cout;

specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "gray_cell2b";
    specparam CDS_VIEWNAME = "schematic";
endspecify

ctranif1  MN2 ( .b(vss), .d(Cout), .g(Gprev), .s(net018));
ctranif1  MN0 ( .b(vss), .d(Cout), .g(G), .s(clkneg));
ctranif1  MN4 ( .b(vss), .d(net018), .g(P), .s(clkneg));
ctranif0  MP2 ( .b(vdd), .s(net016), .g(G), .d(Cout));
ctranif0  MP0 ( .b(vdd), .s(clkpos), .g(P), .d(net016));
ctranif0  MP4 ( .b(vdd), .s(clkpos), .g(Gprev), .d(net016));

endmodule


// Gray cell with inverter for Brent-Kung adder
module gray_cell_inv2b ( Cout, G, Gprev, P, clkneg, clkpos, vdd, vss );

input   G, Gprev, P, clkneg, clkpos, vdd, vss;
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


// XOR gate for adder
module xor2b(A, B, Cout, clkneg1, clkneg2, clkpos1, clkpos2, vdd, vss);
    input A, B, clkneg1, clkneg2, clkpos1, clkpos2, vdd, vss;
    output Cout;

    specify 
        specparam CDS_LIBNAME  = "MIPS25";
        specparam CDS_CELLNAME = "xor2b";
        specparam CDS_VIEWNAME = "schematic";
    endspecify

    ctranif1 MN7(.b(vss), .d(net022), .g(B), .s(clkneg1));
    ctranif1 MN6(.b(vss), .d(Cout), .g(net027), .s(net042));
    ctranif1 MN1(.b(vss), .d(net027), .g(A), .s(clkneg1));
    ctranif1 MN2(.b(vss), .d(Cout), .g(A), .s(net018));
    ctranif1 MN5(.b(vss), .d(net042), .g(net022), .s(clkneg2));
    ctranif1 MN4(.b(vss), .d(net018), .g(B), .s(clkneg2));
    ctranif0 MP7(.b(vdd), .s(clkpos1), .g(B), .d(net022));
    ctranif0 MP1(.b(vdd), .s(clkpos1), .g(A), .d(net027));
    ctranif0 MP6(.b(vdd), .s(net016), .g(A), .d(Cout));
    ctranif0 MP0(.b(vdd), .s(clkpos2), .g(B), .d(net043));
    ctranif0 MP4(.b(vdd), .s(clkpos2), .g(net022), .d(net016));
    ctranif0 MP5(.b(vdd), .s(net043), .g(net027), .d(Cout));
endmodule

// Bennett clock module for adiabatic operation
module bennett_clock #(
    parameter WIDTH = 11
)(
    input wire clk,
    input wire reset,
    output reg instFlag,
    output reg [WIDTH-1:0] clkn,
    output reg [WIDTH-1:0] clkp
);

    localparam IDLE = 2'b00;
    localparam RAMP_UP = 2'b01;
    localparam RAMP_DOWN = 2'b10;
    localparam ALL_X = 2'b11;

    reg [1:0] state;
    reg [3:0] counter;
    integer i;

    initial begin
        instFlag <= 0;
        clkn = {WIDTH{1'bX}};
        clkp = {WIDTH{1'bX}};
        state = IDLE;
        counter = 0;
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instFlag <= 0;
            clkn <= {WIDTH{1'bX}};
            clkp <= {WIDTH{1'bX}};
            state <= IDLE;
            counter <= 1;
        end else begin
            case (state)
                IDLE: begin
                    instFlag <= 0;
                    state <= RAMP_UP;
                    clkn <= {WIDTH{1'bX}};
                    clkp <= {WIDTH{1'bX}};
                    clkn[0] <= 1'b0;
                    clkp[0] <= 1'b1;
                    counter <= 1;
                end

                RAMP_UP: begin
                    if (counter < WIDTH) begin
                        for (i = 0; i < WIDTH; i = i + 1) begin
                            if (i <= counter) begin
                                clkn[i] <= 1'b0;
                                clkp[i] <= 1'b1;
                            end else begin
                                clkn[i] <= 1'bX;
                                clkp[i] <= 1'bX;
                            end
                        end
                        counter <= counter + 1;
                    end else begin
                        state <= RAMP_DOWN;
                        counter <= 1;
                    end
                end

                RAMP_DOWN: begin
                    if (counter < WIDTH) begin
                        for (i = 0; i < WIDTH; i = i + 1) begin
                            if (i < WIDTH - counter) begin
                                clkn[i] <= 1'b0;
                                clkp[i] <= 1'b1;
                            end else begin
                                clkn[i] <= 1'bX;
                                clkp[i] <= 1'bX;
                            end
                        end
                        counter <= counter + 1;
                    end else begin
                        clkn <= {WIDTH{1'bX}};
                    	clkp <= {WIDTH{1'bX}};
                        instFlag <= 1;
                        state <= IDLE;
                    end
                end
              
                default: state <= IDLE;
            endcase
        end
    end

endmodule


// Top level adder module_new
module adder ( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8],
     a[9], a[10], a[11], a[12], a[13], a[14], a[15], b[0], b[1], b[2],
     b[3], b[4], b[5], b[6], b[7], b[8], b[9], b[10], b[11], b[12],
     b[13], b[14], b[15], cin, clkneg[0], clkneg[1], clkneg[2],
     clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkpos[0],
     clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6],
     clkpos[7], cout, out[0], out[1], out[2], out[3], out[4], out[5],
     out[6], out[7], out[8], out[9], out[10], out[11], out[12],
     out[13], out[14], out[15], vdd, vss );

input  cin, vdd, vss;
output cout;
  
input [0:7]  clkneg;
input [0:7]  clkpos;
input [0:15]  b;
input [0:15]  a;
output [0:15]  out;

// Buses in the design

wire  [0:15]  p1;


specify 
    specparam CDS_LIBNAME  = "MIPS25";
    specparam CDS_CELLNAME = "adder";
    specparam CDS_VIEWNAME = "schematic";
endspecify

black_cell2b I87 ( net0342, net279, net327, net0338, net0743, net0301,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I86 ( net0711, net0361, net333, net0449, net0359, net283,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I85 ( net0705, net291, net458, net0441, net0731, net289,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I84 ( net0699, net378, net345, net0313, net0345, net377,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I83 ( net0311, net386, net0342, net0425, net0338, net301,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I82 ( net0687, net0629, net0711, net513, net0449, net393,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I81 ( net0681, net0326, net0705, net521, net0441, net313,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I80 ( net0675, net0617, net0699, net0314, net0313, net319,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I79 ( net0308, net0666, net0311, net414, net0425, net417,
     clkneg[4], clkpos[4], vdd, vss);
black_cell2b I61 ( net557, net439, net549, p1[1], p1[0], net551,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I60 ( net734, net0736, net557, p1[2], p1[1], net559,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I59 ( net573, net455, net734, p1[3], p1[2], net0382,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I58 ( net574, net463, net573, p1[4], p1[3], net0377,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I57 ( net746, net456, net574, p1[5], p1[4], net0373,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I56 ( net0526, net0726, net746, p1[6], p1[5], net591,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I55 ( net754, net487, net0526, p1[7], p1[6], net0353,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I54 ( net758, net480, net754, p1[8], p1[7], net607,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I53 ( net762, net503, net758, p1[9], p1[8], net486,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I52 ( net629, net496, net762, p1[10], p1[9], net494,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I51 ( net630, net504, net629, p1[11], p1[10], net517,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I50 ( net638, net640, net630, p1[12], p1[11], net525,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I49 ( net0470, net0684, net638, p1[13], p1[12], net647,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I48 ( net779, net528, net0470, p1[14], p1[13], net0316,
     clkneg[2], clkpos[2], vdd, vss);
black_cell2b I47 ( net780, net664, net779, p1[15], p1[14], net663,
     clkneg[2], clkpos[2], vdd, vss);
inv I126 ( clkneg[0], clkpos[0], cin, cin_inv, vdd, vss);
inv I125 ( clkneg[4], clkpos[4], net434, net0287, vdd, vss);
inv I124 ( clkneg[4], clkpos[4], net0318, net338, vdd, vss);
inv I104 ( clkneg[5], clkpos[5], net0341, net172, vdd, vss);
inv I103 ( clkneg[5], clkpos[5], net0866, net266, vdd, vss);
inv I102 ( clkneg[5], clkpos[5], net0197, net186, vdd, vss);
inv I101 ( clkneg[5], clkpos[5], net0878, net193, vdd, vss);
inv I78 ( clkneg[3], clkpos[3], net0385, net0324, vdd, vss);
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
black_cell_inv2b I105 ( net0300, net0666, net279, net417, net0298,
     net0301, clkneg[5], clkpos[5], vdd, vss);
black_cell_inv2b I75 ( net327, net455, net439, net0382, net0743,
     net551, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I74 ( net333, net463, net0736, net0377, net0359,
     net559, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I73 ( net458, net456, net455, net0373, net0731,
     net0382, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I72 ( net345, net0726, net463, net591, net0345,
     net0377, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I71 ( net0342, net487, net456, net0353, net0338,
     net0373, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I70 ( net0711, net480, net0726, net607, net0449,
     net591, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I69 ( net0705, net503, net487, net486, net0441,
     net0353, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I68 ( net0699, net496, net480, net494, net0313,
     net607, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I67 ( net0311, net504, net503, net517, net0425,
     net486, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I66 ( net0687, net640, net496, net525, net513, net494,
     clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I65 ( net0681, net0684, net504, net647, net521,
     net517, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I64 ( net0675, net528, net640, net0316, net0314,
     net525, clkneg[3], clkpos[3], vdd, vss);
black_cell_inv2b I63 ( net0308, net664, net0684, net663, net414,
     net647, clkneg[3], clkpos[3], vdd, vss);
inv_fo16 I123 ( clkneg[7], clkpos[7], net0848, cout, vdd, vss);
and2b I30 ( a[0], b[0], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net549, vdd, vss);
and2b I29 ( a[1], b[1], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net557, vdd, vss);
and2b I28 ( a[2], b[2], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net734, vdd, vss);
and2b I27 ( a[3], b[3], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net573, vdd, vss);
and2b I26 ( a[4], b[4], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net574, vdd, vss);
and2b I25 ( a[5], b[5], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net746, vdd, vss);
and2b I24 ( a[6], b[6], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net0526, vdd, vss);
and2b I23 ( a[7], b[7], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net754, vdd, vss);
and2b I22 ( a[8], b[8], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net758, vdd, vss);
and2b I21 ( a[9], b[9], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net762, vdd, vss);
and2b I20 ( a[10], b[10], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net629, vdd, vss);
and2b I19 ( a[11], b[11], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net630, vdd, vss);
and2b I18 ( a[12], b[12], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net638, vdd, vss);
and2b I17 ( a[13], b[13], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net0470, vdd, vss);
and2b I16 ( a[14], b[14], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net779, vdd, vss);
and2b I15 ( a[15], b[15], clkneg[0], clkneg[1], clkpos[0], clkpos[1],
     net780, vdd, vss);
xor2b I121 ( p1[0], cin, out[0], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I120 ( p1[1], net0324, out[1], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I119 ( p1[2], net0318, out[2], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I118 ( p1[3], net434, out[3], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I117 ( p1[4], net172, out[4], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I116 ( p1[5], net266, out[5], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I115 ( p1[6], net186, out[6], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I114 ( p1[7], net193, out[7], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I113 ( p1[8], net280, out[8], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I112 ( p1[9], net0652, out[9], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I111 ( p1[10], net214, out[10], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I110 ( p1[11], net298, out[11], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I109 ( p1[12], net228, out[12], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I108 ( p1[13], net0628, out[13], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I107 ( p1[14], net316, out[14], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I106 ( p1[15], net136, out[15], clkneg[6], clkneg[7], clkpos[6],
     clkpos[7], vdd, vss);
xor2b I46 ( a[0], b[0], p1[0], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I45 ( a[1], b[1], p1[1], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I44 ( a[2], b[2], p1[2], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I43 ( a[3], b[3], p1[3], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I42 ( a[4], b[4], p1[4], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I41 ( a[5], b[5], p1[5], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I40 ( a[6], b[6], p1[6], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I39 ( a[7], b[7], p1[7], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I38 ( a[8], b[8], p1[8], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I37 ( a[9], b[9], p1[9], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I36 ( a[10], b[10], p1[10], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I35 ( a[11], b[11], p1[11], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I34 ( a[12], b[12], p1[12], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I33 ( a[13], b[13], p1[13], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I32 ( a[14], b[14], p1[14], clkneg[0], clkneg[1], clkpos[0],
     clkpos[1], vdd, vss);
xor2b I31 ( a[15], b[15], p1[15], clkneg[0], clkneg[1], clkpos[0],
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



// Top adder wrapper module 
module adder_b (
    input wire [15:0] a,      // 16-bit input
    input wire [15:0] b,      // 16-bit input
    input wire cin,
    input wire clk,      
    input wire reset,          
    output wire [15:0] out,   // Changed to wire
    output wire cout,
    output wire calculation_done,  // Signal for when result is valid
    output wire [7:0] clkp_out,    // Outputs for monitoring clock signals
    output wire [7:0] clkn_out,
    output wire [15:0] propagate,  // Expose propagate signals for verification
    output wire [15:0] generate_   // Expose generate signals for verification (note trailing underscore to avoid keyword)
);
    // Power supplies
    supply1 vdd;             
    supply0 vss;

    // Bennett clock signals
    wire instFlag;
    wire [7:0] clkneg;
    wire [7:0] clkpos;

    // Connect monitor outputs to internal clock signals
    assign clkp_out = clkpos;
    assign clkn_out = clkneg;

    // Bennett clock generator
    bennett_clock #(
      .WIDTH(8)  // Match the original implementation
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .clkn(clkneg),
        .clkp(clkpos)
    );

    wire [15:0] internal_p1;
    
    // Adder instance with individual port connections
    adder adder_inst ( 
        a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8],
        a[9], a[10], a[11], a[12], a[13], a[14], a[15], 
        b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7], b[8], 
        b[9], b[10], b[11], b[12], b[13], b[14], b[15], 
        cin, clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], 
        clkneg[5], clkneg[6], clkneg[7], clkpos[0], clkpos[1], 
        clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6],
        clkpos[7], cout, out[0], out[1], out[2], out[3], out[4], 
        out[5], out[6], out[7], out[8], out[9], out[10], out[11], 
        out[12], out[13], out[14], out[15], vdd, vss
    );
    
  
  
    // Assign propagate and generate outputs
    // In this design, propagate signals are p = a XOR b
    // Generate signals are g = a AND b
    // We'll recreate them here since we can't directly access internal signals
    assign propagate = a ^ b;  // Propagate = a XOR b
    assign generate_ = a & b;  // Generate = a AND b
    
    // Signal to indicate when calculation is complete
    assign calculation_done = instFlag;
    
endmodule