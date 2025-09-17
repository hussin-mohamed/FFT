module stage0 #(
    parameter width = 12 // Default width parameter
) (
    input clk,rst_n,sel_4,
    input signed [width-1:0] line1,line2,
    output signed [width-1:0] line1_0,line2_0
);
    wire signed [width-1:0] line2_reg,line1_sel;
    buffer #(
        .width(width)
    ) b1 (
        .data_in(line2),
        .data_out(line2_reg),
        .clk(clk),
        .rst_n(rst_n)
    );
    mux2_1 #(
        .width(width)
    ) m1 (
        .a(line1),
        .b(line2_reg),
        .sel(sel_4),
        .out(line1_sel)
    );
    mux2_1 #(
        .width(width)
    ) m2 (
        .a(line2_reg),
        .b(line1),
        .sel(sel_4),
        .out(line2_0)
    );
    buffer #(
        .width(width)
    ) b2 (
        .data_in(line1_sel),
        .data_out(line1_0),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule