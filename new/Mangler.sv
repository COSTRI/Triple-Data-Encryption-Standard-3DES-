`timescale 1ns / 1ps


module Mangler(
    input logic clk,rst,
    input logic [31:0] RregOut,
    input logic [47:0] PC2regOut,
    output logic [31:0] PermOut
);
    logic [3:0] s1,s2,s3,s4,s5,s6,s7,s8;
    logic [47:0] ExOut,XORout;
    logic [31:0] SboxOut;
    assign XORout = ExOut ^ PC2regOut;
    assign SboxOut = {s1,s2,s3,s4,s5,s6,s7,s8};
    
    expansionTable Etable(
       .in(RregOut),
       .out(ExOut) 
    );
    

    
    s_box #(.sboxNum(1))
        S1(
       .in(XORout[47:42]),
       .out(s1) 
    );
    s_box #(.sboxNum(2))
        S2(
       .in(XORout[41:36]),
       .out(s2) 
    );
    s_box #(.sboxNum(3))
        S3(
       .in(XORout[35:30]),
       .out(s3) 
    );
    s_box #(.sboxNum(4))
        S4(
       .in(XORout[29:24]),
       .out(s4) 
    );
    s_box #(.sboxNum(5))
        S5(
       .in(XORout[23:18]),
       .out(s5) 
    );
    s_box #(.sboxNum(6))
        S6(
       .in(XORout[17:12]),
       .out(s6) 
    );
    s_box #(.sboxNum(7))
        S7(
       .in(XORout[11:6]),
       .out(s7) 
    );
    s_box #(.sboxNum(8))
        S8(
       .in(XORout[5:0]),
       .out(s8) 
    );
    

    
    permutationTable Permutation(
       .in(SboxOut),
       .out(PermOut) 
    );
    

endmodule