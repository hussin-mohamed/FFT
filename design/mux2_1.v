module mux2_1 #(
    parameter width = 12
) (
    input [width-1:0] a, b,
    input sel,
    output [width-1:0] out
);
    assign out = sel ? b : a; // If sel is 1, output b; if 0, output a
endmodule