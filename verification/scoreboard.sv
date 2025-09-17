class scoreboard;
    mailbox mbx;
    transaction trans;
    logic [11:0] golden_result_real;
    logic [11:0] golden_result_imaginary;  
    int file_imaginary;
    int file_real;  
    int read_real, read_imaginary;
    int crorret_test=0;
    int wrong_test=0;
    function new();
        mbx = new();
        trans=new();
        file_real =$fopen("output_real.txt", "r");
        file_imaginary =$fopen("output_imaginary.txt", "r");
    endfunction //new()
    task automatic checking();
    forever begin
            mbx.get(trans);
        if(!trans.rst_n)begin
            golden_result_real = 12'b0;
            golden_result_imaginary = 12'b0;
            gold_compare();
        end
        else begin
            if (trans.done) begin
                 // $display("EOF: %0d, %0d", $feof(file_real), $feof(file_imaginary));
                read_real=$fscanf(file_real, "%b\n", golden_result_real);
                read_imaginary=$fscanf(file_imaginary, "%b\n", golden_result_imaginary);
                gold_compare();
            end
        end
    end  
    endtask //automatic
    task automatic gold_compare();
        if (trans.R_out != golden_result_real || trans.I_out!= golden_result_imaginary) begin
                        $display("Test failed: Expected (%b + 1I* %b), got (%b + 1I* %b)", golden_result_real, golden_result_imaginary,trans.R_out,trans.I_out);
                        wrong_test++;
                    end
        else begin
                        $display("test passed");
                        crorret_test++;
        end
    endtask //automatic
endclass //scoreboard;