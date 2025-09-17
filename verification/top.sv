`include "environment.sv"
module top();
    environment env;
    string line;
    fft_interface fft_inter();
    SDC_fft dut(
        .clk(fft_inter.clk),
        .rst_n(fft_inter.rst_n),
        .R(fft_inter.R),
        .I(fft_inter.I),
        .R_out(fft_inter.R_out),
        .I_out(fft_inter.I_out),
        .done(fft_inter.done)
    );
    always #5 fft_inter.clk=~fft_inter.clk;
    int file_real, file_imaginary,r;
    initial begin
        fft_inter.clk=1;
        env = new();
        env.fft_env_inter = fft_inter;
        env.run_phase();
        $dumpvars(0,top);
        $dumpfile("top.vcd");
    end
    // initial begin
    //     file_real      = $fopen("/home/hhussien/FFT_project_16r2_sdc/verification/input_real.txt", "r");
    //     file_imaginary = $fopen("/home/hhussien/FFT_project_16r2_sdc/verification/input_imaginary.txt", "r");
    //     $display("%0d",file_real);
    //     $display("%0d",file_imaginary);
    //     if (file_real == 0 || file_imaginary == 0) begin
    //         $display("Error: Could not open input files.");
    //         $stop;
    //     end
    //     while (!$feof(file_real) && !$feof(file_imaginary)) begin
    //     r = $fgets(line, file_real);
    //     $display(r);
    //     $display("First line of input_real.txt: %s", line);
    //     end
    //     $finish();
    // end 
endmodule