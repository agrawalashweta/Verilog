module array_mul4bit(a,b,prod);
    input[3:0] a;
    input[3:0] b;
    output[7:0] prod;
    wire[15:0] _and;
    assign _and[0]= a[0] & b[0];
    assign _and[1]= a[1] & b[0];
    assign _and[2]= a[2] & b[0];
    assign _and[3]= a[3] & b[0];
    assign _and[4]= a[0] & b[1];
    assign _and[5]= a[1] & b[1];
    assign _and[6] = a[2] & b[1];
    assign _and[7]= a[3] & b[1];
    assign _and[8]= a[0] & b[2];
    assign _and[9]= a[1] & b[2];
    assign _and[10]= a[2] & b[2];
    assign _and[11]= a[3] & b[2];
    assign _and[12]= a[0] & b[3];
    assign _and[13]= a[1] & b[3];
    assign _and[14] = a[2] & b[3];
    assign _and[15]= a[3] & b[3];
    assign prod[0]= _and[0];
    // instantiate half adder for partial sum of a1b0+ a0b1
    wire[10:0] cout;
    wire[10:0] ps;
    half_adder ha1(_and[1] , _and[4], prod[1], cout[0]); //a1b0 + a0b1
    half_adder ha2 (_and[2], _and[5], ps[0] ,cout[1]); // a2b0+ a1b1
    half_adder ha3( _and[3], _and[6], ps[1], cout[2]); //a3b0+ a2b1
    // instantiate full adder for more partial sums which include carry stages from previous partial sums
    full_adder fa1( ps[0], _and[8], cout[0], prod[2], cout[3]); //a2b0 + a1b1+ a0b2
    full_adder fa2(ps[1], _and[9], cout[1], ps[2], cout[4]); //a3b0 + a2b1 + a1b2
    full_adder fa3(ps[2], _and[12], cout[3], prod[3], cout[5]); //a3b0 + a2b1 + a1b2 + a0b3
    full_adder fa4(_and[7], _and[10],cout[2],ps[4],cout[6]); //a3b1+a2b2
    full_adder fa5( ps[4], _and[13], cout[4], ps[5], cout[7]); //a3b1 + a2b2 + a1b3
    half_adder ha4(ps[5],cout[5], prod[4], cout[8] ); // a3b1 + a2b2 + a1b3
    full_adder fa6( _and[11], _and[14], cout[6], ps[6], cout[9]); //a3b2 + a2b3
    full_adder fa7(ps[6], cout[7],cout[8], prod[5], cout[10]); //a3b2+ a2b3 + carry from previous stages
    full_adder fa8(_and[15], cout[10], cout[9],prod[6],prod[7]); //a3b3

endmodule

module half_adder(a,b,s,cout);
    input a;
    input b;
    output s;
    output cout;
    assign s= a^b;
    assign cout= a&b;
endmodule

module full_adder(a,b,cin,s,cout);
    input a;
    input b;
    input cin;
    output s;
    output cout;
    assign s= a^b^cin;
    assign cout= (a&b | b&cin | a&cin);
endmodule