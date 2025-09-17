class monitor;
    transaction trans;
    virtual fft_interface fft_inter;
    mailbox mbx;
    function new();
        mbx = new();
        trans=new();
    endfunction //new()
    task automatic sampling();
        forever begin
            @(posedge fft_inter.clk);
            #1;
            trans.R_out=fft_inter.R_out;
            trans.I_out=fft_inter.I_out;
            trans.done=fft_inter.done;
            trans.rst_n=fft_inter.rst_n;
            mbx.put(trans);
        end
    endtask //automatic
endclass //monitor