module d_ff #(
    parameter width = 12,
    parameter reset_value = 0
) (
    input [width-1:0] a,input clk,rst_n,
    output reg [width-1:0] q,
    output [width-1:0]qbar
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 0; // Reset output to zero
        end else begin
            q <= a; // Example operation: addition
        end
    end
    assign qbar = ~q; // Complement of q
endmodule