`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module register28(
    input logic [27:0] D,
    input logic load, clk, rst,
    output logic [27:0] Q
    );
    
    
    always_ff @ (posedge clk, posedge rst) begin
        
            if (rst)
                Q <= '0;
            else if (load)
                Q <= D ;
            end
endmodule
