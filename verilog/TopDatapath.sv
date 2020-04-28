`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module Datapath(CLK, Din, WE, W1, MS, ALU_out

    );
    parameter size_data = 16;
    
    input CLK;
    input WE; //write enable
    input W1; // location for read-in data
    //input[2:0] num_R1, num_R2;
    input[2:0] MS;
    input[size_data - 1:0] Din;
    output [size_data - 1:0] ALU_out;
    wire[size_data - 1:0] Dout_1, Dout_2;
    
    register REG1(CLK, W1, Din, WE, Dout_1, Dout_2);
    ALU ALU1(Dout_1, Dout_2, MS, ALU_out);
    
    
endmodule
