`timescale 1ns / 1ps

module DES_TOP(
    input logic         clk,
                        des_start,
                       // start,
                        rst,
                        
    input logic  [191:0] key,
    input logic  [63:0] DESin,
    
    output logic         loadDES,doneDES,selDES,
    output logic [1:0]   blockCount,
    output logic        roundDone,
                         tdes_done, busy,
                         
    output logic [63:0]  TDEScipher,DESout
    );
    logic [4:0] roundCount;
    logic       internal_start;
   // logic       start;
    
    DESdatapath DESdatapath(      
      .clk (clk), 
      .rst (rst),      
      .start (internal_start),       
      .loadDES(loadDES),    
      .selDES (selDES),
      .doneDES (doneDES ),
      .roundDone (roundDone),
      .roundCount (roundCount),
      .blockCount (blockCount),
      .key (key),       
      .DESin  (DESin ), 
      .DESout (DESout),    
      .TDEScipher (TDEScipher)    
    );
    
    DES_FSM DEScontroller(
    .clk (clk),       
    .start (internal_start),
    .des_start (des_start),
    .tdes_done (tdes_done),
    .rst       (rst      ),
    .busy      (busy     ),
    .loadDES   (loadDES  ),
    .selDES    (selDES   ),
    .blockCount(blockCount),
    .roundDone (roundDone),
    .doneDES    (doneDES   )
    );  
               
endmodule
