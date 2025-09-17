module control_unit (
    input clk,
    input rst_n,
    output sel_1,
    output reg sel_2,sel_3,sel_4
);
    reg [3:0]counter;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter<=0;
        end else begin
            counter<=counter+1;
        end
    end
    always @(posedge clk or negedge rst_n ) begin
        if (!rst_n) begin
            sel_4 <= 0;
            sel_3 <= 0;
            sel_2 <= 0;
        end
        else begin
            sel_4 <= counter[3]; // Select every 8 cycles
            sel_3 <= counter[2]; // Select every 4 cycles
            sel_2 <= counter[1]; // Select every 2 cycles 
        end
    end
    assign sel_1 = counter[0]; // Select every cycle
endmodule