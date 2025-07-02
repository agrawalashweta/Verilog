module tb_bcdadder;

    reg [3:0] a;
    reg [3:0] b;
    reg cin;

    wire [3:0] sum;
    wire cout;

    bcd_adder uut (
        .a(a), 
        .b(b), 
        .cin(cin), 
        .sum(sum), 
        .c_out(cout)
    );

    initial begin
      $dumpfile("tb.vcd");
      $dumpvars(0,tb_bcdadder);
        a = 0;  b = 0;  cin = 0;   #100;
        a = 6;  b = 9;  cin = 0;   #100;
        a = 3;  b = 3;  cin = 1;   #100;
        a = 4;  b = 5;  cin = 0;   #100;
        a = 8;  b = 2;  cin = 0;   #100;
        a = 9;  b = 9;  cin = 1;   #100;
    end
      
endmodule