module bennett_clock #(
    parameter WIDTH = 11
)(
    input wire clk,
    input wire reset,
    output reg instFlag,
  	output reg Fclk,	// Slow clock 
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
      	Fclk <= 0;
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
                      
                    end
                  if (counter == WIDTH-1) begin
                        state <= RAMP_DOWN;
                      	Fclk <= 1;
                        counter <= 1;
                    end
                end

                RAMP_DOWN: begin
                  	Fclk <= 0;
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