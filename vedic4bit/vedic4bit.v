module half_adder(input a, input b, output s, output cout);
    assign {cout,s}= a+b;
endmodule

module array2_2(a,b,prod);
    input[1:0] a,b;
    output [3:0] prod;
    wire[3:0] temp;
    assign prod[0]= a[0] & b[0];
    assign temp[0]= a[1] & b[0];
    assign temp[1]= a[0] & b[1];
    assign temp[2]= a[1] & b[1];
    half_adder ha1(temp[0],temp[1], prod[1], temp[3]);
    half_adder ha2(temp[2],temp[3],prod[2],prod[3]);
endmodule

module array4_4(a,b,prod);
    input[3:0] a,b;
    output[7:0] prod;
    wire[3:0] q0,q1,q2,q3;

    array2_2 t1(a[1:0],b[1:0],q0);
    array2_2 t2(a[3:2],b[1:0], q1);
    array2_2 t3(a[1:0], b[3:2], q2);
    array2_2 t4(a[3:2],b[3:2],q3);

    wire[3:0] temp1, q4;
    wire[5:0] q5,q6,temp3,temp4,temp2;

    assign temp1={2'b0, q0[3:2]};
    assign q4= temp1+q1;
    assign temp2= {2'b00, q2};
    assign temp3= {q3, 2'b00};
    assign q5= temp2 + temp3;
    assign temp4= {2'b00, q4};
    assign q6= q5 + temp4;

    assign prod[1:0]= q0[1:0];
    assign prod[7:2]= q6;


endmodule
