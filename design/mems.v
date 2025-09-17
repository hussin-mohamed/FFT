module mems#(
    parameter stage = "stage1",
    parameter width = 12
) (
    input clk,
    input reset,enable,
    output reg signed [width-1:0] mem_out
);
    reg [2:0] addr; // addr for memory access

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            addr <= 0; // Reset addr to zero
        end else if(enable) begin
            addr <= addr + 1; // Increment addr on each clock cycle
        end
    end

    always @(*) begin
        case (stage)
            "stage1": begin
                case (addr)
                    3'd0: mem_out = 12'b000000000000;
                    3'd1: mem_out = 12'b110100101011;
                    3'd2: mem_out = 12'b110000000000;
                    3'd3: mem_out = 12'b110100101011;
                    3'd4: mem_out = 12'b111001111000;
                    3'd5: mem_out = 12'b110001001101;
                    3'd6: mem_out = 12'b110001001101;
                    3'd7: mem_out = 12'b111001111000;
                    default: mem_out = 12'b000000000000;
                endcase
            end
            "stage2": begin
                case (addr)
                    3'd0: mem_out = 12'b000000000000;
                    3'd1: mem_out = 12'b110000000000;
                    3'd2: mem_out = 12'b000000000000;
                    3'd3: mem_out = 12'b110000000000;
                    default: mem_out = 12'b110100101011;
                endcase
            end
            "stage3": begin
                case (addr)
                    3'd0: mem_out = 12'b000000000000;
                    3'd1: mem_out = 12'b000000000000;
                    3'd2: mem_out = 12'b000000000000;
                    3'd3: mem_out = 12'b000000000000;
                    default: mem_out = 12'b110000000000;
                endcase
            end
            default: mem_out = 12'b000000000000;
        endcase
    end
endmodule