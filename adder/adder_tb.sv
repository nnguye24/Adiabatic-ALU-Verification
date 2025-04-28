module adder_tb();
    supply1 vdd;
    supply0 vss;

    reg [15:0] a;
    reg [15:0] b;
    reg cin;
    
    wire cout;
    wire [15:0] out;
    reg reset;
    reg clk;


    wire instFlag;
    wire [7:0] clkneg;  
    wire [7:0] clkpos;  

    bennett_clock #(
        .WIDTH(8)  
    ) bennett_gen (
        .clk(clk),
        .reset(reset),
        .instFlag(instFlag),
        .clkn(clkneg),
        .clkp(clkpos)
    );

    adder dut ( 
        a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8],
        a[9], a[10], a[11], a[12], a[13], a[14], a[15], b[0], b[1], b[2],
        b[3], b[4], b[5], b[6], b[7], b[8], b[9], b[10], b[11], b[12],
        b[13], b[14], b[15], cin, clkneg[0], clkneg[1], clkneg[2],
        clkneg[3], clkneg[4], clkneg[5], clkneg[6], clkneg[7], clkpos[0],
        clkpos[1], clkpos[2], clkpos[3], clkpos[4], clkpos[5], clkpos[6],
        clkpos[7], cout, out[0], out[1], out[2], out[3], out[4], out[5],
        out[6], out[7], out[8], out[9], out[10], out[11], out[12],
        out[13], out[14], out[15], vdd, vss
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units per clock cycle
    end
    
    // For debug - monitor Bennett clock phases
    initial begin
        $monitor("Time=%0t, instFlag=%b, clkneg=%b, clkpos=%b", 
                 $time, instFlag, clkneg, clkpos);
    end

    initial begin
        // Initialize
        a = 16'h0000;
        b = 16'h0000;
        cin = 0;
        reset = 1;
        #20;
        reset = 0;

        // Wait for the instFlag to signal the completion of a cycle
        @(posedge instFlag);
        $display("\nTest case 0: a=%h, b=%h, cin=%b", a, b, cin);
        $display("Expected: %h, Actual: %h, cout=%b", 16'h0000, out, cout);
        
        // Test case 1: a=000F, b=0001
        a = 16'h000F;
        b = 16'h0001;
        cin = 0;
        #1;
        
        @(posedge instFlag);
        $display("\nTest case 1: a=%h, b=%h, cin=%b", a, b, cin);
        $display("Expected: %h, Actual: %h, cout=%b", 16'h0010, out, cout);
        
        // Test case 2: a=0011, b=FF11, cin=1
        a = 16'h0011;
        b = 16'hFF11;
        cin = 1;
        #1;
        
        @(posedge instFlag);
        $display("\nTest case 2: a=%h, b=%h, cin=%b", a, b, cin);
        $display("Expected: %h, Actual: %h, cout=%b", 16'hFF23, out, cout);
        
        // Test case 3: a=FFFF, b=FFFF
        a = 16'hFFFF;
        b = 16'hFFFF;
        cin = 0;
        #1;

        @(posedge instFlag);
        $display("\nTest case 3: a=%h, b=%h, cin=%b", a, b, cin);
        $display("Expected: %h, Actual: %h, cout=%b", 16'hFFFE, out, cout);
        
        // Test case 4: a=1234, b=5678, cin=1
        a = 16'h1234;
        b = 16'h5678;
        cin = 1;
        #1;
        
        @(posedge instFlag);
        $display("\nTest case 4: a=%h, b=%h, cin=%b", a, b, cin);
        $display("Expected: %h, Actual: %h, cout=%b", 16'h68AD, out, cout);
        
        #10;
        $finish;
    end
endmodule