module compmul_tb();
 reg [15:0]c1,c2;
 wire [31:0]product;
 complex_mul a(c1,c2,product);
 initial
 begin
    $dumpfile("tb.vcd");
    $dumpvars(0,compmul_tb);
 c1<=16'b0000001000000010;
 c2<=16'b0000011000000010;
 #50
 $display("output for mul %b",product);
 c1<=16'b00001111100001000;
 c2<=16'b00000000000010000;
 #50
 $display("output for mul %b",product);
 c1<=16'b0000101110001000;
 c2<=16'b0000000000001000;
 #50
 $display("output for mul %b",product);
 c1<=16'b0000100000001000;
 c2<=16'b0001111000001000;
 #50
 $display("output for mul %b",product);
 c1<=16'b0000100001101000;
 c2<=16'b0000001000001000;
 #50
 $display("output for mul %b",product);
 c1<=16'b0000100000001000;
 c2<=16'b0001111111101000;
 #50
 $display("output for mul %b",product);
 c1<=16'b1111111111111111;
 c2<=16'b1111111111111111;
 #50
 $display("output for mul %b",product);

 end
endmodule