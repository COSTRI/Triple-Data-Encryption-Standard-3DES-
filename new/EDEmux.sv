`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module EDEmux(
     input logic [47:0] a, b,
     input logic [1:0]selMode,
     output logic [47:0] y
    );
    
    assign y = 
               (selMode == 2'd2) ? a:
               (selMode == 2'd1) ? b:
               (selMode == 2'd0) ? a:
                 47'b0;
endmodule
