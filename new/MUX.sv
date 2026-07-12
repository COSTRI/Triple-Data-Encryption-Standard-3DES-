`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////


module MUX(
     input logic [55:0] a, b,
     input logic selKey,
     output logic [55:0] y
    );
    
    assign y = 
               (selKey == 1'b0) ? a: b;
endmodule
