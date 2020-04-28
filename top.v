`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module top(CLK, Din, Go, next, MS, CS_out, Dout

    );
    input CLK, Go, next;
    input[2:0] MS;
    input[15:0] Din;
    output reg[3:0] CS_out;
    output reg[15:0] Dout;
    
    wire Done_out, WE;
    wire[2:0] MS_out;
    wire[2:0] W1, num_R1, num_R2;
    
    FSM U0(CLK, Go, next, MS, MS_out, CS_out, Done_out, num_R1, num_R2, W1, WE);
    Datapath U1(CLK, Din, num_R1, num_R2, WE, W1, MS, Dout);
    
endmodule
