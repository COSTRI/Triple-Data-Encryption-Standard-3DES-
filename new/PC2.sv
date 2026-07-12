`timescale 1ns / 1ps
module PC2(
input logic [55:0] in,
    output logic [47:0] out
    );
    
    const int P2_TABLE[48] = '{
       14,17,11,24,1,5,3,28,  
       15,6,21,10,23,19,12,4,
       26,8,16,7,27,20,13,2, 
       41,52,31,37,47,55,30,40,
       51,45,33,48,44,49,39,56,
       34,53,46,42,50,36,29,32
    };
    always_comb begin
        for (int i = 0; i < 48; i++) begin
           //out[i] = in[P2_TABLE[i] - 1];
           out[47 - i] = in[56 - P2_TABLE[i]];
        end
     end
endmodule
