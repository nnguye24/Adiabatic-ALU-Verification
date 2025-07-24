`timescale 1ns / 1ns

module flipflop2b_T ( Fclkneg, Fclkpos, Tclkpos, Tclkneg, In, Out, clkneg, clkpos, vdd, vss);
	
  input Fclkneg, Fclkpos, Tclkpos, Tclkneg, In, clkneg, clkpos, vdd, vss;
  output reg Out; 
    
  reg node;
    
  always @(posedge Tclkpos) begin
          node <= In;
  end
    
  always @(posedge Fclkpos) begin
          Out <= node;
  end

endmodule