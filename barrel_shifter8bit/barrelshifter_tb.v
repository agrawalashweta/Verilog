`timescale 1ns / 1ps

module barrelshifter_tb;

  reg [7:0] a;
  reg [2:0] b;
  wire [7:0] out;

  // Instantiate the barrel shifter
  barrelshifter inst1 (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    $dumpfile("shifter.vcd");
    $dumpvars(0,barrelshifter_tb);
    $display("Time\t a\t\t b\t out");
    $monitor("%0dns\t %b\t %d\t %b", $time, a, b, out);

    // Test various shift values
    a = 8'b10110011;

    b = 3'b000; #10; // Shift by 0
    b = 3'b001; #10; // Shift by 1
    b = 3'b010; #10; // Shift by 2
    b = 3'b011; #10; // Shift by 3
    b = 3'b100; #10; // Shift by 4
    b = 3'b101; #10; // Shift by 5
    b = 3'b110; #10; // Shift by 6
    b = 3'b111; #10; // Shift by 7

    // Test another value
    a = 8'b11110000; b = 3'b010; #10;

    $finish;
  end

endmodule
