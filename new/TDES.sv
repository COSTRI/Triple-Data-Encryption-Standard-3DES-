`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.06.2026 17:52:24
// Design Name: 
// Module Name: TDES
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TDES(
    input logic clk,
    input logic des_start,
    input logic rst,
    
    input logic [191:0] key,
    input logic [63:0]  DESin,
    
    output logic tdes_done,
    output logic [63:0] TDEScipher
    );
    
    logic         loadDES,doneDES,selDES;
    logic [1:0]   blockCount;           
    logic        roundDone, busy;       
    logic [63:0]  DESout;      
    
    
    
    
    DES_TOP CORE (
        .clk(clk),
        .des_start(des_start),
        .rst(rst),
        .key(key),
        .DESin(DESin),
        .tdes_done(tdes_done),
        .TDEScipher (TDEScipher),
        
        .loadDES(loadDES),
        .doneDES(doneDES),
        .selDES(selDES),
        .blockCount(blockCount),
        .roundDone (roundDone),
        .busy (busy),
        .DESout (DESout)
    );
endmodule
