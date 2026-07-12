`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module shiftSel16(
     input logic  Q4,Q3,Q2,Q1,Q0,
     output [1:0] y
    );
 
    
    logic shift1;
    assign shift1 = ((~Q3)&(~Q2)&(~Q0)) |((~Q2)&(~Q1)&(Q0));;
     // shift 1: count 15 (001111), count 7 (000111), count 0 (000000) 
//    assign shift1 = ( Q3 &  Q2 &  Q1 &  Q0)   // count 47 - round 16 
//                  | (~Q3 &  Q2 &  Q1 &  Q0)   // count 39 - round 9
//                  | (~Q3 & ~Q2 & ~Q1 & ~Q0) ; // count 32  - round 1

//                  | (~Q5 & ~Q4 &  Q3 &  Q2 &  Q1 &  Q0)   // count 15 - round 16 
//                  | (~Q5 & ~Q4 & ~Q3 &  Q2 &  Q1 &  Q0)   // count 7  - round 9
//                  | (~Q5 & ~Q4 & ~Q3 & ~Q2 & ~Q1 & ~Q0);  // count 0  - round 1

     assign y = shift1 ? 2'b01 : 2'b10;
       
endmodule

