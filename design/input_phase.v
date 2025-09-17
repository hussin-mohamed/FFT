module input_phase #(
    parameter width = 12 // Default width parameter
) (
    input signed [width-1:0] R, I,
    input clk, rst_n,sel_1,
    output signed [width-1:0]  line2,
    output signed [width-1:0]  line1_reg
);
    wire signed [width-1:0] I_reg, line1;
    d_ff #(
        .width(width),
        .reset_value(0)
    ) d1 (
        .a(I), 
        .clk(clk),
        .rst_n(rst_n),
        .q(I_reg)
    );
    mux2_1 #(
        .width(width)
    ) mux1 (
        .a(R),
        .b(I_reg),
        .sel(sel_1),
        .out(line1)
    );
    mux2_1 #(
        .width(width)
    ) mux2 (
        .a(I_reg),
        .b(R),
        .sel(sel_1),
        .out(line2)
    );
    d_ff #(
        .width(width),
        .reset_value(0)
    ) d2 (
        .a(line1), 
        .clk(clk),
        .rst_n(rst_n),
        .q(line1_reg)
    );
    
endmodule