module tb();
    supply1 vdd;
    supply0 vss;

    reg [15:0] in_a;
    reg [15:0] in_b;
    wire [15:0] out;

    reg [1:0] clkn;
    reg [1:0] clkp;

    // Connect using positional port connections instead of named connections
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

    initial begin
        // Initialize
        in_a = 16'h0000;
        in_b = 16'h0000;
        clkn = 2'bXX;
        clkp = 2'bXX;
        #1;

        // Loop through test cases
        for (int i = 0; i < 5; i++) begin
            // Set inputs for this test case
            in_a = (i & 1) ? 16'hFFFF : 16'h0000;
            in_b = (i & 2) ? 16'hFFFF : 16'h0000;
            
            // ramp up
            clkn = 2'bX0;   clkp = 2'bX1; #1;
            clkn = 2'b00;   clkp = 2'b11; #1;
            $display("Test case %d: a=%h, b=%h, output=%h", i, in_a, in_b, out);
            
            // ramp down
            clkn = 2'b00;   clkp = 2'b11; #1;
            clkn = 2'bX0;   clkp = 2'bX1; #1;
            clkn = 2'bXX;   clkp = 2'bXX; #1;
        end
    end
endmodule