class transaction;
    parameter width = 12;
    logic signed [width-1:0] R,I;
    logic signed [width-1:0] R_out;
    logic signed [width-1:0] I_out;
    logic rst_n, done;
endclass //transaction;