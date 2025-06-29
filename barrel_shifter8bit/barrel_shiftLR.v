module mux2_1(a,b,sel,out);
    input a,b,sel;
    output out;
    assign out= sel?b:a;
endmodule
//===============================================================8 BIT BARREL SHIFTER THAT SHIFTS RIGHT==============================================================
module barrelshifterR(a,b,out);
    input[7:0] a;
    input [2:0] b;
    output[7:0] out;
    wire[7:0] x,y;
            //4 bit shift right
            mux2_1 t1(a[7],0,b[2],x[7]);
            mux2_1 t2(a[6],0,b[2],x[6]);
            mux2_1 t3(a[5],0,b[2],x[5]);
            mux2_1 t4(a[4],0,b[2],x[4]);
            mux2_1 t5(a[3],a[7],b[2],x[3]);
            mux2_1 t6(a[2],a[6],b[2],x[2]);
            mux2_1 t7(a[1],a[5],b[2],x[1]);
            mux2_1 t8(a[0],a[4],b[2],x[0]);
            
            //2 bit shift right
            mux2_1 i1(x[7],0,b[1],y[7]);
            mux2_1 i2(x[6],0,b[1],y[6]);
            mux2_1 i3(x[5],x[7],b[1],y[5]);
            mux2_1 i4(x[4],x[6],b[1],y[4]);
            mux2_1 i5(x[3],x[5],b[1],y[3]);
            mux2_1 i6(x[2],x[4],b[1],y[2]);
            mux2_1 i7(x[1],x[3],b[1],y[1]);
            mux2_1 i8(x[0],x[2],b[1],y[0]);

            //1 bit shift right
            mux2_1 j1(y[7],0,b[0],out[7]);
            mux2_1 j2(y[6],y[7],b[0],out[6]);
            mux2_1 j3(y[5],y[6],b[0],out[5]);
            mux2_1 j4(y[4],y[5],b[0],out[4]);
            mux2_1 j5(y[3],y[4],b[0],out[3]);
            mux2_1 j6(y[2],y[3],b[0],out[2]);
            mux2_1 j7(y[1],y[2],b[0],out[1]);
            mux2_1 j8(y[0],y[1],b[0],out[0]);
endmodule