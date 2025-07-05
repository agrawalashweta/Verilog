// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module tb_modified_booth;

    reg clk;
    reg rst;
    reg start;
    reg [7:0] a, b;
    wire [15:0] prod;
    wire done;

    // Instantiate the DUT (Device Under Test)
    modified_booth uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .prod(prod),
        .done(done)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
      $dumpfile("tb.vcd");
      $dumpvars(0,tb_modified_booth);
        $display("Starting Modified Booth Multiplier Testbench...");
        clk = 0;
        rst = 0;
        start = 0;
        a = 0;
        b = 0;

        // Reset pulse
        #10;
        rst = 1;

        // Test 1: 7 * 3 = 21
        #10;
        a = 8'd7;
        b = 8'd3;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;
        $display("Test 1: %0d * %0d = %0d", $signed(a), $signed(b), $signed(prod));

        // Test 2: -5 * 4 = -20
        #20;
        a = -8'sd5;
        b = 8'd4;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;
        $display("Test 2: %0d * %0d = %0d", $signed(a), $signed(b), $signed(prod));

        // Test 3: -6 * -6 = 36
        #20;
        a = -8'sd6;
        b = -8'sd6;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;
        $display("Test 3: %0d * %0d = %0d", $signed(a), $signed(b), $signed(prod));

        // Test 4: 0 * 127 = 0
        #20;
        a = 0;
        b = 127;
        start = 1;
        #10;
        start = 0;

        wait(done);
        #10;
        $display("Test 4: %0d * %0d = %0d", $signed(a), $signed(b), $signed(prod));

        $display("Testbench complete.");
        $finish;
    end

endmodule