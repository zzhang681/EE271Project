`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//This is connected to CLK generator, I dont know why but it may work


module debounce(pb_debounced, pb, clk

    );
    input pb, clk;  
output pb_debounced; 
reg [7:0] shift; 
reg pb_debounced; 
always @ (posedge clk) 
begin 
 shift[6:0] <= shift[7:1]; shift[7] <= pb; 
 if (shift==4'b0000) pb_debounced <= 1'b0; 
 else pb_debounced <= 1'b1; 
end 
    
    
endmodule
