module single_port_ram(
                        input [7:0] data,
                        input[5:0] addr,
                        input clk,
                        input we,
                        output [7:0] q
);
    reg[7:0] mem[63:0];
    reg[5:0] addr_reg;
    always @(posedge clk)
    begin
        if (we) mem[addr] <=data;
        else
        begin
            addr_reg<=addr;
        end
    end
    assign q= mem[addr_reg];

endmodule