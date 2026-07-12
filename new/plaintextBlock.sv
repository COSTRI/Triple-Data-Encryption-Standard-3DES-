`timescale 1ns / 1ps


module plaintextBlock(
    input logic clk,rst,selReg,loadPt, 
    input logic [31:0] PermOut,
    input logic [63:0] DESin,
    output logic [63:0] DESout,
    output logic [31:0] RregOut
);
    
    logic [31:0] RregOutInternal;
    logic [63:0] IPout, swapOut;
    logic [31:0] LregIn,RregIn,LregOut, NrReg,Lswap,Rswap;
    assign swapOut = {RregOutInternal,LregOut};
    assign NrReg = LregOut ^ PermOut;
    assign RregOut = RregOutInternal;
   
    
    initialPermutation IP(
        .in(DESin),
        .out(IPout)
    );
    
    selLreg selLreg(
        .a(IPout[63:32]),
        .b(RregOutInternal),
        .selL(selReg),
        .y(LregIn)
    );
    
    selRreg selRreg(
        .a(IPout[31:0]),
        .b(NrReg),
        .selR(selReg),
        .y(RregIn)
    );
    
    register3232 Lreg(
        .rst,
        .clk,
        .load(loadPt),
        .D(LregIn),
        .Q(LregOut)
    );
    
    register3232 Rreg(
        .rst,
        .clk,
        .load(loadPt),
        .D(RregIn),
        .Q(RregOutInternal)  
    );
    
     inverseIP Inverse(
        .in(swapOut),
        .out(DESout)
    );
    
endmodule