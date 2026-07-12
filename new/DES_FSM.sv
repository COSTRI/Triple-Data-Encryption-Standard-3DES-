`timescale 1ns / 1ps


module DES_FSM import mypac::*;(
    input logic       clk,
                      des_start,
                      
                      rst,
                      roundDone, 
    
    output logic [1:0] blockCount,          
    output logic      loadDES,
                      selDES,
                      doneDES,
                      start,
                      tdes_done,
                      busy
    );
    state_t ps, ns;
    
       always_ff @(posedge clk) begin : state_reg
    if (rst) begin
        ps         <= S5; 
        blockCount <= 2'd2;
    end else if (des_start) begin
        ps         <= S0; // Bug triggers here!
        blockCount <= 2'd2;
    end else begin
        ps <= ns;
        if (roundDone && blockCount != 2'd3)
            blockCount <= blockCount - 1'b1;
    end 
end

    
   always_comb begin: ns_logic
    case (ps) 

        S0: begin
        if (blockCount == 2'd1)
        ns = S2;
        else if (blockCount == 2'd0)
        ns = S3;
        else
        ns = S1;
        
        end
        
        S1: begin
        if ((blockCount == 2'd2 && roundDone))//(firstRoundDone)
        ns = S4;
        else
        ns = S1;
        end
        
        S2: begin
        if((blockCount == 2'd1 && roundDone))// (secondRoundDone)
        ns = S4;
        else
        ns = S2;
        end
        
        S3: begin
        if (blockCount == 2'd0 && roundDone)
        ns = S4;
        else
        ns = S3;
        end
        
         
        S4: begin 
        if (blockCount == 2'd1 | blockCount == 2'd0)
        ns = S0;
        else if (blockCount == 2'd3)
        ns = S5;
        end
        
        S5: begin
                if (des_start) 
                    ns = S0;
                else
                    ns = S5;
            end
        
 
        default: ns = S5;
        endcase
   end
   always_comb begin : out_logic

    case (ps)
  
   S0: begin
                {loadDES, selDES, doneDES, tdes_done} = 4'b1000;
                if (des_start)
                    start = 1'b1;
                else
                    start = 1'b0;
            end
    
    S1:      {start, loadDES, selDES,doneDES,tdes_done} = 5'b01100;
    S2:      {start, loadDES, selDES,doneDES,tdes_done} = 5'b01100;
    S3:      {start, loadDES, selDES,doneDES,tdes_done} = 5'b01100;
    S4:      {start, loadDES, selDES,doneDES,tdes_done} = 5'b00010;
    
    S5: begin
                {start, loadDES, selDES, doneDES} = 4'b0000;
                if (blockCount == 2'd3)
                    tdes_done = 1'b1;
                else
                    tdes_done = 1'b0;
            end
                                        
    default: {start, loadDES, selDES,doneDES,tdes_done} = 5'b00000;
    


    endcase
   end
 endmodule