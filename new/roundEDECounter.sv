`timescale 1ns / 1ps


module roundEDECounter(
      input  logic        clk, rst, load,
      output logic [5:0]  roundCount,
      output logic [1:0]  blockCount,
     // output logic [3:0]  localRound,
      output logic        firstRoundDone, secondRoundDone,finalRoundDone
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst)
            roundCount <= 6'd48;
        else if (load && roundCount > 6'd0)
            roundCount <= roundCount - 1'b1;
        else
            roundCount <= roundCount;
    end
    
    always_comb begin
        if (roundCount > 6'd32)
            blockCount = 2'b00;
            
        else if (roundCount > 6'd16) 
            blockCount = 2'b01;
            
        else
            blockCount = 2'b10;
    end
    

    assign firstRoundDone = (roundCount == 6'd32);
    assign secondRoundDone = (roundCount == 6'd16);
   // assign finalRoundDone = (roundCount == 6'd0);
    assign finalRoundDone = (roundCount == 6'd1);
  //  assign finalRoundDone = (load && roundCount == 6'd0); 
    
endmodule
