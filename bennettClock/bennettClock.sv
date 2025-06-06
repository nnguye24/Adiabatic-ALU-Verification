module bennett_clock #(
    parameter WIDTH = 11      // Width of bennett clock signals
)(
    input wire clk,       // External clock input
    input wire reset,         // Reset signal
    output reg instFlag,    // Signal to call instruction at end of ramp down
    output reg [WIDTH-1:0] clkn,    // Bennett clock output
    output reg [WIDTH-1:0] clkp    // Bennett clock complement output
);

    // States for the state machine
    localparam IDLE = 2'b00;
    localparam RAMP_UP = 2'b01;
    localparam RAMP_DOWN = 2'b10;
    localparam ALL_X = 2'b11;     // State for all X's
    
    reg [1:0] state;
    reg [3:0] counter;        // Counter to track position in sequence
    integer i;                // Loop variable
    
    // Initialize with all X's
    initial begin
        instFlag <= 0;
        clkn = {WIDTH{1'bX}};
        clkp = {WIDTH{1'bX}};
        state = IDLE;
        counter = 0;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to all X's
            instFlag <= 0;
            clkn <= {WIDTH{1'bX}};
            clkp <= {WIDTH{1'bX}};
            state <= IDLE;
            counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    // Start ramping up - just set the LSB
                    instFlag <= 0;
                    state <= RAMP_UP;
                    clkn <= {WIDTH{1'bX}};
                    clkp <= {WIDTH{1'bX}};
                    clkn[0] <= 1'b0;
                    clkp[0] <= 1'b1;
                    counter <= 0;
                end
                
                RAMP_UP: begin
                    counter <= counter + 1;
                    
                    if (counter < WIDTH) begin
                        // Directly build the pattern with appropriate X's and 0/1s
                        for (i = 0; i < WIDTH; i = i + 1) begin
                            if (i <= counter) begin
                                clkn[i] <= 1'b0;
                                clkp[i] <= 1'b1;
                            end else begin
                                clkn[i] <= 1'bX;
                                clkp[i] <= 1'bX;
                            end
                        end
                    end else begin
                        // Fully activated, switch to ramp down
                        state <= RAMP_DOWN;
                        counter <= 0;
                    end
                end
                
                RAMP_DOWN: begin
                    counter <= counter + 1;
                    
                    if (counter < WIDTH) begin
                        // Directly build the pattern with appropriate X's and 0/1s
                        for (i = 0; i < WIDTH; i = i + 1) begin
                            if (i < WIDTH - counter) begin
                                clkn[i] <= 1'b0;
                                clkp[i] <= 1'b1;
                            end else begin
                                clkn[i] <= 1'bX;
                                clkp[i] <= 1'bX;
                            end
                        end
                    end else begin
                        // Move to ALL_X state
                        state <= ALL_X;
                    end
                end
                
                ALL_X: begin
                    // Set all bits to X for one cycle
                    clkn <= {WIDTH{1'bX}};
                    clkp <= {WIDTH{1'bX}};
                    instFlag <= 1;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end
    
endmodule