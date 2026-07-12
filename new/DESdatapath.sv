`timescale 1ns / 1ps

module DESdatapath(
    input logic clk,rst, start,loadDES,doneDES,
    input logic          selDES,
    input logic  [191:0] key,
    input logic  [63:0]  DESin,
    output logic [4:0]   roundCount,
    input logic [1:0]    blockCount,
    output logic [63:0]  TDEScipher,DESout,
    output logic         roundDone
    );
    logic [47:0] PC2regOut,subKeyEncrypt, subKeyDecrypt,roundKey;
    logic [31:0] RregOut;
    logic [31:0] PermOut;
    logic [191:0] keySelection;
    logic [63:0] selectedKey; 
    logic [63:0] DESin_int, selectedDESin;  // internal DESin that switches between original and feedback
    
    register6464 DESinReg(
    .clk,
    .rst(start),
    .load(doneDES),    // capture at end of each block
    .D(DESout),
    .Q(DESin_int)        // feeds into plaintextBlock next block
   );
   
  assign selectedDESin = (blockCount == 2'd2) ? DESin : DESin_int;
    
    plaintextBlock Plaintext(
        .clk,
        .rst,
        .selReg(selDES),
        .loadPt(loadDES),        
        .PermOut,
        .RregOut,
        .DESin(selectedDESin),
        .DESout      //ch
    );
    
    
     keySelectMux selectKey
    (
     .a(key [63:0]),    
     .b(key[191:128]),   
     .selBlockKey(blockCount), 
     .y(selectedKey)  
               
    );
   
   
     keyblock  KeyEncryption(
        .clk,          
        .rst(start),          
        .selKey(selDES),         
        .loadKey(loadDES), 
        .key(selectedKey),
        .roundCount,
        .PC2regOut (subKeyEncrypt)        
    );
    
    keyblockDe  KeyDecryption(
        .clk,          
        .rst(start),          
        .selKey(selDES),         
        .loadKey(loadDES), 
        .deKey(key[127:64]),
        .roundCount,
        .PC2regOut(subKeyDecrypt)        
    );
    
    EDEmux EDEmux(
        .a(subKeyEncrypt),
        .b(subKeyDecrypt),
        .selMode(blockCount),
        .y(roundKey)
    );
    
    
    Mangler   Mangler(
        .clk, 
        .rst(start),
        .RregOut,
        .PC2regOut(roundKey),
        .PermOut
    );


   
    counter Counter
   (
    .clk,
    .rst (rst),                   
    //.rst(start),                   
    .load(loadDES),         
    .roundCount(roundCount),
    .roundDone
   );
   
   always_ff @(posedge clk)
   begin
    if(doneDES)
        TDEScipher <= DESout;
    else
        TDEScipher <= TDEScipher;
   end

endmodule
