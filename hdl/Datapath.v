  
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module Datapath(CLK, Din, WE, W1, level, MS, ALU_out, Dis_1, Dis_2

    );
    //parameter size_data = 16;
    
    input CLK, level;
    input WE; //write enable
    input W1; // location for read-in data
    //input[2:0] num_R1, num_R2;
    input[2:0] MS;
    input[3:0] Din;
    output [15:0] ALU_out;
    output[3:0] Dis_1, Dis_2;
    wire[15:0] Dout_1, Dout_2;
    
    register REG1(CLK, W1, Din, WE, level, Dout_1, Dout_2, Dis_1, Dis_2);
    ALU ALU1(Dout_1, Dout_2, MS, ALU_out);
    
    
endmodule