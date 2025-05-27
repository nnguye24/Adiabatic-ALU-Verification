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
  	wire Fclk;
    wire instFlag;
  wire [11:0] clkneg;  
  wire [11:0] clkpos;  
    
    //wire [16:0] clkpos_mapped = {vdd, vdd, clkpos[12], vdd, vdd, clkpos[11:1], clkpos[12]};
    //wire [16:0] clkneg_mapped = {vss, vss, clkneg[12], vss, vss, clkneg[11:1], clkneg[12]};
	
	//             {clkneg[11], clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkneg[8], clkneg[9], clkneg[10], vss, vss, clkneg[11], vss, vss},
    // {clkpos[11], clkpos[0], clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9], clkpos[10], vdd, vdd, clkpos[11], vdd, vdd},
  
  
    bennett_clock #(
      .WIDTH(12)  
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
      	.Fclk(Fclk),
        .clkn(clkneg),
        .clkp(clkpos)
    );
    
    ALU dut ( ALU_Control0, ALU_Control1, ALU_OUT_Fclkneg,
       ALU_O_Fclkpos, A_Fclkneg_out, A_Fclkpos, A_mux, Adder_Cin, B_mux0,
       B_mux1, PC_in, SRAM_in, STL, SUB, a, alu_out, b, 
             {clkneg[11], clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkneg[8], clkneg[9], clkneg[10], vss, vss, clkneg[11], vss, vss},
             {clkpos[11], clkpos[0], clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9], clkpos[10], vdd, vdd, clkpos[11], vdd, vdd},
       instr_in, mux3_0, mux3_1, out, out_Zero_Detect, vdd, vss );
    
    // Dump waveform 
    initial begin
      $dumpfile("alu.vcd");
      $dumpvars(0, alu_tb);
    end
  
  	// CLock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units per clock cycle
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
        reset = 0;
        #20 
        reset = 0;


      	@(posedge instFlag) // wait for the first instFlag edge 
        // 1+2(I think)
        // A mux has to choose d which corresponds to SRAM_in, B mux has to choose b which corresponds to b_regout(flip flop output)
        // C0 = 0, C1 = 1 ==> adder out
        ALU_Control0 = 1;
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
//       	ALU_Control0 = 0;
//         ALU_Control1 = 1;
//         ALU_O_Fclkpos = 0;  
//         A_Fclkpos = 0;
//         A_mux = 1;  
//         Adder_Cin = 0;  
//         B_mux0 = 0; 
//         B_mux1 = 1;
//         PC_in = 16'b0000000000000000;  
//         SUB = 0;
//         STL = 0;
//         a = 16'b0000000000000000;   
//         b = 16'b0000000000000000;    
//         instr_in = 16'b0000000000000000;    
//         mux3_0 = 1;
//         mux3_1 = 1; 
		@(posedge instFlag); 
        $finish;
    end
endmodule