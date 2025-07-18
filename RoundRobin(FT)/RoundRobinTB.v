`timescale 1ns / 1ps

module tb_round_robin;

    reg clk;
    reg rstn;
    reg [3:0] REQ;
    wire [3:0] GNT;

    // Instantiate the DUT
    round_robin uut (
        .clk(clk),
        .rstn(rstn),
        .REQ(REQ),
        .GNT(GNT)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // VCD dump for waveform viewing
    initial begin
        $dumpfile("round_robin.vcd");
        $dumpvars(0, tb_round_robin);
    end

    // Test sequence
    initial begin
        clk = 0;
        rstn = 0;
        REQ = 4'b0000;

        // Apply reset
        #12;
        rstn = 1;

        // Idle state
        #10;
        REQ = 4'b0000;
        #10;

        // Single REQ[0] active
        REQ = 4'b0001;
        #20;

        // Rotate through requests
        REQ = 4'b0010;  // REQ[1]
        #20;
        REQ = 4'b0100;  // REQ[2]
        #20;
        REQ = 4'b1000;  // REQ[3]
        #20;

        // Multiple REQs at once
        REQ = 4'b1111;
        #100;

        // No request
        REQ = 4'b0000;
        #20;

        // Random pattern
        REQ = 4'b1010;
        #40;

        // End simulation
        $display("Simulation complete.");
        $finish;
    end

endmodule