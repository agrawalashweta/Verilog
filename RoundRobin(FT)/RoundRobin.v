//--------------------------------------------------------ROUND ROBIN ARBITER WITH FIXED TIME SLICES--------------------------------------
module round_robin(
                    input clk,
                    input rstn,
                    input[3:0] REQ,
                    output reg[3:0] GNT
) ;
    reg[2:0] present_state;
    reg[2:0] next_state;
    parameter S_ideal=3'b000;
    parameter S0= 3'b001;
    parameter S1= 3'b010;
    parameter S2= 3'b011;
    parameter S3= 3'b100;
    always @(posedge clk or negedge rstn)
    begin
        if (!rstn)
        begin
            present_state<=S_ideal;
        end
        else
        begin
            present_state<=next_state;
        end
    end
    always @(*)
    begin
        case(present_state)
        S_ideal:
        begin
            if (REQ[0]) begin
                next_state=S0;
            end
            else if (REQ[1]) next_state=S1;
            else if (REQ[2]) next_state=S2;
            else if (REQ[3]) next_state=S3;
            else next_state=S_ideal;
        end
        S0:
        begin
            if (REQ[1]) next_state=S1;
            else if (REQ[2]) next_state=S2;
            else if (REQ[3]) next_state=S3;
            else if(REQ[0]) next_state=S0;
            else next_state=S_ideal;
        end
        S1:
        begin
            if (REQ[2]) next_state=S2;
            else if (REQ[3]) next_state=S3;
            else if (REQ[0]) next_state=S0;
            else if (REQ[1]) next_state=S1;
            else next_state=S_ideal;
        end
        S2:
        begin
            if (REQ[3]) next_state=S3;
            else if (REQ[0]) next_state=S0;
            else if (REQ[1]) next_state=S1;
            else if (REQ[2]) next_state=S2;
            else next_state=S0;
        end
        S3:
        begin
             if (REQ[0]) begin
                next_state=S0;
            end
            else if (REQ[1]) next_state=S1;
            else if (REQ[2]) next_state=S2;
            else if (REQ[3]) next_state=S3;
            else next_state=S_ideal;

        end
        default:
        begin
             if (REQ[0]) begin
                next_state=S0;
            end
            else if (REQ[1]) next_state=S1;
            else if (REQ[2]) next_state=S2;
            else if (REQ[3]) next_state=S3;
            else next_state=S_ideal;
        end

        endcase
    end
    always @(*) 
    begin
        case(present_state)
        S0: GNT=4'b0001;
        S1: GNT=4'b0010;
        S2: GNT=4'b0100;
        S3: GNT=4'b1000;
        default: GNT=4'b0000;
        endcase
    end
endmodule