module rotator #(
    parameter width = 12,
    parameter stage = "stage1"
)(
    input signed [width-1:0] line1, line2,c,s,
    input sel_1,clk,rst_n,
    output signed [width-1:0] line1_out,
    output reg signed [width-1:0] line2_out
);
    wire signed [2*width-1:0] line2_c, line2_s,line2_s_reg,line2_s_s0,line2_s_s1,line2_s_s00, line2_s_s11,line2_s_s11_reg;
    d_ff #(
        .width(width),
        .reset_value(0)
    ) d1 (
        .a(line1), 
        .clk(clk),
        .rst_n(rst_n),
        .q(line1_out)
    );
    multiplier #(
        .width(width),
        .stage(stage)
    ) mc(
        .a(line2),
        .b(c),
        .product(line2_c)
    );
    multiplier #(
        .width(width),
        .stage(stage)
    ) ms(
        .a(line2),
        .b(s),
        .product(line2_s)
    );
    mux2_1 #(
        .width(2*width)
    ) mux1 (
        .b(line2_c),
        .a(line2_s),
        .sel(sel_1),
        .out(line2_s_s0)
    );
    mux2_1 #(
        .width(2*width)
    ) mux2 (
        .b(line2_s),
        .a(line2_c),
        .sel(sel_1),
        .out(line2_s_s1)
    );

    d_ff #(
        .width(2*width),
        .reset_value(0)
    ) d2 (
        .a(line2_s_s1), 
        .clk(clk),
        .rst_n(rst_n),
        .q(line2_s_reg)
    );
    mux2_1 #(
        .width(2*width)
    ) mux3 (
        .b(line2_s_reg),
        .a(line2_s_s0),
        .sel(sel_1),
        .out(line2_s_s00)
    );
    mux2_1 #(
        .width(2*width)
    ) mux4 (
        .b(line2_s_s0),
        .a(line2_s_reg),
        .sel(sel_1),
        .out(line2_s_s11)
    );
    d_ff #(
        .width(2*width),
        .reset_value(0)
    ) d3 (
        .a(line2_s_s11), 
        .clk(clk),
        .rst_n(rst_n),
        .q(line2_s_s11_reg)
    );
    // assign line2_out = sel_1 ? line2_s_s11_reg+line2_s_s00 : line2_s_s11_reg-line2_s_s00 ; // Output based on sel_1
    reg signed [2*width:0]s_ext,sht_ext;

    always @(*) begin
        case (stage)
           "stage1","stage2","stage3":begin
            if (sel_1) begin
                // s_ext=({line2_s_s11_reg,line2_s_s11_reg[0]})+({line2_s_s00[width-1],line2_s_s00});
                s_ext=line2_s_s11_reg+line2_s_s00;
                sht_ext=s_ext>>>10;
                line2_out=sht_ext[width-1:0];
            end
            else begin
                s_ext=line2_s_s11_reg-line2_s_s00;
                sht_ext=s_ext>>>10;
                line2_out=sht_ext[width-1:0];
            end
           end
            
        endcase
    end
endmodule