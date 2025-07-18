//assume the priority order is : REQ[3]> REQ[2] > REQ[1] > REQ[0]
//-----------------------------------------------------------FIXED PRIORITY ARBITER-----------------------------------------------------------
module fixed_priority_arbiter(input clk,
                            input rstn,
                            input[3:0] REQ,
                            output reg[3:0] GNT);

                            always @(posedge clk or negedge rstn)
                            begin
                                if (!rstn)
                                begin
                                    GNT<=4'b0000;
                                end
                                else
                                begin
                                    GNT<= {REQ[3], !REQ[3] & REQ[2], !REQ[3] & !REQ[2] & REQ[1], !REQ[3] & !REQ[2] & !REQ[1] & REQ[0]};
                                end
                            end
endmodule