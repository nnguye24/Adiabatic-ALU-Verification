`include "bennettClock.sv"

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
    // Slow clock generation
    always(@posedge clk) begin    
        if ((clkpos == 13'b1111111111111) && (clkneg == 13'b0000000000000)) begin
            ALU_O_Fclkpos <= 1;  
            A_Fclkpos <= 1;
        end else begin
            ALU_O_Fclkpos <= 0;  
            A_Fclkpos <= 0;
        end
    end

    initial begin
        // Initialize inputs 
        ALU_Control0 = 0;
        ALU_Control1 = 0;
        ALU_O_Fclkpos = 0;  
        A_Fclkpos = 0;
        A_mux = 0;  
        Adder_Cin = 0;  
        B_mux0 = 0; 
        B_mux1 = 0;
        PC_in = 16'b0000000000000000;  
        SUB = 0;
        STL = 0;
        a = 16'b0000000000000000;   
        b = 16'b0000000000000000;    
        instr_in = 16'b0000000000000000;    
        mux3_0 = 0;
        mux3_1 = 0; 


        @(posedge instFlag) // wait for the first instFlag edge 
        // 1+1(I think)
        // A mux has to choose d which corresponds to SRAM_in, B mux has to choose b which corresponds to b_regout(flip flop output)
        // C0 = 0, C1 = 1 ==> adder out
        ALU_Control0 = 0;
        ALU_Control1 = 1;

        ALU_O_Fclkpos = 0;  // slow clocks start at 0
        A_Fclkpos = 0;
        
        A_mux = 1;  // chooses the b output of the flip flop
        Adder_Cin = 0;  // carry in
        B_mux0 = 1; // choose the d, output of the flip flop
        B_mux1 = 1;
        PC_in = 16'b0000000000000000;   // idk man
        // subtract right and left
        SUB = 0;
        STL = 0;
        // ALU stuff
        a = 16'b0000000000000001;   // 1    
        b = 16'b0000000000000010;   // 2    
        instr_in = 16'b0000000000000001;    // i have no idea what this does does. Seems to be an input of a mux, doesnt go anywhere else. 
        // the type of operation is determined by ALU_Control0 and ALU_Control1 instead. Maybe this is for a jump instruction?
        mux3_0 = 0;
        mux3_1 = 0; 



        @(posedge instFlag); 

        
        $finish;
    end
endmodule