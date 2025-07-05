module modified_booth(clk,rst,start,a,b,prod,done);
    input clk,rst,start;
    input[7:0] a,b;
    output reg[15:0] prod;
    output reg done;

    integer count;
    reg signed[15:0] prod_intermediate;
    reg[8:0] multiplier;
    reg signed[15:0] multiplicand;
    reg signed[15:0] partial_product;
    reg[2:0] booth_bits;

    reg[1:0] state;

    //define states
    parameter IDLE=2'b00;
    parameter RUN=2'b01;
    parameter DONE=2'b10;

    always @(posedge clk or negedge rst)
    begin
        if (~rst)
        begin
            prod<=0;
            done<=0;
            count<=0;
            state<=IDLE;
            prod_intermediate<=0;
        end
        else
        begin
            case(state)
            IDLE:
            begin
                done<=0;
                prod<=0;
                if (start)
                begin
                    multiplicand<= $signed(a);
                    multiplier<= {b,1'b0};
                    prod_intermediate<=0;
                    count<=0;
                    state<=RUN;
                end
            end
            RUN:
            begin
                booth_bits= multiplier[2:0];
                case(booth_bits)
                3'b000,3'b111: partial_product= 16'd0;
                3'b001,3'b010: partial_product= multiplicand;
                3'b011: partial_product= multiplicand<<<1;
                3'b100: partial_product= -(multiplicand<<<1);
                3'b101,3'b110: partial_product= -multiplicand;
                default: partial_product= 16'd0;
                endcase
                prod_intermediate= prod_intermediate+ (partial_product<<<(2*count));
                multiplier= $signed(multiplier)>>>2;
                count=count+1;
                if (count==4) state<=DONE;
            end
            DONE:
            begin
                prod<=prod_intermediate;
                done<=1;
                state<=IDLE;
            end
            endcase
        end

    end
endmodule