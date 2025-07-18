module single_port_ram_tb;
  reg[7:0] data;
  reg[5:0] addr;
  reg clk;
  reg we;
  wire[7:0] q;
  single_port_ram inst(data,addr,clk,we,q);
  initial
    begin
      $dumpfile("ram.vcd");
      $dumpvars(0,single_port_ram_tb);
      clk=1;
      forever #5 clk=~clk;
    end
  initial
    begin
      data=8'h01;
      addr=5'd0;
      we=1'b1;
      #10;
      
      data=8'h02;
      addr=5'd1;
      we=1'b1;
      #10;
      
      data=8'h03;
      addr=5'd2;
      
      #10;
      
      data=8'h04;
      addr=5'd3;
      
      #10;
      data=8'h05;
      addr=5'd4;
      
      #10;
      we=0;
      addr=5'd0;
      
      #10;
      addr=5'd1;
      #10 addr=5'd2;
      $finish;
    end
endmodule