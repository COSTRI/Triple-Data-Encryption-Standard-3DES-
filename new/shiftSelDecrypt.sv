`timescale 1ns / 1ps


module shiftSelDecrypt(
     input logic  Q4,Q3,Q2,Q1,Q0,
     output [1:0] y
    );
 
    logic shift0, shift1;
    
     // round 1 -> no shift
    assign shift0 =
           (~Q4 & ~Q3 & ~Q2 & ~Q1 &  Q0); // 0001 -16

    // rounds 2,9,16 -> shift by 1
    assign shift1 =
           (~Q4 & ~Q3 & ~Q2 &  Q1 & ~Q0)  // 0010 = 2 -15
         | (~Q4 & Q3 & ~Q2 & ~Q1 &  Q0)  // 1001 = 9-8
         | (Q4 & ~Q3 & ~Q2 & ~Q1 & ~Q0); // 10000 = 16-1
    
    
    // shift 0: count 31 (011111)
    // shift 1: count 23 (010111), count 16 (010000), count 30 (011110)
    
    
//    assign shift0 = ((~Q5)&(Q4)&(Q3)&(Q2)&(Q1)&(Q0)); // count 31 - round 16_1
    
//    assign shift1 = ((~Q5)&(Q4)&(~Q3)&(Q2)&(Q1)&(Q0))      // count 23 - round 8_9
//                   |((~Q5)&(Q4)&(~Q3)&(~Q2)&(~Q1)&(~Q0))  // count 16 - round 1_16
//                   |((~Q5)&(Q4)&(Q3)&(Q2)&(Q1)&(~Q0));  // count 30 - round 2_15
    
    assign y =  (shift0) ? 2'b00 
                :(shift1 ? 2'b01
                : 2'b10);
     
       
   
endmodule
