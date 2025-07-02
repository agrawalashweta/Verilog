module D_ff(clk,clear,D,Q);
    input clk,clear;
    input D;
    output reg Q;
    always @(posedge clk or negedge clear)
    begin
        if (~clear) Q<=0;
        else Q<=D;
    end
endmodule
module mux8x1(in0,in1,in2,in3,in4,in5,in6,in7,sel,out);
    input in0,in1,in2,in3,in4,in5,in6,in7;
    input[2:0] sel;
    output reg out;
    always @(*)
    begin
        case(sel)
        3'b000: out= in0;
        3'b001: out= in1;
        3'b010: out= in2;
        3'b011: out= in3;
        3'b100: out= in4;
        3'b101: out= in5;
        3'b110:  out= in6;
        3'b111: out= in7;
        endcase
    end
endmodule
// SHIFT REG BEHAVIOUR
// S VALUE              OPERATION              DESCRIPTION
/* 000                      HOLD               MAINTAINS CURRENT STATE
001                   RIGHT SHIFT               EACH BIT TAKES VALUE OF ITS LEFT NEIGHBOUR
010                   LEFT SHIFT              EACH BIT TAKES VALUE OF ITS RIGHT NEIGHBOUR
011                   PARELLEL LOAD            LOAD INPUT INTO REGISTER
100                   BITWISE NOT              EACH BIT GETS ITS INVERSE
101-111 REVERSED OR MIXED 
*/
module universal_shift_reg(clk,clear,S,I,O);
    input clk,clear;
    input[3:0] I;
    input[2:0] S;
    output[3:0] O;
    wire[3:0] temp;
    mux8x1 inst1(O[0] , 1'b0 , O[1] , I[0] , ~O[0] , O[3] , O[1] , O[2], S, temp[0]);
    mux8x1 inst2(O[1] , O[0] , O[2] , I[1] , ~O[1] , O[0] , O[2] , O[3], S, temp[1]);
    mux8x1 inst3(O[2] , O[1] , O[3] , I[2] , ~O[2] , O[1] , O[3] , O[0], S, temp[2]);
    mux8x1 inst4( O[3] , O[2] , 1'b0 , I[3] , ~O[3] , O[2] , O[0] , O[1], S, temp[3]);
    
    D_ff inst5(clk,clear,temp[0],O[0]);
    D_ff inst6(clk,clear,temp[1],O[1]);
    D_ff inst7(clk,clear,temp[2],O[2]);
    D_ff inst8(clk,clear,temp[3],O[3]);

endmodule