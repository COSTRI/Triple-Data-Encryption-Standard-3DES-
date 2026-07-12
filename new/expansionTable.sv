`timescale 1ns / 1ps


module expansionTable(
    input logic [31:0] in,    
    output logic [47:0] out  
    );
    
    const int E_TABLE[48] = '{
        32, 1, 2, 3, 4, 5,
        4, 5, 6, 7, 8, 9,
        8, 9, 10, 11, 12, 13,
        12, 13, 14, 15, 16, 17,
        16, 17, 18, 19, 20, 21,
        20, 21, 22, 23, 24, 25,
        24, 25, 26, 27, 28, 29,
        28, 29, 30, 31, 32, 1
    };

    // Perform the expansion
    always_comb begin
        for (int i = 0; i < 48; i++) begin
            out[47 - i] = in[32 - E_TABLE[i]]; 
        end
    end
endmodule
