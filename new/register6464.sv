`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////


module register6464(
    input logic [63:0] D,
    input logic load, clk, rst,
    output logic [63:0] Q
    );
    
    
    always_ff @ (posedge clk, posedge rst) begin
        
            if (rst)
                Q <= '0;
            else if (load)
                Q <= D ;
            end
endmodule
