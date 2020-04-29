`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module FSM(CLK, clear, next, MS, MS_out, CS_out, Done_out, W1, WE
    

    );
    input CLK, clear, next;        //next: only when next == 1, some state will go to their next state
                                //[clear] is copied from the github file, I dont know how to use it specifically, kinda start button
    input[2:0] MS;              //the mode we use for calculating
    output reg[2:0] CS_out;     //for LED?
    //output reg[2:0] num_R1, num_R2;     //pass to register file
    output reg W1;
    output reg[2:0] MS_out;                 //MS_out will be passed to ALU file
    output reg WE, Done_out;                //write enable for register and done signal for S11
                                            // Only print out result when Done_out = 1
                                        
    reg[2:0] CS, NS;                    //current state & next state
    parameter   Idle1 = 3'b000,         //s0
                Input1 = 3'b001,        //s1, input input1
                Idle2 = 3'b010,
                Input2 = 3'b011,        //s3, input input2
                Idle3 = 3'b100,         //s4, input MS
                calculation = 3'b101;   //s5

                
    always@(posedge CLK) CS = NS;
    
    //this is output logic
    always@(CS) begin
        case(CS)
            Idle1: begin            // Idle1 is initial state which is wating for input_1
                WE = 0;             //we wont receive any data from input when WE = 0
                MS_out = 3'b000;    //MS initial state
                W1 = 0;             //W1 initial state
                Done_out = 0;       //?
                NS = Idle1;
                end
                
            Input1: begin
                WE = 1;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 0;             //RF[0] <- Din (write Din into RF[0]
                Done_out = 0;
                NS = Idle2;
            end
            
            Idle2: begin            // waiting for input_2
                WE = 0;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 1;             //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 0;
                NS = Idle2;
            end

            Input2: begin
                WE = 1;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 1;             //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 0;
                NS = Idle3;
            end

            Idle3: begin            // waiting for input_2
                WE = 0;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 1;             //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 0;
                NS = Idle3;
            end

            calculation: begin
                WE = 0;             // don't care
                MS_out = MS;    
                W1 = 0;             // don't care
                Done_out = 1;
                NS = calculation;
            end
            
            default: begin
                WE = 0;             
                MS_out = 3'b000;
                W1 = 0;             
                Done_out = 0;
                NS = Idle1;
            end

            // Intering to ALU from here: (Change need to be made!)

            // Wait: begin             //in this state we input MS
            //     WE = 0;
            //     MS_out = 3'b000;
            //     W1 = 3'b010;   
            //     Done_out = 1'b0;
            // end
            
            // Add: begin
            //     WE = 0;
            //     MS_out = 3'b001;    //Add
            //     W1 = 3'b010;   
            //     Done_out = 1'b0;
            // end
            
            // Sub: begin
            //     WE = 0;
            //     MS_out = 3'b010;    //Sub
            //     W1 = 3'b010;   
            //     Done_out = 1'b0;
            // end
            
            // Mul: begin
            //     WE = 0;
            //     MS_out = 3'b011;    //Mul
            //     W1 = 3'b010;   
            //     Done_out = 1'b0;
            // end
            
            // Xor: begin
            //     WE = 0;
            //     MS_out = 3'b100;    //XOR
            //     W1 = 3'b010;   
            //     Done_out = 1'b0;
            // end
            
            //
            ///////////////////////////////////////////////////////////
            //
            
            // Done: begin
            //     WE = 0;
            //     //MS_out = 3'b000;    
            //     W1 = 3'b010;   
            //     Done_out = 0;
            // end
            
        endcase
    end   



// this is next state logic
    always@(posedge next) begin
        //NS = Idle;
        case (CS)
        
            Idle1: begin 
                NS = Input1;
                end
                
            Idle2: begin
                NS = Input2;
                end
                
            Idle3: begin
                NS = calculation;
                end
            
            calculation: begin
                NS = calculation;
                end

            default: begin
                NS = Idle1;
                end
                
            endcase
    end

    always@(posedge clear)
    begin
        CS = Idel1;
    end
    
    
    
endmodule
