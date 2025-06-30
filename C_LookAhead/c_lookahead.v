module look_ahead4bit(a,b,cin,s,cout);
    input[3:0] a;
    input[3:0] b;
    input cin;
    output[3:0] s;
    output cout;
    wire[3:0] g,p,c;
    assign g= a & b;
    assign p= a^b;

    assign c[0]= cin;
    assign c[1]= g[0] | (p[0] &c[0] );
    assign c[2]= g[1] | (g[0]&p[1]) | (p[1] & p[0] & c[0]);
    assign c[3]= g[2] | (g[1] & p[2]) | (p[2]& p[1] & g[0]) | (p[2] & p[1] & p[0] & c[0]);
    assign cout= g[3] | (p[3]&g[2]) | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0] | p[3]&p[2]&p[1]&p[0]&c[0];
    assign s= p^c;

endmodule
module look_ahead16bit(a,b,cin,s,cout);
    input[15:0] a,b;
    input cin;
    output[15:0] s;
    output cout;
    wire c1,c2,c3;
    look_ahead4bit inst1(a[3:0],b[3:0],cin,s[3:0],c1);
    look_ahead4bit inst2(a[7:4],b[7:4],c1,s[7:4],c2);
    look_ahead4bit inst3(a[11:8],b[11:8],c2,s[11:8],c3);
    look_ahead4bit inst4(a[15:12],b[15:12],c3,s[15:12],cout);
endmodule