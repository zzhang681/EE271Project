`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
//                       16|<-Din
//                         |
//                 ------------------
//             1---|level          <|---CLK
//             3---|num_R1          |
//             3---|num_R2          |----Display output x2
//                 |        RF      |4
//             1---|WE              |
//             3---|W1              |
//                 ------------------
//                     |16      |16 
//                     |        |
//                   Dout_1   Dout_2    (will pass to ALU)
//////////////////////////////////////////////////////////////////////////////////

module register(CLK, W1, Din, WE, level, Dout_1, Dout_2, Dis_1, Dis_2
    
    );
    input CLK, WE;  //clk, write_enable_signal
    input level;    //level=0: 1 digit, level=1:10 digit
    //input[2:0] num_R1, num_R2;  //Read command, read RF[specific position]
    input W1;  //reg # to write to, 0 or 1
    input[3:0] Din; //input data from keypad
    reg[3:0] temp_value[1:0];
    output reg[15:0] Dout_1, Dout_2; // two variable that we will calculate later
    output reg[3:0] Dis_1, Dis_2;   //Dis1: 1 digit Dis2: 10 digit
    
    reg[15:0] RF[1:0];  // 2D array, 2 registers with 16 bits for each (only two registers needed for this project for now)
    
    always@(level, Din) begin
        case(level)
            1'b0: begin temp_value[0] <= Din; Dis_1 <= Din; end     //
            1'b1: begin temp_value[1] <= Din; Dis_2 <= Din; end
            default: temp_value[0] <= Din;
        endcase
    end
    
    always@(posedge CLK) begin
        if(WE)begin      //WE=1, RF=0 - 8, which means we can store 8 data
                RF[W1] <= temp_value[1]*10 + temp_value[0]; // take in Din and write it to location W1 in RF
        end
        
        Dout_1 <= RF[0];
        Dout_2 <= RF[1];
        
    end
    
endmodule