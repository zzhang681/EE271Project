`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module topLevel(clk, clear, next, MS, Din, Done_out, CS_out, Alu_out);
	input clk, clear, next;
	input [2:0] MS;
	input [15:0] Din;
	output Done_out;
	output [2:0] CS_out;
	output [15:0] Alu_out;

	wire [2:0] MS_wire;
	wire W1_wire, WE_wire;

	FSM sfm1 (clk, clear, next, MS, MS_wire, CS_out, Done_out, W1_wire, WE_wire);
	Datapath datapath1 (clk, Din, WE_wire, W1_wire, MS_wire, Alu_out);
