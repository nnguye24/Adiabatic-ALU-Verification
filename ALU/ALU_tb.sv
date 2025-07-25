`include "bennettClock.sv"

module alu_tb();
    supply1 vdd;
    supply0 vss;
	// ALU SIGNALS
    reg [15:0] a;
    reg [15:0] b;
    reg [15:0] PC_in;
    reg [15:0] instr_in;
  
    reg  ALU_Control0, ALU_Control1, A_mux, Adder_Cin, B_mux0, B_mux1, STL, SUB, mux3_0, mux3_1;
    
    
    wire [15:0] SRAM_in;
    wire [15:0] out;
    wire [15:0] alu_out;
    wire out_Zero_Detect;
	
  // input wire for reference
  wire in_wire;
  
    
    // bennett clock 
    reg reset;
    reg clk;
  	wire Mclk;
    wire instFlag;
  	wire logic [11:0] clkneg;  
  	wire logic [11:0] clkpos;  
  	wire Tclkpos;

  
    bennett_clock #(
      .WIDTH(12)  
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
      .instFlag(instFlag),	// basically Sclk for our register
      	.Mclk(Mclk),
        .clkn(clkneg),
        .clkp(clkpos)
    );
  
  
  ALU dut ( ALU_Control0, ALU_Control1, instFlag, instFlag, A_mux, Adder_Cin, B_mux0, B_mux1, PC_in, SRAM_in, STL, SUB, a, alu_out, b, 
             {Mclkn, clkneg[0], clkneg[1], clkneg[2], clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkneg[8], clkneg[9], clkneg[10], vss, vss, Mclkn, vss, vss},
             {Mclk, clkpos[0], clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6], clkpos[7], clkpos[8], clkpos[9], clkpos[10], vdd, vdd, Mclk, vdd, vdd},
       instr_in, mux3_0, mux3_1, out, out_Zero_Detect, vdd, vss, Tclkpos );
  
	assign Mclkn = ~Mclk;
  	assign Tclkpos  = (clkpos[11] === 1'bX )? 1'b0 : clkpos[11];
  	assign in_wire = (clkpos[10] === 1'bX) ? 1'b0 : clkpos[10];
    
  
  
  reg [15:0] sum;
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
  
  	// inputs block, for A and B
  always @(posedge clk) begin
    sum = a+b;
    
  end
  	initial begin
      // ADD TESTS
      a = 16'h0001;
      b = 16'h0002;
      $display("Adding %d and %d ..." ,a, b);
      @(posedge in_wire);
      
      assert(out == sum) $display("Sum PASS --> RECEIVED %d and EXPECTED: %d", out, sum);
        
      a = 16'h0008;
      b = 16'h0010;
      $display("Adding %d and %d ...", a, b);
      @(posedge in_wire);
      assert(out == sum) $display("Sum PASS --> RECEIVED %d and EXPECTED: %d", out, sum);
      
      a = 16'h0030;
      b = 16'h0060;
      $display("Adding %d and %d ...", a, b);
      @(posedge in_wire);
      assert(out == sum) $display("Sum PASS --> RECEIVED %d and EXPECTED: %d", out, sum);
      
      // SUB TESTS
      a = 16'h0001;
      b = 16'h0001;
      $display("Subtract Test A --> a = %d and b = %d ...", a, b);
      @(posedge in_wire);
      assert(out == 0) $display("Subtract Test PASS --> OUTPUT: %d", out);
      
      $display("Subtract Test B --> a = %d and b = %d ...", a, b);
      @(posedge in_wire);
      assert(out == 0) $display("Subtract Test PASS --> OUTPUT: %d", out);
      
      
      // CARRY-OUT
      a = 16'hFFFF;
      b = 16'h0001;
      $display("Carry-out Test A --> a = %d and b = %d ...", a, b);
      @(posedge in_wire);
      assert(out == 16'hFFFF) $display ("Carry-out Test PASS --> OUTPUT: %d" , out);
      
      a = 16'h7FFF;
      b = 16'h0001;
      $display("Carry-out Test B --> a = %d and b = %d ...", a, b);
      @(posedge in_wire);
      assert(out == 0) $display ("Carry-out Test PASS --> OUTPUT: %d" , out);
      
      // ZERO CHECK
      a = 16'h0000;
      b = 16'h0000;
      $display("Zero Check Test A --> a = %d and b = %d ..." , a,b);
      @(posedge in_wire);
      assert(out_Zero_Detect == 1) $display("Zero Check PASS --> OUTPUT: %d", out_Zero_Detect);
        
	  a = 16'hFFFF;
      b = 16'h0000;
      $display("Zero Check Test B --> a = %d and b = %d ..." , a,b);
      @(posedge in_wire);
      assert(out_Zero_Detect == 0) $display("Zero Check PASS --> OUTPUT: %d", out_Zero_Detect);
      
	  a = 16'hFFFF;
      b = 16'h0000;
      $display("Zero Check Test C --> a = %d and b = %d ..." , a,b);
      @(posedge in_wire);
      assert(out_Zero_Detect == 0) $display("Zero Check PASS --> OUTPUT: %d", out_Zero_Detect);
      
      // OR
      a = 16'b0000000010000000;
      b = 16'b0000000001000000;
      $display("OR Test --> a = %b, B = %b", a, b);
      @(posedge in_wire);
      assert(out == a | b) $display("OR check PASS --> OUTPUT %b", out);
      
      // AND
      a = 16'hFF00;
      b = 16'hFFFF;
      $display("AND Test --> a = %b, b = %b", a, b);
      @(posedge in_wire);
      assert(out == a & b) $display("AND check PASS --> OUTPUT %b", out);
     
    end

    initial begin
      
      	// ========== ACTUAL TESTBENCH START ==============
        // C0 = 1, C1 = 0 ==> adder out
        ALU_Control0 = 1;
        ALU_Control1 = 0;
      
        A_mux = 0;  // chooses the b output of the flip flop, b_regout
        
      	B_mux0 = 0; // choose the d(SRAM_in), output of the flip flop
        B_mux1 = 0;
        PC_in = 16'h0000;   // idk man, arbitrary value
      
        // subtract right and left
        SUB = 0;
        STL = 0;
      
        // ALU stuff
        instr_in = 16'b0000000000000000;    
		Adder_Cin = 0;  // carry in
      	
      	// selects alu_muxout
        mux3_0 = 0;
        mux3_1 = 0; 
      
      	// addition tests I think?
        @(posedge instFlag);
		@(posedge instFlag); 
      	@(posedge instFlag);

      	@(posedge instFlag);
      
      	Adder_Cin = 1;	// start the subtract, still on addition
        SUB = 1;
      	STL = 0;
      	$display("SUB: %d, STL:  %d, Cin = %d" , SUB, STL, Adder_Cin);
      	@(posedge instFlag);
      
        SUB = 0;
      	STL = 1;
        $display("SUB: %d, STL:  %d, Cin = %d" , SUB, STL, Adder_Cin);
//       	ALU_Control0 = 0;
//         ALU_Control1 = 0;
      	@(posedge instFlag);
      

      // Carry out 2 tests,
      	// first select the adder_cout datapath
      	ALU_Control0 = 0;
        ALU_Control1 = 0;
      	Adder_Cin = 0; // Reset 
      	SUB = 0;
      	STL = 0;
      	@(posedge instFlag);
      	@(posedge instFlag);
      	
      	
      // Zero Check 3 tests, 
      	ALU_Control0 = 1;	// go back to addition
        ALU_Control1 = 0;
      	@(posedge instFlag);
      	@(posedge instFlag);
      	@(posedge instFlag);
      
      // OR 1 test
      	// Select OR datapath
      	ALU_Control0 = 0;
        ALU_Control1 = 1;
      	@(posedge instFlag);
      // AND 1 test
      	// Select AND datapath
      	ALU_Control0 = 1;
        ALU_Control1 = 1;
      	@(posedge instFlag);
      	
        $finish;
    end
endmodule