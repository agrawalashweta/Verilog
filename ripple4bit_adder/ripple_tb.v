module tb();
    reg[3:0] a,b;
    reg cin;
    wire[3:0] sum;
    wire cout;
    ripple_adder tb_ripple(a,b,cin,sum,cout);
    initial 
        begin
            $dumpfile("dump.vcd");
            $dumpvars(0,tb);
        end
    initial

        begin
            a=0;b=0;cin=0;
            #10;
            a = 4'b0001; b = 4'b0010; cin = 0;
            #10;

            a = 4'b0110; b = 4'b0101; cin = 0;
            #10;
    
            a = 4'b1111; b = 4'b0001; cin = 1;
            #10;

            a = 4'b1010; b = 4'b0101; cin = 0;
            #10;

            a = 4'b1111; b = 4'b1111; cin = 0;
            #10;
            $finish;
        end

endmodule: tb