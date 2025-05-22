`include "bennetClock.sv"

module alu_tb();
    supply1 vdd;
    supply0 vss;

    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] PC_in;
    reg [15:0] instr_in;
    reg ALU_O_Fclkpos;
    reg A_Fclkpos;
    reg  ALU_Control0, ALU_Control1, A_mux, Adder_Cin, B_mux0, B_mux1, STL, SUB, mux3_0, mux3_1;
    
    
    wire [15:0] SRAM_in;
    wire [15:0] out;
    wire [15:0] alu_out;
    wire out_Zero_Detect;
    wire A_Fclkneg_out;
    wire ALU_OUT_Fclkneg;
    
    
    
    
    // bennett clock 
    reg reset;
    reg clk;
    wire instFlag;
    wire [12:0] clkneg;  
    wire [12:0] clkpos;  
    
    wire [16:0] clkpos_mapped = {vdd, vdd, clkpos[12], vdd, vdd, clkpos[11:1], clkpos[12]};
    wire [16:0] clkneg_mapped = {vss, vss, clkneg[12], vss, vss, clkneg[11:1], clkneg[12]};


    bennett_clock #(
        .WIDTH(13)  
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .clkn(clkneg),
        .clkp(clkpos)
    );

    // ALU dut (
    //     .ALU_Control0(ALU_Control0),
    //     .ALU_Control1(ALU_Control1),
    //     .ALU_OUT_Fclkneg(ALU_OUT_Fclkneg),
    //     .ALU_O_Fclkpos(ALU_O_Fclkpos),
    //     .A_Fclkneg_out(A_Fclkneg_out),
    //     .A_Fclkpos(A_Fclkpos),
    //     .A_mux(A_mux),
    //     .Adder_Cin(Adder_Cin),
    //     .B_mux0(B_mux0),
    //     .B_mux1(B_mux1),
    //     .PC_in(PC_in),
    //     .SRAM_in(SRAM_in),
    //     .STL(STL),
    //     .SUB(SUB),
    //     .a(a),
    //     .alu_out(alu_out),
    //     .b(b),
    //     .clkneg(clkneg_mapped),
    //     .clkpos(clkpos_mapped),
    //     .instr_in(instr_in),
    //     .mux3_0(mux3_0),
    //     .mux3_1(mux3_1),
    //     .out(out),
    //     .out_Zero_Detect(out_Zero_Detect),
    //     .vdd(vdd),
    //     .vss(vss)
    // );
    
    
    ALU dut ( ALU_Control0, ALU_Control1, ALU_OUT_Fclkneg,
       ALU_O_Fclkpos, A_Fclkneg_out, A_Fclkpos, A_mux, Adder_Cin, B_mux0,
       B_mux1, PC_in, SRAM_in, STL, SUB, a, alu_out, b, 
       {clkneg[12], clkneg[1:11], vss, vss, clkneg[12], vss, vss},
       {clkpos[12], clkpos[1:11], vdd, vdd, clkpos[12], vdd, vss},
       instr_in, mux3_0, mux3_1, out, out_Zero_Detect, vdd, vss );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units per clock cycle
    end

    initial begin
        
        @(posedge instFlag);
        
        $finish;
    end
endmodule