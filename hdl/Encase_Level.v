`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//Op, in1, in2, CSout, Done, Out, Go_top, RST_db, clk50MHz, clk5KHz, rst, ledout, ledsel
//Din, MS, ALU_out
module Encase_Level(MS_out, Done_out, clear,
    Din_dis1, Din_dis2,
    ALU_out0, ALU_out1, ALU_out2, ALU_out3,
    LEDsel,
    LED0, LED1, LED2, LED3,
    

    );
    //input clk50MHz, clk5KHz; //clk5KHz not used
    input clear;   
    input[1:0] LEDsel;
    input[3:0] MS_out;
    input[3:0] Din_dis1, Din_dis2, ALU_out0, ALU_out1, ALU_out2, ALU_out3;
    output[7:0] LED0, LED1, LED2, LED3;
    //output  [3:0] CS_out;   //not used
    output  Done_out;       //a LED light

    
    wire Go;
    //wire we, rea, reb, s2;
    ///wire DONT_USE, clksec4;                        //clk_5KHz
    wire [7:0] state, result;
    wire [7:0] Din_7seg1, Din_7seg2, ALUout_7seg0, ALUout_7seg1, ALUout_7seg2, ALUout_7seg3, MS_7seg;
    
    //CLK_Generator U0(clk50MHz, rst, clksec4, clk5KHz);     //not sure where to put the clock
    //debounce U1(Go, Go_top, clk50MHz);
    BCD27SEG U2(Din_dis1, Din_7seg1);
    BCD27SEG U3(Din_dis2, Din_7seg2);
    BCD27SEG U4(ALU_out0, ALUout_7seg0);
    BCD27SEG U5(ALU_out1, ALUout_7seg1);
    BCD27SEG U6(ALU_out2, ALUout_7seg2);
    BCD27SEG U7(ALU_out3, ALUout_7seg3);
    BCD27SEG U8(MS_out, MS_7seg);
    LED_MUX2 U9(Din_7seg1, Din_7seg2, ALUout_7seg0, ALUout_7seg1, ALUout_7seg2, ALUout_7seg3, MS_7seg, 
    LED0, LED1, LED2, LED3,
    LEDsel);
    
endmodule
