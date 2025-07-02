//MOORE FSM TO DETECT A SEQUENCE OF 2 1'S OR MORE====> it isnt a overlapping sequence detector, it just detects 2 1's and then stays high till a zero is given to reset it
module state_machine_moore(clk,reset,in,out);
    parameter ZERO= 2'b00;
    parameter oneONE= 2'b01;
    parameter twoONE= 2'b10;
    output out;
    input clk,reset,in;
    reg out;
    reg[1:0] state;
    reg[1:0] next_state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset)
        begin
            state<=ZERO;
        end
        else state<=next_state;
    end
    always @(*)
    begin
        case(state)
        ZERO:
        begin
            if (in) next_state= oneONE;
            else next_state=ZERO;
        end
        oneONE:
        begin
            if (in) next_state=twoONE;
            else next_state=ZERO;
        end
        twoONE:
        begin
            if(in) next_state= twoONE;
            else next_state=ZERO;
        end
        endcase
    end
    always @(state)
    begin
        case(state)
            ZERO: out=0;
            oneONE: out=0;
            twoONE: out=1;
            default: out=0;
        endcase
    end
endmodule