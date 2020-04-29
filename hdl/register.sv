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

module register(CLK, W1, Din, WE, Dout_1, Dout_2
    
    );
    input CLK, WE;  //clk, write_enable_signal
    //input[2:0] num_R1, num_R2;  //Read command, read RF[specific position]
    input W1;  //reg # to write to, 0 or 1
    input[15:0] Din; //input data
    output reg[15:0] Dout_1, Dout_2; // two variable that we will calculate later
    
    reg[15:0] RF[1:0];  // 2D array, 2 registers with 16 bits for each (only two registers needed for this project for now)
    
    always@(posedge CLK) begin
        if(WE)      //WE=1, RF=0 - 8, which means we can store 8 data
        RF[W1] <= Din; // take in Din and write it to location W1 in RF
        
        Dout_1 <= RF[0];
        Dout_2 <= RF[1];

        // Dout_1 <= RF[num_R1];
        // Dout_2 <= RF[num_R2];
        
    end
    
endmodule
