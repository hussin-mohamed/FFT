module stage1 #(
    parameter width = 12,
    parameter buffer_size = 4
) (
    input clk,rst_n,sel_3,sel_1,
    input signed [width-1:0] line1,line2,
    output signed [width-1:0] line1_1,line2_1
);
    wire signed [width-1:0] line1_fly,line2_fly;
    wire signed [width-1:0] line1_fly_rot,line2_fly_rot;
    wire signed [width-1:0] line2_fly_rot_reg;
    wire signed [width-1:0] line1_not_reg;
    wire enable;
    wire signed [width-1:0] c,s;
    reg sel;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sel <= 0;
        end else begin
            sel <= sel_3;
        end
    end
    reg [3:0]counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
        end else if (counter !=11) begin
            counter <= counter + 1;
        end
    end
    assign enable = counter[3] & counter[1]; // Enable every 12 cycles
    butterfly #(
        .width(width),
        .stage("stage1")
    ) b1 (
        .a(line1),
        .b(line2),
        .sum(line1_fly),
        .difference(line2_fly)
    );
    memc #(
        .stage("stage1"),
        .width(width)
    ) m1 (
        .clk(sel_1),
        .reset(rst_n),
        .enable(enable),
        .mem_out(c)
    );
    mems #(
        .stage("stage1"),
        .width(width)
    ) m2 (
        .clk(sel_1),
        .reset(rst_n),
        .enable(enable),
        .mem_out(s)
    );
    rotator #(
        .width(width),
        .stage("stage1")
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
        .width(width),
        .buffer_size(buffer_size)
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
        .sel(sel),
        .out(line1_not_reg)
    );
    mux2_1 #(
        .width(width)
    ) mux2 (
        .a(line2_fly_rot_reg),
        .b(line1_fly_rot),
        .sel(sel),
        .out(line2_1)
    );
    buffer #(
        .width(width),
        .buffer_size(buffer_size)
    ) buf2 (
        .data_in(line1_not_reg),
        .data_out(line1_1),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule