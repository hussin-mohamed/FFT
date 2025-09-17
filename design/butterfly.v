module butterfly #(
    parameter width = 12,
    parameter stage = "stage1"
) (
    input signed [width-1:0]a,b,output reg signed [width-1:0] sum,difference
    );
    wire signed [width:0] s,diff;
    reg signed [width:0] shrs,shrd,rounds,roundd;
    reg rs,rd,ls,ld;
    assign s = a + b;
    assign diff = a - b;
    always @(*) begin
        case (stage)
            "stage1","stage3": begin
                shrs=s>>>1; // Arithmetic right shift by 1 
                shrd=diff>>>1; // Arithmetic right shift by 1 
                // there was no time to cover the nearest rounding so I used the flooring
                // rs=s[0]; // Rounding bit for sum
                // rd=diff[0]; // Rounding bit for difference
                // ls=shrs[0];
                // ld=shrd[0];
                // rounds=shrs + (rs&ls); // Rounding for sum
                // roundd=shrd + (rd&ld); // Rounding for difference
                // sum = rounds[width-1:0]; // Assign the rounded sum to output
                // difference = roundd[width-1:0]; // Assign the rounded difference to
                sum = shrs[width-1:0]; 
                difference = shrd[width-1:0];
            end
            "stage2","stage4": begin
                sum = s[width-1:0]; 
                difference = diff[width-1:0]; 
            end
            default: begin
                sum = 0;
                difference = 0;
            end
        endcase
    end
endmodule