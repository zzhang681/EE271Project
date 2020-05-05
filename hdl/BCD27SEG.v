`timescale 1ns / 1ps


module BCD27SEG( number, LED

    );
    input [3:0] number;
    output reg [7:0] LED;
    always @ (number)
    begin // BCD to 7-segment decoding
     case (number) // s0 - s6 are active low
            4'b0000: LED = 8'b11000000;    
	       	4'b0001: LED = 8'b11111001;
            4'b0010: LED = 8'b10100100;
            4'b0011: LED = 8'b10110000;
            4'b0100: LED = 8'b10011001;
            4'b0101: LED = 8'b10010010;
            4'b0110: LED = 8'b10000010;    
		    4'b0111: LED = 8'b11111000;
            4'b1000: LED = 8'b10000000;  
		    4'b1001: LED = 8'b10010000;
     default:  LED = 8'b11000000; 
  endcase
end
    
    
    
endmodule
