module carry_look_ahead_16bit_tb;
reg [15:0] a,b;
reg cin;
wire [15:0] sum;
wire cout;
 
  look_ahead16bit uut(.a(a), .b(b),.cin(cin),.s(sum),.cout(cout));
 
initial begin
  $dumpfile("tb.vcd");
  $dumpvars(0,carry_look_ahead_16bit_tb);
  a=0; b=0; cin=0;
  #20 a=16'd2; b=16'd2; cin=1'd1;
  #20 a=16'd2; b=16'd3; cin=1'd1;
  #20 a=16'd18; b=16'd18; cin=1'd0;
  #20 a=16'd100; b=16'd0; cin=1'd1;
end
 
initial
  $monitor( "A=%d, B=%d, Cin= %d, Sum=%d, Cout=%d", a,b,cin,sum,cout);
endmodule