`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module ALU(Din1, Din2, MS, ALU_out

    );
    input[15:0] Din1, Din2; //in1, in2
    input[2:0] MS;      //8
    output reg[15:0] ALU_out;   //output
    
    always@(Din1, Din2, MS) begin
        case(MS)
            3'b001: ALU_out = Din1 + Din2;  //Add
            3'b010: ALU_out = Din1 - Din2;  //Sub
            3'b011: ALU_out = Din1 * Din2;  //Mul
            3'b100: ALU_out = Din1 / Din2;  //Divid
            3'b101: ALU_out = Din1 ^ Din2;  //XOR
            3'b110: ALU_out = Din1 % Din2;  //Module
            3'b111: ALU_out = Din1 & Din2;  //AND
            default: ALU_out = 0;
        endcase
    end
    
    
endmodule
