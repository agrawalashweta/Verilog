// complex multiplcation is basically multiplying a+ jb * c+ jd, a is the in the msbs of a and b is the lsbs of a similarly for c and d
module complex_mul(a,b,product);
    input[15:0] a,b;
    output[31:0] product;
    wire[7:0] real_a, imag_b, real_b, imag_a;
    assign real_a= a[15:8];
    assign imag_a= a[7:0];
    assign real_b= b[15:8];
    assign imag_b= b[7:0];
    assign product= {{real_a* real_b - imag_a* imag_b},{real_a*imag_b + imag_a*real_b} };
endmodule