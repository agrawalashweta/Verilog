`timescale 1ns/1ps

module tb_fixed_priority_arbiter;

    reg clk;
    reg rstn;
    reg [3:0] REQ;
    wire [3:0] GNT;

    // Instantiate the DUT
    fixed_priority_arbiter dut (
        .clk(clk),
        .rstn(rstn),
        .REQ(REQ),
        .GNT(GNT)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    // Task to display test results
    task display_status;
        $display("Time: %0t | REQ = %b | GNT = %b", $time, REQ, GNT);
    endtask

    initial begin
        // Initialize
        $dumpfile("tb.vcd");
        $dumpvars(0,tb_fixed_priority_arbiter);
        clk = 0;
        rstn = 0;
        REQ = 4'b0000;

        // Reset
        #12;
        rstn = 1;

        // Test 1: No request
        #10;
        REQ = 4'b0000;
        #10; display_status();

        // Test 2: REQ[0] only (lowest priority)
        REQ = 4'b0001;
        #10; display_status();

        // Test 3: REQ[1] only
        REQ = 4'b0010;
        #10; display_status();

        // Test 4: REQ[2] only
        REQ = 4'b0100;
        #10; display_status();

        // Test 5: REQ[3] only (highest priority)
        REQ = 4'b1000;
        #10; display_status();

        // Test 6: Multiple REQs — lower first
        REQ = 4'b0011; // REQ[1:0]
        #10; display_status();

        // Test 7: Multiple REQs — middle two
        REQ = 4'b0110; // REQ[2:1]
        #10; display_status();

        // Test 8: All REQs
        REQ = 4'b1111;
        #10; display_status();

        // Test 9: Changing REQ in runtime
        REQ = 4'b0101;
        #10; display_status();
        REQ = 4'b1001;
        #10; display_status();
        REQ = 4'b0001;
        #10; display_status();

        // Finish
        $display("Test completed.");
        $finish;
    end

endmodule
