`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module LED_MUX2(Din_7seg1, Din_7seg2, ALUout_7seg0, ALUout_7seg1, ALUout_7seg2, ALUout_7seg3, MS_7seg, 
    LED0, LED1, LED2, LED3,
    sel

    );
    input[7:0] Din_7seg1, Din_7seg2, ALUout_7seg0, ALUout_7seg1, ALUout_7seg2, ALUout_7seg3, MS_7seg;
    input[1:0] sel;
    output reg [7:0] LED0, LED1, LED2, LED3;     //4 LEDs
    
    always@(*)
    begin
        case(sel)
            2'b00: begin
                LED0 <= Din_7seg1;          //display Din
                LED1 <= Din_7seg2;
                LED2 <= 8'b00000000;
                LED3 <= 8'b00000000;
                end
            2'b01: begin
                LED0 <= MS_7seg;            //display MS
                LED1 <= 8'b00000000;
                LED2 <= 8'b00000000;
                LED3 <= 8'b00000000;
                end
            2'b10: begin
                LED0 <= ALUout_7seg0;       //display result
                LED1 <= ALUout_7seg1;
                LED2 <= ALUout_7seg2;
                LED3 <= ALUout_7seg3;
                end
            default: begin
                LED0 <= 8'b00000000;
                LED1 <= 8'b00000000;
                LED2 <= 8'b00000000;
                LED3 <= 8'b00000000;
                end
            endcase
        end
    
    
    
endmodule
