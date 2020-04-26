`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ALU(D1, D2, MS, ALU_out

    );
    input[15:0] D1, D2; //in1, in2
    input[2:0] MS;      //8
    output reg[15:0] ALU_out;   //output
    
    always@(D1, D2, MS) begin
        case(MS)
            3'b000: ALU_out = D1 + D2;  //Add
            3'b001: ALU_out = D1 - D2;  //Sub
            3'b010: ALU_out = D1 * D2;  //Mul
            3'b011: ALU_out = D1 ^ D2;  //XOR
            //3 more to add
            default: ALU_out = 0;
        endcase
    end
    
    
endmodule
