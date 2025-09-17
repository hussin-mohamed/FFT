class driver;
    transaction trans;
    virtual fft_interface fft_inter;
    event e;
    mailbox mbx;
    function new();
        mbx = new();
        trans=new();
    endfunction //new()
    task automatic drive_stimulus();
        forever begin
            @(negedge fft_inter.clk);
            recieving();
            fft_inter.R=trans.R;
            fft_inter.I=trans.I;
            fft_inter.rst_n=trans.rst_n;
        end
    endtask //automatic
    task automatic recieving();
        mbx.get(trans);
        ->e;
    endtask //automatic
endclass //driver