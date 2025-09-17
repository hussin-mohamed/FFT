module stage4 #(
    parameter width = 12
) (
    input signed [width-1:0] line1,line2,
    output signed [width-1:0] line1_4,line2_4
);
    butterfly #(
        .width(width),
        .stage("stage4")
    ) b1 (
        .a(line1),
        .b(line2),
        .sum(line1_4),
        .difference(line2_4)
    );
endmodule