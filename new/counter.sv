module counter(
    input  logic        clk, rst, load,
    output logic [4:0]  roundCount,
    output logic        roundDone
);

    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            roundCount <= 5'd0;
        end
        else if (load) begin
            if (roundCount == 5'd17)
                 roundCount <= 5'd1;
            else
            roundCount <= roundCount + 1'b1;
            end
        end

    assign roundDone = load && (roundCount == 5'd16); // fires on last round of cycle

endmodule