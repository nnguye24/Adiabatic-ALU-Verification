class alu_transaction extends uvm_sequence_item;

  `uvm_object_utils(alu_transaction)
  
  
  rand bit ALU_Control0, ALU_Control1, A_Fclkpos, A_mux, Adder_Cin, B_mux0, B_mux1, STL, SUB, mux3_0, mux3_1;
  rand bit [15:0] a,b;
  rand bit [15:0] PC_in;
  
  rand bit [15:0] instr_in;
  
  
  bit [15:0] SRAM_in;
  bit ALU_O_Fclkpos;
  bit ALU_OUT_Fclkneg;
  bit A_Fclkneg_out;
  bit out_Zero_Detect;
  bit [15:0] out;
  bit [15:0] ALU_out;
  
  
  bit [0:16] clkp_out, clkn_out;
  
  function new(string name = "alu_transaction");
        super.new(name);
    endfunction: new
    
    
  `uvm_object_utils_begin(adder_transaction)
    `uvm_field_int(a, UVM_ALL_ON)
    `uvm_field_int(b, UVM_ALL_ON)
    `uvm_field_int(PC_in, UVM_ALL_ON)
    `uvm_field_int(SRAM_in, UVM_ALL_ON)
    `uvm_field_int(instr_in, UVM_ALL_ON)
    `uvm_field_int(out, UVM_ALL_ON)
    `uvm_field_int(ALU_out, UVM_ALL_ON)
    `uvm_field_int(clkp_out, UVM_ALL_ON)
    `uvm_field_int(clkn_out, UVM_ALL_ON)

  `uvm_object_utils_end
  
endclass: alu_transaction