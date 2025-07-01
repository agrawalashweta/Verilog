module half_adder(a,b,s,cout);
    input a,b;
    output s,cout;
    assign s= a^b;
    assign cout = a&b;
endmodule
module full_adder(a,b,cin,s,cout);
    input a,b,cin;
    output s,cout;
    assign s= a^b^cin;
    assign cout= (a&b) | (b&cin) | (a&cin);
endmodule
module RCA(a,b,cin,s,cout);
    input[3:0] a,b;
    input cin;
    output[3:0] s;
    output cout;
    wire c1,c2,c3;
    full_adder fa1(a[0],b[0],cin,s[0],c1);
    full_adder fa2(a[1],b[1],c1,s[1],c2);
    full_adder fa3(a[2],b[2],c2,s[2],c3);
    full_adder fa4(a[3],b[3],c3,s[3],cout);
endmodule
module mux2x1(a,b,sel,out);
    input a,b,sel;
    output out;
    assign out= sel? b:a;
endmodule
module generate_p(a,b,p,bp);
    input[3:0] a,b;
    output[3:0] p;
    output bp;
    assign p= a^b;
    assign bp= &p;
endmodule
module carry_skip_4bit(a,b,cin,sum,cout);
    input[3:0] a,b;
    input cin;
    output[3:0] sum;
    output cout;
    wire c0,bp;
    wire[3:0] p;
    RCA rca1(a,b,cin,sum,c0);
    generate_p g1(a,b,p,bp);
    mux2x1 m1(c0, cin, bp, cout);
endmodule
module carry_skip16bit(a,b,cin,sum,cout);
    input[15:0] a,b;
    input cin;
    output[15:0] sum;
    output cout;
    wire[2:0] c;
    carry_skip_4bit csa1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c[0]));
    carry_skip_4bit csa2 (.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .sum(sum[7:4]), .cout(c[1]));
    carry_skip_4bit csa3(.a(a[11:8]), .b(b[11:8]), .cin(c[1]), .sum(sum[11:8]), .cout(c[2]));
    carry_skip_4bit csa4(.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .sum(sum[15:12]), .cout(cout));
endmodule