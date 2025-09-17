module buffer #(
    parameter buffer_size = 8,
    parameter width = 12
) (
    input clk,rst_n,input signed [width-1:0] data_in,
    output signed [width-1:0] data_out
);  
    // Generate buffer instances
    // Each instance is a d_ff that holds the data
    // The buffer size determines how many d_ff instances are created
    // The data_out will be the last d_ff output in the chain
    // This is a simple buffer implementation that can be expanded or modified as needed
    wire signed [width-1:0] buffer_data[0:buffer_size-1];
    generate
        genvar i;
        for (i = 0; i < buffer_size; i = i + 1) begin : buffer_gen
            if (i==0) begin
                d_ff #(
                .width(width),
                .reset_value(0)
            ) dffi (
                .a(data_in),
                .clk(clk),
                .rst_n(rst_n),
                .q(buffer_data[i]),
                .qbar() // Not used, but included for completeness
            );
            end
            else if(i!= buffer_size-1)begin
            d_ff #(
                .width(width),
                .reset_value(0)
            ) dffi (
                .a(buffer_data[i-1]),
                .clk(clk),
                .rst_n(rst_n),
                .q(buffer_data[i]),
                .qbar() // Not used, but included for completeness
            );
            end else begin
                d_ff #(
                    .width(width),
                    .reset_value(0)
                ) dffo (
                    .a(buffer_data[i-1]),
                    .clk(clk),
                    .rst_n(rst_n),
                    .q(data_out),
                    .qbar() // Not used, but included for completeness
                );
            end
        end
    endgenerate
endmodule