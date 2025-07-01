// Code your testbench here
// or browse Examples
module multiplier_tb;
parameter m=8, n=8;
reg clk, rst;
reg [m-1:0] D;
reg [n-1:0] Q;
wire [m+n-1:0] out;

MULTIPLIER multiplier(clk, rst, D, Q, out);

initial 
begin
  $dumpfile("tb.vcd");
  $dumpvars(0,multiplier_tb);
    clk = 1'b1;
    forever #5 clk = ~clk;
end
initial
begin

    rst = 1;
    #20;
    rst = 0;
    D = 8'b11111111;
    Q = 8'b11111111;
    #2000;
    rst = 1;
    #20;
    rst = 0;
    D = 8'b00011111;
    Q = 8'b00011111;
    #2000;
    rst = 1;
    #20;
    rst = 0;
    D = 8'b00000001;
    Q = 8'b00000001;
    #2000;
  	$finish;
end
endmodule