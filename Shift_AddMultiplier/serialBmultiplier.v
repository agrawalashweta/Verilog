/============================UNSIGNED MULTIPLICATION=========================================================================
/* 
BEHAVIOUR OF THE BELOW WRITTEN CODE:
The adder module performs simple addition of WIDTH bits wide. This is used for partial sum calculation.

The controller module is the control unit that will be used for determining if we are loading,adding or shifting the value.
It implements a finite state machine that controls the multiplication sequence
On rst, everything will go to idle and start=1 
if the state is idle, it checks the start then it moves to init
if init, it initializes load command as 1 to load multiplier into the shifter
In test, it checks if the current LSB of the multiplier is 1, if it is then it adds, otherwise it shifts
in shift, it performs right shift, if not bits are processed then return to test case otherwise  finish and go to idle state for output;

The shifter module holds the current intermediate result of multiplication.
Q IS THE MULTIPLIER
D IS THE MULTIPLICAND
A IS THE ACCUMULATOR
it performs: load initial Q, add partial product from adder, shifts the entire register right, output final result.
*/

module adder(A,D,add_out,c_out);
    parameter WIDTH=8;
    input[WIDTH-1:0] A,D;
    output[WIDTH-1:0] add_out;
    output c_out;
    assign {c_out,add_out}= A+D;
endmodule
module controller(clk,rst,lsb,load_cmd,add_cmd,shift_cmd,out_cmd);
    input clk,rst,lsb;
    output load_cmd, add_cmd, shift_cmd, out_cmd;
    reg load_cmd, add_cmd, shift_cmd, out_cmd;
    reg[2:0] state;
    integer count;
    reg start;
    parameter m=8;
    parameter n=8;
    parameter IDLE= 3'b000;
    parameter INIT= 3'b001;
    parameter TEST=3'b010;
    parameter ADD= 3'b011;
    parameter SHIFT= 3'b100;
    always @ (posedge clk or posedge rst)
    begin
        if (rst)
        begin
            state<=IDLE;
            count<=0;
            start<=1;
            load_cmd<=0;
            add_cmd<=0;
            shift_cmd<=0;
            out_cmd<=0;
        end
        else
        begin
            case(state)
                IDLE:
                begin
                    load_cmd<=0;
                    add_cmd<=0;
                    shift_cmd<=0;
                    if (start)
                    begin
                        state<=INIT;
                        out_cmd<=0;
                    end
                    else
                    begin
                        state<=IDLE;
                        out_cmd<=1;
                    end
                end
                INIT:
                begin
                    load_cmd<=1;
                    add_cmd<=0;
                    shift_cmd<=0;
                    out_cmd<=0;
                    state<=TEST;
                end
                TEST:
                begin
                    load_cmd<=0;
                    add_cmd<=0;
                    shift_cmd<=0;
                    out_cmd<=0;
                    if (lsb)
                    begin
                        state<=ADD;
                    end
                    else state<=SHIFT;
                end
                ADD:
                begin
                    load_cmd<=0;
                    add_cmd<=1;
                    shift_cmd<=0;
                    out_cmd<=0;
                    state<=SHIFT;
                end
                SHIFT:
                begin
                    load_cmd<=0;
                    add_cmd<=0;
                    out_cmd<=0;
                    shift_cmd<=1;
                    if (count<m)
                    begin
                        state<=TEST;
                        count<=count+1;
                    end
                    else
                    begin
                        count<=0;
                        state<=IDLE;
                        start<=0;
                    end
                end
            endcase
        end
    end
endmodule
module shifter(clk,rst,lsb, load_cmd, add_cmd, shift_cmd, out_cmd, add_out, c_out, out, A, Q);
    parameter m=8;
    parameter n=8;
    input[m-1:0] add_out;
    input c_out, load_cmd, add_cmd, shift_cmd, clk, rst, out_cmd;
    input[n-1:0] Q;
    output[m-1:0] A; // MULTIPLICAND
    output lsb;
    output reg [m+n-1:0] out;
    reg[m+n:0] temp; // CONTAINS (CARRY | ACCUMULATOR SUM | MULTIPLIER)
    reg add_temp; // was addition requested before shift??

    assign A= temp[m+n-1:n]; // ACCUMULATOR 
    assign lsb= temp[0]; // LSB OF THE MULTIPLIER

    always @ (posedge clk or posedge rst)
    begin
        if(rst)
        begin
            add_temp<=0;
            temp<=0;
        end
        else
        begin
            if(load_cmd)
            begin
                temp[m+n:n]<=0; //CLEAR THE ACCUMULATOR
                temp[n-1:0]<=Q; // LOAD THE MULTIPLIER
            end
            else if (add_cmd)
            begin
                add_temp<=1; //REMEMBER WE NEED TO SHIFT WITH ADDITION
            end
            else if (shift_cmd && add_temp)
            begin
                temp<={1'b0,c_out, add_out, temp[n-1:1]}; // INCLUDES RESULT OF ADDITION
                add_temp<=0;
            end
            else if (shift_cmd &&  !add_temp)
            begin
                temp<={1'b0, temp[m+n:1]}; //otherwise just shift
            end
        end
    end
    always @ (out_cmd)
    begin
        if (!out_cmd)
        begin
            out<=0;
        end
        else out<=temp[m+n-1:0]; //COMBINED (A | Q);
    end
endmodule
module MULTIPLIER(clk,rst,D,Q,out);
    input clk,rst;
    parameter m=8;
    parameter n=8;
    input[m-1:0] D;
    input[n-1:0] Q;
    output[m+n-1:0] out;
    wire c_out, add_cmd, load_cmd, shift_cmd, lsb, out_cmd;
    wire[m-1:0] A, add_out;
    adder #(m) adder1(A,D,add_out,c_out);
    shifter #(m,n) shifter1(clk,rst,lsb,load_cmd,add_cmd,shift_cmd,out_cmd, add_out, c_out, out,A,Q);
    controller #(m,n) controller1(clk,rst,lsb,load_cmd,add_cmd,shift_cmd,out_cmd);
endmodule

