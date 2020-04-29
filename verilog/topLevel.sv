module topLevel(clk, clear, next, MS, Din, Done_out, CS_out, Alu_out);
	input clk, clear, next;
	input [2:0] MS;
	input [15:0] Din;
	output Done_out;
	output [2:0] CS_out;
	output [15:0] Alu_out;

	controll
