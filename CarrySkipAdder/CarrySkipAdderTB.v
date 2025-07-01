module carry_skip_16bit_tb;
wire [15:0] sum;
wire cout;
reg [15:0] a,b;
reg cin;
 
carry_skip16bit uut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
 
initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,carry_skip_16bit_tb);
     a=0; b=0; cin=0;
#10 a= 16'b0000000000000101; b=16'b000000000000101; cin=1'b1;
#10 a= 16'b0000000000011111; b=16'b000000000001100; cin=1'b0;
#10 a= 16'b0000000000011111; b=16'b000000000001100; cin=1'b0;
#10 a= 16'b1100011000011111; b=16'b000000110001100; cin=1'b1;
#10 a= 16'b1111111111111111; b=16'b000000000000000; cin=1'b1;
#10 a =16'b0000000000000001; b=16'b000000000000001; cin=1'b1;
#10 a =16'b0000000000000010; b=16'b000000000000010; cin=1'b1;
end
 
initial
$monitor("time= ", $time, "A=%b, B=&b, Cin=%b : Sum= %b, Cout=%cout",a,b,cin,sum,cout);
endmodule