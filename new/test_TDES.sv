`timescale 1ns / 1ps

// Create Date: 05.06.2026 18:05:18
// Design Name: 
// Module Name: test_TDES


module test_TDES;
    logic clk;
    logic des_start;
    logic rst;
                       
    logic [191:0] key;
    logic [63:0]  DESin;
                             
    logic tdes_done;
    logic [63:0] TDEScipher;
    
    
    TDES DUT(
    .clk (clk),         
    .rst (rst),         
    .des_start (des_start),   
    .key (key),         
    .DESin (DESin),       
    .tdes_done(tdes_done),   
    .TDEScipher (TDEScipher) 
     );
     
      initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

   
    initial begin
   rst        = 1;
   des_start  = 0;  
    key        = 192'h0f1571c947d9e8590f1571c947d9e8590f1571c947d9e859;
    DESin      = 64'h02468aceeca86420;
    tdes_done   = 0; 
                                       
   #15 rst = 0;  
   
    $display("");
     $display("key[%h] \n DESin[%h]",key, DESin);
        des_start = 1;
        @(posedge clk);
        des_start = 0;
        #12;
      
     fork
            begin
                wait(DUT.blockCount == 2'd1 && DUT.doneDES);
                $display ("Selected Key [%h] ",DUT.CORE.DESdatapath.KeyEncryption.key);
                $display("Time %t: FIRST BLOCK (K1) DONE. Switching to K2 (Decryption).", $time);
                
            end
            
            begin
                wait(DUT.blockCount == 2'd0&& DUT.doneDES);
                $display ("Selected Key [%h] ",DUT.CORE.DESdatapath.KeyDecryption.deKey);
                $display("Time %t: SECOND BLOCK (K2) DONE. Switching to K3 (Encryption).", $time);
            end
            
            
             begin
                wait(DUT.blockCount == 2'd3 && DUT.doneDES);
                $display("TDES out:   %h", TDEScipher);
                $display("Time %t: ALL 48 ROUNDS COMPLETE.", $time); 
                
                 $display("Simulation Finished.");
                 $finish;    
            end
            
            begin
             wait (tdes_done);
            end
        join
      
        
    end                      
endmodule
