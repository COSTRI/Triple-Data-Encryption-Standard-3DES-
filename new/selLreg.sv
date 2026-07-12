`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module selLreg(
     input logic [31:0] a, b,
     input logic selL,
     output logic [31:0] y
    );
    
    assign y = 
               (selL == 1'b0) ? a: b;
endmodule
