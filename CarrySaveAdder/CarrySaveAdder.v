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
module carrysaveadder(a,b,c,d,sum,cout);
    input[3:0] a,b,c,d;
    output[4:0] sum;
    output cout;
    wire[3:0] s0,s1;
    wire[3:0] c0,c1;
    //1ST STAGE
    full_adder inst1(a[0],b[0],c[0],s0[0],c0[0]);
    full_adder inst2(a[1],b[1],c[1],s0[1],c0[1]);
    full_adder inst3(a[2],b[2],c[2],s0[2],c0[2]);
    full_adder inst4(a[3],b[3],c[3],s0[3],c0[3]);

    //2nd STAGE
    full_adder inst5(d[0], s0[0], 1'b0, sum[0], c1[0]);
    full_adder inst6(d[1], s0[1], c0[0], s1[0], c1[1]);
    full_adder inst7(d[2], s0[2], c0[1], s1[1], c1[2]);
    full_adder inst8(d[3], s0[3], c0[2], s1[2], c1[3]);

    RCA rca1(c1[3:0], {c0[3],s1[2:0]}, 1'b0, sum[4:1], cout);
endmodule