module CRS(
    input logic [27:0] a,
    input logic [1:0] shiftAmt,
    output logic [27:0] y
);
    assign y = (a >> shiftAmt) | (a << (28 - shiftAmt));
endmodule