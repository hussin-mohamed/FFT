module output_phase #(
    parameter width = 12 // Default width parameter
) (
    input signed [width-1:0] line1, line2,
    input clk, rst_n,sel_1,
    output signed [width-1:0]  I,
    output signed [width-1:0]  R_reg
);
    wire signed [width-1:0] line2_reg, R;
    d_ff #(
        .width(width),
        .reset_value(0)
    ) d1 (
        .a(line2), 
        .clk(clk),
        .rst_n(rst_n),
        .q(line2_reg)
    );
    mux2_1 #(
        .width(width)
    ) mux1 (
        .a(line1),
        .b(line2_reg),
        .sel(sel_1),
        .out(R)
    );
    mux2_1 #(
        .width(width)
    ) mux2 (
        .a(line2_reg),
        .b(line1),
        .sel(sel_1),
        .out(I)
    );
    d_ff #(
        .width(width),
        .reset_value(0)
    ) d2 (
        .a(R), 
        .clk(clk),
        .rst_n(rst_n),
        .q(R_reg)
    );
    
endmodule