`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module testb();
  reg clk, clear, next;
  reg [2:0] MS;
  reg [15:0] Din;
  wire Done_out;
  wire [2:0] CS_out;
  wire [15:0] Alu_out;
  
  topLevel Test1 (clk, clear, next, MS, Din, Done_out, CS_out, Alu_out);
  
  always 
    #5 clk = ~clk;
  
  
  initial begin
    clear = 0;
    next = 0;
    clk = 0;
    #10 clear = 1;
    #50 clear = 0;

    // tying input_1 then press "next" button:
    #50 Din = 16'b0000000000000001;
    #10 next = 1;
    #50 next = 0;

    // tying input_2 then press "next" button:
    #50 Din = 16'b0000000000000011;
    #10 next = 1;
    #50 next = 0;

    #50 MS = 3'b001;
    #10 next = 1;
    #50 next = 0;			// 1 + 3 = 4


    // Next operation:
    #10 clear = 1;
    #50 clear = 0;

    // tying input_1 then press "next" button:
    #50 Din = 16'b0000000010000101;
    #10 next = 1;
    #50 next = 0;

    // tying input_2 then press "next" button:
    #50 Din = 16'b0000000000000100;
    #10 next = 1;
    #50 next = 0;

    #50 MS = 3'b011;
    #10 next = 1;
    #50 next = 0;			// 133 * 4 = 532


    #50 MS = 3'b010;
    #10 next = 1;
    #50 next = 0;			// 133 - 4 = 129







    #200 $finish;		

  end
  
  initial begin
    $monitor("clear = %b, next = %b, MS = %b, Din = %d, Done_out = %b, Alu_out = %b, Alu_out = %d @ %t", clear, next, MS, Din, Done_out, Alu_out, Alu_out, $time);
    $dumpfile("test.vcd");
    $dumpvars(0);
  end
endmodule