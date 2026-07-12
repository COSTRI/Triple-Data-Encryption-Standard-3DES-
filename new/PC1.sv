`timescale 1ns / 1ps


module PC1(
    input logic [63:0] in,
    output logic [55:0] out
    );
    
    const int PC1_TABLE[56] = '{
        57, 49, 41, 33, 25, 17, 9,  
        1, 58, 50, 42, 34, 26, 18,
        10, 2,59, 51, 43, 35, 27, 
        19, 11, 3,60, 52, 44, 36,
        63, 55, 47, 39, 31, 23, 15,
        7,  62, 54, 46, 38, 30, 22, 
        14, 6, 61, 53,45,37,29,
        21, 13, 5, 28, 20, 12, 4
    };
    always_comb begin
        for (int i = 0; i < 56; i++) begin
           out[55 - i] = in[64 - PC1_TABLE[i]];
           //out[i] = in[PC1_TABLE[i] - 1];
          // out[i] = in[64 - PC1_TABLE[i]];
        end
     end
endmodule
