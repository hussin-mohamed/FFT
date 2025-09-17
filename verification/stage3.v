module stage3 #(
    parameter width = 12,
    parameter buffer_size = 8
) (
    input clk, rst_n,
    input signed [width-1:0] line1_2, line2_2,
    input sel_3,sel_1,
    output signed [width-1:0] line1_3, line2_3
);
    wire signed [width-1:0] line1_fly, line2_fly;
    wire signed [width-1:0] line1_fly_rot, line2_fly_rot;
    wire signed [width-1:0] line2_fly_rot_reg;
    wire signed [width-1:0] line1_not_reg;
    wire signed [width-1:0] c, s;
    reg [4:0]counter;
    reg enable;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
        end else if (counter !=17) begin
            counter <= counter + 1;
        end
    end
    always @(*) begin
        enable<=counter[4]&counter[0];
    end
    reg sel_3_reg;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sel_3_reg<=0;
        end
        else begin
            sel_3_reg<=sel_3;
        end
    end
    butterfly #(
        .width(width),
        .stage("stage3")
    ) b1 (
        .a(line1_2),
        .b(line2_2),
        .sum(line1_fly),
        .difference(line2_fly)
    );

    memc #(
        .stage("stage3"),
        .width(width)
    ) m1 (
        .clk(sel_1),
        .reset(rst_n),
        .mem_out(c),
        .enable(enable)
    );

    mems #(
        .stage("stage3"),
        .width(width)
    ) m2 (
        .clk(sel_1),
        .reset(rst_n),
        .mem_out(s),
        .enable(enable)
    );

    rotator #(
        .width(width)
    ) r1 (
        .line1(line1_fly),
        .line2(line2_fly),
        .c(c),
        .s(s),
        .sel_1(sel_1),
        .clk(clk),
        .rst_n(rst_n),
        .line1_out(line1_fly_rot),
        .line2_out(line2_fly_rot)
    );

    buffer #(
        .width(width)
    ) buf1 (
        .data_in(line2_fly_rot),
        .data_out(line2_fly_rot_reg),
        .clk(clk),
        .rst_n(rst_n)
    );

    mux2_1 #(
        .width(width)
    ) mux1 (
        .a(line1_fly_rot),
        .b(line2_fly_rot_reg),
        .sel(sel_3_reg),
        .out(line1_not_reg)
    );

    mux2_1 #(
        .width(width)
    ) mux2 (
        .a(line2_fly_rot_reg),
        .b(line1_fly_rot),
        .sel(sel_3_reg),
        .out(line2_3)
    );

    buffer #(
        .width(width)
    ) buf2 (
        .data_in(line1_not_reg),
        .data_out(line1_3),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule