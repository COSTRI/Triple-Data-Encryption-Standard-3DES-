`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module keySelectMux(
     input logic [63:0] a, b,
     input logic [1:0] selBlockKey,
     output logic [63:0] y
    );
    
    assign y = 
               (selBlockKey == 2'd2) ? a : 
               (selBlockKey == 2'd0) ? b : 
                                       64'b0;                     
            //   (selBlockKey == 1'b1) ? b :
//               (selBlockKey == 2'b10) ? c :
//                                    d;
endmodule
