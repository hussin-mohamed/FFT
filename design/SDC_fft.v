module SDC_fft #(
    parameter width = 12
) (
    input clk, rst_n,
    input signed[width-1:0] R,I,
    output signed[width-1:0] R_out, I_out,
    output done
);
    reg [4:0] count;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end
        else if(count!=27 ) begin
            count <= count + 1;
        end
        else begin
            count <= count;
        end
    end
    assign done = count[4]&count[3]&~count[2]&count[1]&count[0];
    wire sel_1,sel_2,sel_3,sel_4;
    control_unit cu (
        .clk(clk),
        .rst_n(rst_n),
        .sel_1(sel_1),
        .sel_4(sel_4),
        .sel_2(sel_2),
        .sel_3(sel_3)
    );
    wire signed [width-1:0] line1,line2;
    wire signed [width-1:0] line1_0,line2_0;
    wire signed [width-1:0] line1_1,line2_1;
    wire signed [width-1:0] line1_2,line2_2;
    wire signed [width-1:0] line1_3,line2_3;
    wire signed [width-1:0] line1_4,line2_4;
    input_phase #(
        .width(width)
    ) ip (
        .R(R),
        .I(I),
        .clk(clk),
        .rst_n(rst_n),
        .sel_1(sel_1),
        .line1_reg(line1),
        .line2(line2)
    );
    stage0 #(
        .width(width)
    ) s0 (
        .clk(clk),
        .rst_n(rst_n),
        .sel_4(sel_4),
        .line1(line1),
        .line2(line2),
        .line1_0(line1_0),
        .line2_0(line2_0)
    );
    stage1 #(
        .width(width),
        .buffer_size(4)
    ) s1 (
        .clk(clk),
        .rst_n(rst_n),
        .sel_1(sel_1),
        .sel_3(sel_3),
        .line1(line1_0),
        .line2(line2_0),
        .line1_1(line1_1),
        .line2_1(line2_1)
    );
    stage2 #(
        .width(width),
        .buffer_size(2)
    ) s2 (
        .clk(clk),
        .rst_n(rst_n),
        .sel_2(sel_2),
        .sel_1(sel_1),
        .line1(line1_1),
        .line2(line2_1),
        .line1_2(line1_2),
        .line2_2(line2_2)
    );
    stage3 #(
        .width(width),
        .buffer_size(8)
    ) s3 (
        .clk(clk),
        .rst_n(rst_n),
        .sel_1(sel_1),
        .sel_3(sel_4),
        .line1_2(line1_2),
        .line2_2(line2_2),
        .line1_3(line1_3),
        .line2_3(line2_3)
    );
    stage4 #(
        .width(width)
    ) s4 (
        .line1(line1_3),
        .line2(line2_3),
        .line1_4(line1_4),
        .line2_4(line2_4)
    );
    output_phase #(
        .width(width)
    ) op (
        .clk(clk),
        .rst_n(rst_n),
        .sel_1(sel_1),
        .line1(line1_4),
        .line2(line2_4),
        .R_reg(R_out),
        .I(I_out)
    );
endmodule