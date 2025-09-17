module multiplier #(
    parameter width = 12,
    parameter stage = "stage1"
) (
    input signed[width-1:0] a, b,
    output signed [width*2-1:0] product
);
    wire signed [width*2-1:0] p;
    assign product = a * b;
    // reg signed [width*2-1:0] t;
    // reg signed [width*2-1:0] rounded;
    // reg r;
    // reg s;
    // always @(*) begin
    //         t=p>>>10; // Shift left by 10 bits
    //          // Check if any of the lower 10 bits are set

    //         product = t [width-1:0]; // Take the lower 12 bits
    // end
endmodule