/* booths algorithm is an efficient algorithm to multiply signed integers.
it examines Q[0] and q0 to decide whether to 
do nothing if they both are equal (00,11);
add M to A if they are 01;
subtract M from A if they are 10;
*/
module adder(a,b,cin,sum);
    input[7:0] a;
    input[7:0] b;
    input cin;
    output[7:0] sum;
    wire[8:0] s;
    assign s= a+b+cin;
    assign sum= s[7:0];

endmodule
module subtractor(a,b,sum);
    input[7:0] a;
    input[7:0] b;
    output[7:0] sum;
    wire[7:0] bxor;
    assign bxor= ~b;
    adder inst1(a,bxor,1'b1,sum);
endmodule
module booth_substep(a,Q,q0,m,f8,l8,cq0);
    // a is the accumulator, Q is the multiplier, q0 is the previous Q bit from last cycle
    // m is the multiplicand
    //f8 is the updated A (next accumulator)
    //l8 is the updated Q (updated multiplier)
    //cq0 is Q[0] which becomes q0 in the next step

    input signed[7:0] a;
    input signed[7:0] Q,m;
    input q0;
    output reg signed[7:0] f8,l8;
    output reg signed cq0;
    wire[7:0] addam, subam;
    reg signed[16:0] AQq0;
    adder inst1(a,m,1'b0,addam);
    subtractor inst2(a,m,subam);
    always @(*)
    begin
        if (Q[0]==q0)
        begin
            AQq0= {a,Q,Q[0]};
            AQq0= AQq0>>>1;
            cq0= AQq0[0];
            l8= AQq0[8:1];
            f8= AQq0[16:9];
        end
        else if (Q[0]==0 && q0==1)
        begin
            AQq0= {addam,Q,Q[0]};
            AQq0= AQq0>>>1;
            cq0= AQq0[0];
            l8= AQq0[8:1];
            f8= AQq0[16:9];
        end
        else
        begin
            AQq0= {subam,Q,Q[0]};
            AQq0= AQq0>>>1;
            cq0= AQq0[0];
            l8= AQq0[8:1];
            f8= AQq0[16:9];
        end
    end
endmodule
module boothmultiplier(a,b,c);
        input signed[7:0] a,b;
        // a is the multiplier and b the multiplicand
        output signed[15:0] c;
        wire signed [7:0] Q1,Q2,Q3,Q4,Q5,Q6,Q7;
	    wire signed [7:0] A1,A3,A2;
        wire signed [7:0] A4,A5,A6,A7;
        wire signed [7:0] A8, Q8;
        wire[7:0] q0;
	    wire qout;
	
	    booth_substep step1(8'b00000000,a,1'b0,b,A1,Q1,q0[1]);
	    booth_substep step2(A1,Q1,q0[1],b,A2,Q2,q0[2]);
	    booth_substep step3(A2,Q2,q0[2],b,A3,Q3,q0[3]);
	    booth_substep step4(A3,Q3,q0[3],b,A4,Q4,q0[4]);
	    booth_substep step5(A4,Q4,q0[4],b,A5,Q5,q0[5]);
	    booth_substep step6(A5,Q5,q0[5],b,A6,Q6,q0[6]);
	    booth_substep step7(A6,Q6,q0[6],b,A7,Q7,q0[7]);
	    booth_substep step8(A7,Q7,q0[7],b,A8,Q8,qout);
        assign c= {A8,Q8};
endmodule
