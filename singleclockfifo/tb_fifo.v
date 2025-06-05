module tb();
    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg[7:0] buf_in;
    wire[7:0] buf_out;
    wire buf_empty;
    wire buf_full;
    wire[7:0] fifo_counter;

    FIFO f1(clk,rst,buf_in,buf_out,wr_en,rd_en,buf_empty,buf_full,fifo_counter);

    initial clk=0;
    always #5 clk=~clk;
    integer i;

    initial
    begin
        $dumpfile("fifo.vcd");
        $dumpvars(0,tb);
        rst<=1;
        wr_en<=0;
        rd_en<=0;
        buf_in<=8'd0;
        #10;
        rst <= 0;

        // Write to FIFO
        for (i = 0; i < 10; i = i + 1) 
        begin
            @(posedge clk);
            wr_en <= 1;
            rd_en <= 0;
            buf_in<= i;
        end

        // Disable write
        @(posedge clk);
        wr_en <= 0;

        // Read from FIFO
        for (i = 0; i < 10; i = i + 1) begin
            @(posedge clk);
            rd_en <= 1;
        end

        // Disable read
        @(posedge clk);
        rd_en <= 0;

        #20;
        $finish;
    end

endmodule: tb