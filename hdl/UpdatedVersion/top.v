`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module topLevel(clk, clear, next, MS, Din, level, Done_out);
	input clk, clear, next, level;
	input [2:0] MS;
	input [15:0] Din;
	output Done_out;
	//output [15:0] Alu_out;

	wire W1_wire, WE_wire;
	wire Done_out;
	wire clk50MHz, rst, clksec4, clk5kHz;
	wire[1:0] LEDsel;
	wire[3:0] Din_dis1, Din_dis2, MS_out_wire;
	wire[3:0] ALU_out0, ALU_out1, ALU_out2, ALU_out3;
	wire[15:0] ALU_out;
	
	
	
	//Done_out, clk50MHz, clk5KHz, rst,
    //Din_dis1, Din_dis2,
    //ALU_out0, ALU_out1, ALU_out2, ALU_out3,
    //LEDsel,
    //LED0, LED1, LED2, LED3

	

    //CLK_Generator U0(clk50MHz, rst, clksec4, clk5KHz);
	FSM sfm1 (clk, clear, next, MS, MS_out_wire, LEDsel, Done_out, W1_wire, WE_wire);
	Datapath datapath1 (clk, Din, WE_wire, W1_wire, level, MS_wire, Alu_out, Din_dis1, Din_dis2);
	//
	//a module to turn ALU_out into decimal 4 outputs
	//
	Encase_Level EL1(MS_out, CS_out, Done_out, clk50MHz, clk5KHz, rst,
    Din_dis1, Din_dis2,
    ALU_out0, ALU_out1, ALU_out2, ALU_out3,
    LEDsel,
    LED0, LED1, LED2, LED3);

	 
endmodule