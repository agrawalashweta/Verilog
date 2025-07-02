//FSM MACHINE TO DETECT A SEQUENCE OF 2 1'S OR MORE
module state_machine_mealy(clk,reset,in,out);
    input clk,reset,in;
    output reg out;
    parameter ZERO= 1'b0;
    parameter oneONE=1'b1;
    reg state,next_state;
    always @ (posedge clk or posedge reset)
    begin
        if (reset) state<=ZERO;
        else state<=next_state;
    end
    always @(state or in)
begin
    case(state)
    ZERO:
    begin
        if (in)
        begin
            next_state=oneONE;
            out=0;
        end
        else
        begin
            next_state=ZERO;
            out=0;
        end
    end
    oneONE:
    begin
        if (in)
        begin
            next_state=oneONE;
            out=1;
        end
        else 
        begin
            next_state=ZERO;
            out=0;
        end
    end
    default: 
    begin
        next_state= ZERO;
        out=0;
    end
    endcase
end
endmodule
