module tb();
    supply1 vdd;
    supply0 vss;

    reg [15:0] in_a;
    reg [15:0] in_b;
    wire [15:0] out;

    // Clock and control signals
    reg clk;
    reg reset;
    wire instFlag;
    wire [1:0] clkn;  
    wire [1:0] clkp;  

    // Instantiate the Bennett clock generator
    bennett_clock #(
        .WIDTH(2)  // Only need 2 bits for clkn and clkp in your and16b module
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .clkn(clkn),
        .clkp(clkp)
    );

    // Connect using positional port connections for the and16b module
    and16b and_tb(
        in_a[0], in_a[1], in_a[2], in_a[3], in_a[4], in_a[5], in_a[6], in_a[7],
        in_a[8], in_a[9], in_a[10], in_a[11], in_a[12], in_a[13], in_a[14], in_a[15],
        
        in_b[0], in_b[1], in_b[2], in_b[3], in_b[4], in_b[5], in_b[6], in_b[7],
        in_b[8], in_b[9], in_b[10], in_b[11], in_b[12], in_b[13], in_b[14], in_b[15],
        
        clkn[0], clkn[1], clkp[0], clkp[1],
        
        out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7],
        out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15],
        
        vdd, vss
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units per clock cycle
    end

    // Test sequence
    initial begin
        // Initialize
        in_a = 16'h0000;
        in_b = 16'h0000;
        reset = 1;
        #20;
        reset = 0;

        // Wait for the instFlag to signal the completion of a cycle
        @(posedge instFlag);
        $display("Test case 0: a=%h, b=%h, output=%h", in_a, in_b, out);
        
        // Test case 1: a=FFFF, b=0000
        in_a = 16'hFFFF;
        in_b = 16'h0000;
        #1;
        
        // Wait for the next cycle
        @(posedge instFlag);
        $display("Test case 1: a=%h, b=%h, output=%h", in_a, in_b, out);
        
        // Test case 2: a=0000, b=FFFF
        in_a = 16'h0000;
        in_b = 16'hFFFF;
        #1;
        
        // Wait for the next cycle
        @(posedge instFlag);
        $display("Test case 2: a=%h, b=%h, output=%h", in_a, in_b, out);
        
        // Test case 3: a=FFFF, b=FFFF
        in_a = 16'hFFFF;
        in_b = 16'hFFFF;
        #1;
        
        // Wait for the next cycle
        @(posedge instFlag);
        $display("Test case 3: a=%h, b=%h, output=%h", in_a, in_b, out);
        
        // Test case 4: a=0000, b=0000
        in_a = 16'h0000;
        in_b = 16'h0000;
        #1;
        
        // Wait for the final cycle
        @(posedge instFlag);
        $display("Test case 4: a=%h, b=%h, output=%h", in_a, in_b, out);
        
        // End simulation
        #10;
        $finish;
    end
endmodule