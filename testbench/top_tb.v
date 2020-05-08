`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module top_tb(

    );
    reg clk, clear, next, level;
	reg [2:0] MS;
	reg [3:0] Din;
	wire [3:0] EDL1;
	wire EDL2;
	wire [2:0] EDL3;
	wire EDL4;
	wire Done_out;
	wire[7:0] LED0, LED1, LED2, LED3;
	wire [7:0]HEX4;
	wire[15:0] ALUout_test;
    
    topLevel Ut(clk, clear, next, MS, Din, level,EDL1, EDL2, EDL3, EDL4,Done_out, LED0, LED1, LED2, LED3,HEX4);
    
    always begin
        clk = 1; #2;
        clk = 0; #2;
    end
    
    always@(MS, next, HEX4, Din)
        $display("MS = %b, HEX4 = %b, LED0 = %b, at %0t",MS , HEX4, LED0, $time);
        
    initial begin
        clear = 1; next = 1; Din = 2; level = 0; MS = 0;
        #10 level = 1; #10 Din = 0;
        #50 next = 0;
        #50 next = 1;
        #10 level = 0;
        
        #30 Din = 3;
        #40 level = 1; Din = 4;
        #50 next = 0; 
        #10 level = 0;
        #60 next = 1;
        
        #20 MS = 3'b001;
        #50 next = 0;
        #60 next = 1;
        
        #500 $finish();
    end
    
    
    
    
endmodule
