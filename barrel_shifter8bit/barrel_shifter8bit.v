module mux2_1(a,b,s,out);
    input a,b,s;
    output out;
    assign out= s? b:a;
endmodule
// ===========================================8 BIT BARREL SHIFTER (SHIFTS LEFT)====================================================
module barrelshifter(a,b,out);
    input [7:0] a;
    input [2:0] b;
    output[7:0] out;
    wire[7:0] x,y;
    //1 bit shift
    mux2_1 t1(a[0],0,b[0],x[0]);
    mux2_1 t2(a[1],a[0],b[0],x[1]);
    mux2_1 t3(a[2],a[1],b[0],x[2]);
    mux2_1 t4(a[3],a[2],b[0],x[3]);
    mux2_1 t5(a[4],a[3],b[0],x[4]);
    mux2_1 t6(a[5],a[4],b[0],x[5]);
    mux2_1 t7(a[6],a[5],b[0],x[6]);
    mux2_1 t8(a[7],a[6],b[0],x[7]);

    //2 bit shift
    mux2_1 i1(x[0],0,b[1],y[0]);
    mux2_1 i2(x[1],0,b[1],y[1]);
    mux2_1 i3(x[2],x[0],b[1],y[2]);
    mux2_1 i4(x[3], x[1],b[1],y[3]);
    mux2_1 i5(x[4], x[2],b[1],y[4]);
    mux2_1 i6(x[5], x[3],b[1],y[5]);
    mux2_1 i7(x[6], x[4],b[1],y[6]);
    mux2_1 i8(x[7], x[5],b[1],y[7]);

    //4 bit shift
    mux2_1 j1(y[0],0,b[2],out[0]);
    mux2_1 j2(y[1],0,b[2],out[1]);
    mux2_1 j3(y[2],0,b[2],out[2]);
    mux2_1 j4(y[3],0,b[2],out[3]);
    mux2_1 j5(y[4], y[0],b[2],out[4]);
    mux2_1 j6(y[5], y[1],b[2],out[5]);
    mux2_1 j7(y[6], y[2],b[2],out[6]);
    mux2_1 j8(y[7], y[3],b[2],out[7]);

endmodule