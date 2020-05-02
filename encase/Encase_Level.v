`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//Op, in1, in2, CSout, Done, Out, Go_top, RST_db, clk50MHz, clk5KHz, rst, ledout, ledsel
//Din, MS, ALU_out
module Encase_Level(MS, CS_out, Done_out, Go_top, RST_db, clk50MHz, clk5KHz, rst, ledout, ledsel

    );
    input clk50MHz, clk5KHz, rst;
    input  Go_top, RST_db;
    input[2:0] MS;
    output  [3:0] CS_out;   
    output  Done_out;       //a LED light
    output [3:0] ledsel;
    output [7:0] ledout;    //7-segment LED
    
    wire Go;
    //wire we, rea, reb, s2;
    wire DONT_USE, clk5KHz, clksec4;                        //clk_5KHz
    wire [7:0] state, result;
    
    CLK_Generator U0(clk50MHz, rst, clksec4, clk5KHz);     //clk_5KHz
    debounce U1(Go, Go_top, clk50MHz);
    //DP2 U2(.in1(in2), .in2(in1), .Go(Go), .Op(Op), .clk(clk50MHz), .out(Out), .CSout(CSout), .Done(Done));
    BCD27SEG U3(CS_out, state[0], state[1], state[2], state[3], state[4], state[5], state[6]);   // number, s0, s1, s2, s3, s4, s5, s6
    BCD27SEG U4(ALU_out, result[0], result[1], result[2], result[3], result[4], result[5], result[6]);  //result -> ALU_out
    LED_MUX U5 (.clk(clk_5KHz), .rst(rst), .LED0(state), .LED1(result), .LED2(), .LED3(), .LEDOUT(ledout), .LEDSEL(ledsel));   //led mux - led 2 and 3 not used

    
endmodule
