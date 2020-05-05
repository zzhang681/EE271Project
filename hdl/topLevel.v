`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module topLevel(clk, clear, next, MS, Din, level,EDL1, EDL2, EDL3, EDL4,Done_out, LED0, LED1, LED2, LED3,HEX4
    ,ALUout_test
    );
	input clk, clear, next, level;
	input [2:0] MS;
	input [3:0] Din;
	output reg [3:0] EDL1;
	output reg EDL2;
	output reg [2:0] EDL3;
	output reg EDL4;
	output wire Done_out;
	output wire[7:0] LED0, LED1, LED2, LED3;
	output wire [7:0]HEX4;
	output reg[15:0] ALUout_test;
	//output [15:0] Alu_out;

	wire W1_wire, WE_wire;
	//wire Done_out;
	wire[1:0] LEDsel;
	wire[3:0] cs_out;
	wire[3:0] Din_dis1, Din_dis2, MS_out_wire;
	wire[3:0] ALU_out0, ALU_out1, ALU_out2, ALU_out3;
	wire[15:0] ALU_out;
	
	always @(Din or level or MS or Done_out)
	begin
	EDL1 = Din;
	EDL2 = level;
	EDL3 = MS;
	EDL4 = !next;
	end
	
	always@(*) ALUout_test = ALU_out;
	

    //CLK_Generator U0(clk50MHz, rst, clksec4, clk5KHz);
	FSM sfm1 (clk, clear, next, MS, MS_out_wire, LEDsel, Done_out, W1_wire, WE_wire, cs_out);
	Datapath datapath1 (clk, Din, WE_wire, W1_wire, level, MS, AlU_out, Din_dis1, Din_dis2);
	fourbit U4(ALU_out, ALU_out3, ALU_out2, ALU_out1, ALU_out0);
	Encase_Level EL1(MS_out_wire,  clear,
    Din_dis1, Din_dis2,
    ALU_out0, ALU_out1, ALU_out2, ALU_out3,
    LEDsel,
    LED0, LED1, LED2, LED3);
   BCD27SEG U5(cs_out, HEX4);
	 
endmodule