`timescale 1ns / 1ps 
 
 
 
 
module BCD(CLK, SW, LED, HEX0, HEX1

 
   ); 
 input CLK;
 input [3:0]SW; 
 output reg [3:0]LED;
  
 output reg [7:0]HEX0, HEX1;
 
 
 always @(SW)
   LED = SW;
  
 always @ (SW) 
  begin // BCD to 7-segment decoding 
    case (SW) // s0 - s6 are active low 
      4'b0000: HEX0 = 8'b11000000;    
		4'b0001: HEX0 = 8'b11111001;
      4'b0010: HEX0 = 8'b10100100;
      4'b0011: HEX0 = 8'b10110000;
      4'b0100: HEX0 = 8'b10011001;
      4'b0101: HEX0 = 8'b10010010;
      4'b0110: HEX0 = 8'b10000010;    
		4'b0111: HEX0 = 8'b11111000;
      4'b1000: HEX0 = 8'b10000000;  
		4'b1001: HEX0 = 8'b10010000;
     default:  HEX0 = 8'b11000000; 
   endcase
  end
    
  
  
   

  
endmodule 
