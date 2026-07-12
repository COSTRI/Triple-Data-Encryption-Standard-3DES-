`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module DESinMUX(
     input logic [63:0] a, b, c,
     input logic [1:0] selInput,
     output logic [63:0] y
    );
    
    assign y = 
               (selInput== 2'd2) ? a : 
               (selInput== 2'd1) ? b : 
               (selInput == 2'd0)? c :
                                       64'b0;                     
            //   (selBlockKey == 1'b1) ? b :
//               (selBlockKey == 2'b10) ? c :
//                                    d;
endmodule
