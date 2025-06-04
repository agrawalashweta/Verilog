//==================================================4 BIT RIPPLE CARRY ADDER==================================================================
module fulladder(input a,
                input b,
                input cin,
                output s,
                output cout);

                wire t1,t2,t3;
                xor g1(t1,a,b);
                xor g2(s,t1,cin);
                and g3(t2,t1,cin);
                and g4(t3,a,b);
                or g5(cout,t2,t3);
endmodule: fulladder

module ripple_adder(input[3:0] a,
                    input[3:0] b,
                    input cin,
                    output [3:0] s,
                    output cout);
                    

                    wire w1,w2,w3;
                    fulladder f1(a[0],  b[0],  cin, s[0],  w1);
                    fulladder f2(a[1],  b[1],  w1,  s[1],  w2);
                    fulladder f3(a[2],  b[2],  w2,  s[2],  w3);
                    fulladder f4(a[3],  b[3],  w3,  s[3],  cout);
endmodule: ripple_adder

