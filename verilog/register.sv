`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//                       16|<-Din
//                         |
//                 ------------------
//                 |               <|---CLK
//             3---|num_R1          |
//             3---|num_R2          |
//                 |        RF      |
//             1---|WE              |
//             3---|W1              |
//                 ------------------
//                     |16      |16 
//                     |        |
//                   Dout_1   Dout_2    (will pass to ALU)
//////////////////////////////////////////////////////////////////////////////////

module register(CLK, num_R1, num_R2, W1, Din, WE, Dout_1, Dout_2
    
    );
    input CLK, WE;  //clk, write_enable_signal
    input[2:0] num_R1, num_R2;  //Read command, read RF[specific position]
    input[2:0] W1;  //reg # to write to
    input[15:0] Din; //inout data
    output reg[15:0] Dout_1, Dout_2; // two variable that we will calculate later
    
    reg[15:0] RF[7:0];  // 2D array, 8 registers with 16 bits for each (only two registers needed for this project for now)
    
    always@(posedge CLK) begin
        if(WE)      //WE=1, RF=0 - 8, which means we can store 8 data
        RF[W1] <= Din;
        
        Dout_1 <= RF[num_R1];
        Dout_2 <= RF[num_R2];
        
    end
    
endmodule
