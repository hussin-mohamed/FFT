interface fft_interface;
    parameter width = 12 ;
    logic signed[width-1:0] R;
    logic signed[width-1:0] I;
    logic signed[width-1:0] R_out;
    logic signed[width-1:0] I_out;
    logic rst_n, done;
    bit clk;
    modport Dut (
        input clk, rst_n,R,I,
        output R_out, I_out, done
    );
endinterface //alsu_interface