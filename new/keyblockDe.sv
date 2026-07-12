`timescale 1ns / 1ps


module keyblockDe(
    input logic clk, rst,loadKey,
    input logic [63:0] deKey,
    input logic [4:0]  roundCount,
    input logic selKey,
    output logic[47:0] PC2regOut
    );
    logic [1:0]  shiftAmt;
    
    logic [55:0] PCMux0,shiftOut,selOUT;
    logic [27:0] Cregout, DregOut, CshiftOut, DshiftOut;
    assign shiftOut = {CshiftOut, DshiftOut};
    
    
   PC1 PC1(
        .in(deKey),
        .out(PCMux0)
    );
    
    register28 Creg(
        .clk,
        .rst,
        .load(loadKey),
        .D(selOUT[55:28]),
        .Q(Cregout)
    );
    
    register28 Dreg(
        .clk,
        .rst,
        .load(loadKey),
        .D(selOUT[27:0]),
        .Q(DregOut)
    );

    PC2 PC2(
        .in(shiftOut),
        .out(PC2regOut)
    );
    
    MUX CD(
        .a(PCMux0),
        .b(shiftOut),
        .selKey,
        .y(selOUT)
    );
    shiftSelDecrypt  shiftSch(
        .Q4(roundCount[4]),
        .Q3(roundCount[3]),
        .Q2(roundCount[2]),
        .Q1(roundCount[1]),
        .Q0(roundCount[0]),
        .y(shiftAmt)
        
    );
    
    CRS CregShift(
         .a(Cregout),
         .shiftAmt,
         .y(CshiftOut)     
    );
    
    CRS DregShift(
         .a(DregOut),     
         .shiftAmt,
         .y (DshiftOut)    
    );


endmodule
