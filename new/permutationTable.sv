`timescale 1ns / 1ps


module permutationTable(
    input logic [31:0] in,
    output logic [31:0] out  
    );
    
    const int P_TABLE[32] = '{
    16, 7,  20, 21, 29, 12, 28, 17,
    1,  15, 23, 26, 5,  18, 31, 10,
    2,  8,  24, 14, 32, 27, 3, 9,
    19, 13, 30, 6,  22, 11, 4, 25
};

    // Perform the expansion
    always_comb begin
        for (int i = 0; i < 32; i++) begin
            out[31 - i] = in[32 - P_TABLE[i]]; // -1 for zero-based index
        end
    end
endmodule
