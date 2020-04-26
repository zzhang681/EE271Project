`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module Datapath(CLK, Din, num_R1, num_R2, WE, W1, MS, ALU_out

    );
    parameter size_data = 16;
    
    input CLK;
    input WE;
    input[2:0] W1;
    input[2:0] num_R1, num_R2;
    input[2:0] MS;
    input[size_data - 1:0] Din;
    output [size_data - 1:0] ALU_out;
    wire[size_data - 1:0] Dout_1, Dout_2;
    
    register REG1(CLK, num_R1, num_R2, W1, Din, WE, Dout_1, Dout_2);
    ALU ALU1(Dout_1, Dout_2, MS, ALU_out);
    
    //how to input two numbers in 1 Din?
    
    
endmodule
