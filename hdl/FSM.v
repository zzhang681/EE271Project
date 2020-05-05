
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module FSM(CLK, clear, next, MS, MS_out, LEDsel, Done_out, W1, WE
    

    );
    input CLK, clear, next;        //next: only when next == 1, some state will go to their next state
                                //[clear] is copied from the github file, I dont know how to use it specifically, kinda start button
    input[2:0] MS;              //the mode we use for calculating
    output reg[1:0] LEDsel;     //for LED_MUX2
    //output reg[2:0] num_R1, num_R2;     //pass to register file
    output reg W1;
    output reg[3:0] MS_out;                 //MS_out will be passed to ALU file
    output reg WE, Done_out;                //write enable for register and done signal for S11
                               
    reg[2:0] CS, NS;                    //current state & next state
    parameter   Idle1 = 3'b000,         //s0
                Input1 = 3'b001,        //s1, input input1hao
                Idle2 = 3'b010,
                Input2 = 3'b011,        //s3, input input2
                calculation = 3'b100;   //s5
    parameter   done = 3'b101;
                

                
    always@(posedge CLK) CS = NS;
    
    always@(CS) begin
        case(CS)
            Idle1: begin            // Idle1 is initial state which is wating for input_1
                WE = 0;             //we wont receive any data from input when WE = 0
                MS_out = 4'b0000;    //MS initial state
                W1 = 0;             //W1 initial state
                Done_out = 0;       //?
                LEDsel = 2'b00;     //LED shows din in LED0 and LED1
                NS = Idle1;
                end
                
            Input1: begin
                WE = 1;             //allow register to write Din into RF
                MS_out = 4'b0000;
                W1 = 0;             //RF[0] <- Din (write Din into RF[0]
                Done_out = 0;
                NS = Idle2;
            end
            
            Idle2: begin            // waiting for input_2
                WE = 0;             //allow register to write Din into RF
                MS_out = 4'b0000;
                W1 = 1;             //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 0;
                LEDsel = 2'b00;     //LED shows din in LED0 and LED1
                NS = Idle2;
            end

            Input2: begin
                WE = 1;             //allow register to write Din into RF
                MS_out = 4'b0000;
                W1 = 1;             //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 0;
                LEDsel = 2'b01;     //LED shows MS on LED0
                NS = calculation;
            end

            calculation: begin
                WE = 0;             // don't care
                MS_out = MS;        //BCD
                W1 = 1;             // don't care
                Done_out = 0;
                NS = calculation;
            end
            
            done: begin
                WE = 0;             // don't care
                MS_out = MS;        //BCD
                W1 = 1;             // don't care
                Done_out = 0;
                LEDsel = 2'b10;     //LED shows 4-digit result on 4 LEDs
                NS = done;
            end
                   
            default: begin
                WE = 0;             
                MS_out = 4'b0000;
                W1 = 0;             
                Done_out = 0;
                NS = Idle1;
            end

            
        endcase
    end   

    always@(posedge next) begin
        //NS = Idle;
        case (CS)
        
            Idle1: begin 
                NS = Input1;
                end
                
            Idle2: begin
                NS = Input2;
                end
            
            calculation: begin
                NS = done;
                end
                
            done: begin
                NS = Idle1;
                end

            default: begin
                NS = Idle1;
                end
                
            endcase
    end

    always@(posedge clear)
    begin
        CS = Idle1;
    end
    
    
    
endmodule