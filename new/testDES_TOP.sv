`timescale 1ns / 1ps


module testDES_TOP;
     logic        clk,
                  rst,
                  start;
     logic [191:0] key;             
     logic [63:0] DESin; 
     logic [63:0] TDEScipher;
     logic [1:0]   blockCount;
     logic        roundDone;
     
     //int ok, ok1;
     
     DES_TOP DUT(
         .clk,
         .rst,
         .start(start), 
         .key,
         .DESin,
         .roundDone,
         .blockCount,
         .TDEScipher   
     ); 
     
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

   
    initial begin
   rst        = 1;
    start      = 0;  
    key        = 192'h0f1571c947d9e8590f1571c947d9e8590f1571c947d9e859;
  //  key        = 64'h0f1571c947d9e859; 
  //  DESin      = 64'hda02ce3a89ecac3b; 
    DESin      = 64'h02468aceeca86420;                  
//    ok         = randomize(key); 
//    ok1        = randomize(DESin); 
                                       
   #15 rst = 0;                       
//    #10;   
    
    //@(posedge DUT.DEScontroller.start); 
     $display("");
     $display("key[%h] \n DESin[%h]",key, DESin);
        start = 1;
        @(posedge clk);
        start = 0;
        #12;
    
    fork
            begin
                wait(blockCount == 2'd1 && DUT.doneDES);
                $display ("Selected Key [%h] ",DUT.DESdatapath.KeyEncryption.key);
                $display("Time %t: FIRST BLOCK (K1) DONE. Switching to K2 (Decryption).", $time);
                
            end
            
            begin
                wait(blockCount == 2'd0&& DUT.doneDES);
                $display ("Selected Key [%h] ",DUT.DESdatapath.KeyDecryption.deKey);
                $display("Time %t: SECOND BLOCK (K2) DONE. Switching to K3 (Encryption).", $time);
            end
            
            
             begin
                wait(blockCount == 2'd3 && DUT.doneDES);
                $display("TDES out:   %h", TDEScipher);
                $display("Time %t: ALL 48 ROUNDS COMPLETE.", $time); 
                
                 $display("Simulation Finished.");
                 $finish;    
            end
        join
      
        
    end
    // --- Monitoring ---
    initial begin
        $monitor("Time: %t | Round: %d |ShiftAmtfor Encryption:[%d]| ShiftAmtfor Decryption: [%d]| PC2regOut: %h |  DESout: %h", 
                 $time, DUT.DESdatapath.KeyEncryption.roundCount, DUT.DESdatapath.KeyEncryption.shiftAmt,DUT.DESdatapath.KeyDecryption.shiftAmt, DUT.DESdatapath.roundKey,DUT.DESout);
        
//     @(posedge DUT.doneDES );
//     $display("TDES out:   %h", TDEScipher);
//     $display("Time %t: ALL 48 ROUNDS COMPLETE.", $time);
      end
                                                         
endmodule

    