module tb_array_mul4bit;

  reg [3:0] a, b;
  wire [7:0] prod;

  // Instantiate the multiplier
  array_mul4bit uut (
    .a(a),
    .b(b),
    .prod(prod)
  );

  integer i, j;
  reg [7:0] expected;

  initial begin
    $dumpfile("4bitmul.vcd");
    $dumpvars(0,tb_array_mul4bit);
    $display("Testing 4-bit Array Multiplier");
    $display(" a   *   b   = prod | expected | Status");

    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        a = i[3:0];
        b = j[3:0];
        expected = a * b;

        #10; // Wait for logic to propagate

        if (prod === expected)
          $display("%2d * %2d = %3d | %3d | PASS", a, b, prod, expected);
        else
          $display("%2d * %2d = %3d | %3d | FAIL", a, b, prod, expected);
      end
    end

    $display("Test completed.");
    $finish;
  end

endmodule