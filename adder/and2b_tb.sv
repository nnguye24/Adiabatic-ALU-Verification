module tb();
    supply1 vdd;
    supply0 vss;

    reg [1:0] in;
    reg out;

    reg [1:0] clkn;
    reg [1:0] clkp;

    and2b and_tb(.a(in[0]), .b(in[1]), .clkneg(clkn[0]), .clkneg2(clkn[1]), .clkpos(clkp[0]), .clkpos2(clkp[1]), .out(out), .vdd(vdd), .vss(vss));

    initial begin
        // Initialize
        in = 2'b00;
        clkn = 2'bXX;
        clkp = 2'bXX;
        #1;

        // Loop through all possible input values (00, 01, 10, 11)
        for (int i = 0; i < 5; i++) begin
            // ramp up
            clkn = 2'bX0;   clkp = 2'bX1; #1;
            clkn = 2'b00;   clkp = 2'b11; #1;
            $display("Test case %b: output = %b", in, out);
            // ramp down
            clkn = 2'b00;   clkp = 2'b11; #1;
            clkn = 2'bX0;   clkp = 2'bX1; #1;
            in = i[1:0];    clkn = 2'bXX;   clkp = 2'bXX; #1;
            
        end
        
    end

endmodule