module stage2 #(
    parameter width = 12,
    parameter buffer_size = 2
) (
    input clk,rst_n,sel_2,sel_1,
    input signed [width-1:0] line1,line2,
    output signed [width-1:0] line1_2,line2_2
);
    wire signed [width-1:0] line1_fly,line2_fly;
    wire signed [width-1:0] line1_fly_rot,line2_fly_rot;
    wire signed [width-1:0] line2_fly_rot_reg;
    wire signed [width-1:0] line1_not_reg;
    reg enable;
    // reg enable_reg;
    wire signed [width-1:0] c,s;
    reg [3:0]counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
        end else if (counter !=14) begin
            counter <= counter + 1;
        end
    end
    always @(*) begin
        enable<=counter[3]&counter[2]&counter[1]&!counter[0];
        // enable <= &counter;
    end
    // always @(posedge clk or negedge rst_n) begin
    //     if (!rst_n) begin
    //         enable_reg<=0;
    //     end
    //     else begin
    //         enable_reg<=enable;
    //     end
    // end
    butterfly #(
        .width(width),
        .stage("stage2")
    ) b1 (
        .a(line1),
        .b(line2),
        .sum(line1_fly),
        .difference(line2_fly)
    );
    memc #(
        .stage("stage2"),
        .width(width)
    ) m1 (
        .clk(~sel_1),
        .reset(rst_n),
        .enable(enable),
        .mem_out(c)
    );
    mems #(
        .stage("stage2"),
        .width(width)
    ) m2 (
        .clk(~sel_1),
        .reset(rst_n),
        .enable(enable),
        .mem_out(s)
    );
    rotator #(
        .width(width),
        .stage("stage2")
    ) r1 (
        .line1(line1_fly),
        .line2(line2_fly),
        .c(c),
        .s(s),
        .sel_1(~sel_1),
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
        .b(line1_fly_rot),
        .a(line2_fly_rot_reg),
        .sel(sel_2),
        .out(line1_not_reg)
    );
    mux2_1 #(
        .width(width)
    ) mux2 (
        .b(line2_fly_rot_reg),
        .a(line1_fly_rot),
        .sel(sel_2),
        .out(line2_2)
    );
    buffer #(
        .width(width),
        .buffer_size(buffer_size)
    ) buf2 (
        .data_in(line1_not_reg),
        .data_out(line1_2),
        .clk(clk),
        .rst_n(rst_n)
    );
endmodule