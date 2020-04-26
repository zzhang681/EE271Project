`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//


module register(CLK, num_R1, num_R2, W1, Din, WE, Dout_1, Dout_2
    
    );
    input CLK, WE;  //clk, write_enable_signal
    input[2:0] num_R1, num_R2;
    input[2:0] W1;  //reg # to write to
    input[15:0] Din;
    output reg[15:0] Dout_1, Dout_2;
    
    reg[15:0] RF[7:0];  //array, 8 registers and 16 bits
    
    always@(posedge CLK) begin
        if(WE)      //WE=1, RF=0 - 8, which means we can store 8 data
        RF[W1] <= Din;
        
        Dout_1 <= RF[num_R1];
        Dout_2 <= RF[num_R2];
        
    end
    
endmodule
