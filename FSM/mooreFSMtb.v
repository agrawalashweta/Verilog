module state_machine_moore_tb();
reg clk, reset, in;
wire out;
integer i;

state_machine_moore dut(clk, reset, in, out);
initial
begin
    $dumpfile("tb.vcd");
    $dumpvars(0,state_machine_moore_tb);
    forever #5 clk = ~clk;
end

initial begin
reset = 1'b1;
clk = 1'b0;
in = 0 ;
#6;
reset = 1'b0;

for (i = 0; i<10 ; i = i+1)
begin 
	@(negedge clk); #1;
in = $random;
if (out == 1'b1)
$display("PASS: Sequence 11 detected i = %d\n", i);
end
#50;
$finish;
end
endmodule