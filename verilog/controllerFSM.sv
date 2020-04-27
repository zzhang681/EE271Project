`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////


module FSM(CLK, Go, next, MS, MS_out, CS_out, Done_out, num_R1, num_R2, W1, WE
    

    );
    input CLK, Go, next;        //next: only when next == 1, some state will go to their next state
                                //Go is copied from the github file, I dont know how to use it specifically, kinda start button
    input[2:0] MS;              //the mode we use for calculating
    output reg[3:0] CS_out;     //for LED?
    output reg[2:0] num_R1, num_R2, W1;     //pass to register file
    output reg[2:0] MS_out;                 //MS_out will be passed to ALU file
    output reg WE, Done_out;                //write enable for register and done signal for S11
    
    reg[3:0] CS, NS;            //current state & next state
    parameter   Idle = 4'b0000,     //state0
                Input1 = 4'b0001,   //state1, input input1
                Input2 = 4'b0010,   //s2, input input2
                Wait = 4'b0011,     //s3, input MS
                Add = 4'b0100,      //s4
                Sub = 4'b0101,      //s5
                Mul = 4'b0110,      //s6
                XOR = 4'b0111,      //s7
                //s8
                //s9
                //s10
                Done = 4'b1011;     //s11, final state, press next to return to S0
                
    always@(posedge CLK) CS = NS;
    
    //this is output logic
    always@(CS) begin
        case(CS)
            Idle: begin             //all can be found in the FSMtable
                num_R1 = 3'b111;
                num_R2 = 3'b111;    //111 is like an initial state, just in case of any error
                WE = 0;             //we wont receive any data from input when WE = 0
                MS_out = 3'b000;        //MS initial state
                W1 = 3'b111;        //W1 initial state
                Done_out = 1'b1;    //?
                end
                
            Input1: begin
                num_R1 = 3'b000;    //Dout_1 <- RF[0] (Dout1 reads RF[0]
                num_R2 = 3'b111;
                WE = 1;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 3'b000;        //RF[0] <- Din (write Din into RF[0]
                Done_out = 1'b0;
            end
            
            Input2: begin
                num_R1 = 3'b000;    //Dout_1 <- RF[0] (Dout1 still read RF[0]
                num_R2 = 3'b001;    //Dout_2 <- RF[1] (Dout2 reads RF[1]
                WE = 1;             //allow register to write Din into RF
                MS_out = 3'b000;
                W1 = 3'b001;        //RF[1] <- Din (write Din into RF[1] (cuz now we are inputing input2
                Done_out = 1'b0;
            end
            
            Wait: begin             //in this state we input MS
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b000;
                W1 = 3'b010;   
                Done_out = 1'b0;
            end
            
            Add: begin
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b001;    //Add
                W1 = 3'b010;   
                Done_out = 1'b0;
            end
            
            Sub: begin
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b010;    //Sub
                W1 = 3'b010;   
                Done_out = 1'b0;
            end
            
            Mul: begin
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b011;    //Mul
                W1 = 3'b010;   
                Done_out = 1'b0;
            end
            
            XOR: begin
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b100;    //XOR
                W1 = 3'b010;   
                Done_out = 1'b0;
            end
            
            //
            ///////////////////////////////////////////////////////////
            //
            
            Done: begin
                num_R1 = 3'b000; 
                num_R2 = 3'b001;
                WE = 0;
                MS_out = 3'b000;    //XOR
                W1 = 3'b010;   
                Done_out = 1'b1;
            end
            
        endcase
    end   
    // this is next state logic
    always@(CS, Go, MS) begin
        NS = Idle;
        case (CS)
        
            Idle: begin
                if(!Go) NS = Idle;  //reset
                else NS = Input1;
                end
                
            Input1: begin
                if(!next) NS = Input1;
                else NS = Input2;
                end
                
            Input2: begin
                if(!next) NS = Input2;
                else NS = Wait;
                end
            
            Wait: begin
                if(!next) NS = Wait;
                else begin
                    case(MS)
                        3'b001: NS = Add;
                        3'b010: NS = Sub;
                        3'b011: NS = Mul;
                        3'b100: NS = XOR;
                        //
                        //
                        //
                        default: NS = Wait;
                    endcase
                end
                end
            
            Add: NS = Done;
            Sub: NS = Done;
            Mul: NS = Done;
            XOR: NS = Done;
            
            Done: begin
                if(!next) NS = Done;
                else NS = Idle;
                end
                
            endcase
    end
    
    
    
endmodule
