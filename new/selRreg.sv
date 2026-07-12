`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module selRreg(
     input logic [31:0] a, b,
     input logic selR,
     output logic [31:0] y
    );
    
    assign y = 
               (selR == 1'b0) ? a: b;
endmodule
