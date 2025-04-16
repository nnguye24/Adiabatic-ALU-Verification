module bennett_clock_tb;
    // Parameters
    parameter WIDTH = 11;
    parameter CLK_PERIOD = 10; // 10 time units for clock period
    
    // Testbench signals
    reg ext_clk;
    reg reset;
    wire [WIDTH-1:0] clkn;
    wire [WIDTH-1:0] clkp;
    
    // Instantiate the Bennett clock module
    bennett_clock #(
        .WIDTH(WIDTH)
    ) dut (
        .ext_clk(ext_clk),
        .reset(reset),
        .clkn(clkn),
        .clkp(clkp)
    );
    
    // Generate external clock
    always begin
        ext_clk = 0;
        #(CLK_PERIOD/2);
        ext_clk = 1;
        #(CLK_PERIOD/2);
    end
    
    // Display signals in waveform
    initial begin
        $dumpfile("bennett_clock.vcd");
        $dumpvars(0, bennett_clock_tb);
    end
    
    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        #(CLK_PERIOD*2);
        reset = 0;
        
        // Run for enough cycles to see full ramp up and down pattern
        // For WIDTH=11, we need at least 11*2 + a few extra cycles
        #(CLK_PERIOD*30);
        
        // Display results
        $display("Testbench completed");
        $finish;
    end
    
    // Monitor to display changes
    always @(clkn or clkp) begin
        $display("Time=%0t, clk=%b, clkp=%b", $time, clkn, clkp);
    end
    
endmodule