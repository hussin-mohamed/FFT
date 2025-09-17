`include "transaction.sv"
`include "generator.sv"
`include "monitor.sv"
`include "driver.sv"
`include "scoreboard.sv"
class environment;
    virtual fft_interface fft_env_inter;
    generator g;
    driver d;
    monitor m;
    scoreboard s;
    transaction t;
    function new();
        g=new();
        d=new();
        m=new();
        s=new();
    endfunction //new()
    
    task automatic run_phase();
        d.fft_inter=fft_env_inter;
        m.fft_inter=fft_env_inter;
        d.mbx=g.mbx;
        d.e=g.e;
        m.mbx=s.mbx;
        $display("Simulation started.");
        fork
            g.generate_scenarios();
            d.drive_stimulus();
            m.sampling();
            s.checking();
        join_any
        //$display("correct cases=%0d wrong cases=%0d",s.crorret_test,s.wrong_test);
        $fclose(g.file_real);
        $fclose(g.file_imaginary);
        repeat(26)
        begin
            @(negedge fft_env_inter.clk);
        end
        $display("Simulation finished.");
        $display("correct cases=%0d wrong cases=%0d",s.crorret_test,s.wrong_test);
        $fclose(s.file_real);
        $fclose(s.file_imaginary);
        $finish;
    endtask //automatic
endclass //className