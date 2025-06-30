module half_adder(a,b,s,cout);
    input a,b;
    output s,cout;
    assign s= a^b;
    assign cout= a&b;
endmodule

module full_adder(a,b,cin,s,cout);
    input a,b,cin;
    output s,cout;
    assign s= a^b^cin;
    assign cout= (a&b) | (a&cin) | (b&cin);
endmodule

module ripple4bit(a,b,cin,s,cout);
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
    parameter WIDTH=16;
    input[WIDTH-1:0] a,b;
    input sel;
    output[WIDTH-1:0] out;
    assign out= sel?b:a;
endmodule

module c_select4bit(a,b,cin,s,cout);
    input[3:0] a,b;
    input cin;
    output[3:0] s;
    output cout;
    wire[3:0] s0,s1;
    wire c0,c1;
    ripple4bit ra1(a,b,1'b0,s0,c0);
    ripple4bit ra2(a,b,1'b1,s1,c1);
    mux2x1 #(4) i1(s0,s1,cin,s);
    mux2x1 #(1) i2(c0,c1,cin,cout);
endmodule

module c_select16bit(a,b,cin,s,cout);
    input[15:0] a,b;
    input cin;
    output[15:0] s;
    output cout;
    wire[2:0] c;

    ripple4bit inst1(a[3:0],b[3:0],cin,s[3:0],c[0]);
    c_select4bit inst2(a[7:4],b[7:4],c[0],s[7:4],c[1]);
    c_select4bit inst3(a[11:8],b[11:8],c[1],s[11:8],c[2]);
    c_select4bit inst4(a[15:12],b[15:12],c[2],s[15:12],cout);
endmodule
