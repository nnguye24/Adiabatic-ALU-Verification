`ifndef TB_PKG
`define TB_PKG

`include "uvm_macros.svh"
package adder_pkg;
	import uvm_pkg::*;

	`include "adder_transaction.sv"
	`include "adder_sequence.sv"
	`include "adder_ripple_carry_test.sv"
	`include "adder_generate_test.sv"
	`include "adder_sequencer.sv"
	`include "adder_monitor.sv"
	`include "adder_driver.sv"
	`include "adder_agent.sv"
	`include "adder_scoreboard.sv"
	`include "adder_coverage.sv"
	`include "adder_env.sv"
	`include "reset.sv"
	`include "adder_test.sv"
endpackage: adder_pkg