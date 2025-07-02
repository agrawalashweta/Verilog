module bcd_adder(a,b,cin,sum,c_out);
    input[3:0] a,b;
    input cin;
    output reg[3:0] sum;
    output reg c_out;

    reg[4:0] temp;
    always @ (*)
    begin
        temp= a+b+cin;
        if (temp>9)
        begin
            temp=temp+6;
            c_out=1;
            sum= temp[3:0];
        end
        else begin
            c_out=0;
            sum=temp[3:0];
        end
    end

endmodule