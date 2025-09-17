class generator;
    event e;
    parameter testcases=1605;
    mailbox mbx;
    transaction trans;
    static int file_real,file_imaginary;
    int read_real, read_imaginary;
    function new();
        mbx = new();
        trans = new();
        file_real =$fopen("/home/hhussien/FFT_project_16r2_sdc/verification/input_real.txt", "r");
        file_imaginary =$fopen("/home/hhussien/FFT_project_16r2_sdc/verification/input_imaginary.txt", "r");
        $display("%0d",file_real);
        $display("%0d",file_imaginary);
        if (file_real == 0 || file_imaginary == 0) begin
            $display("Error: Could not open input files.");
            $stop;
        end
    endfunction //new()
    task automatic generate_scenarios();
        for (int i = 1; i <= testcases; i++) begin
            trans.rst_n = (i < 5) ? 1'b0 : 1'b1;
            if (i > 4) begin
                // $display("EOF: %0d, %0d", $feof(file_real), $feof(file_imaginary));
                read_real=$fscanf(file_real, "%b\n", trans.R);
                read_imaginary=$fscanf(file_imaginary, "%b\n", trans.I);
                sending();
            end else begin
                trans.R = 12'b0;
                trans.I = 12'b0;
                sending(); // Moved inside else block for clarity
            end
        end
    endtask //automatic
    task automatic sending();
        mbx.put(trans);
        @(e); 
    endtask //automatic
endclass //generator