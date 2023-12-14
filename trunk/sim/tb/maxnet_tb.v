`timescale 1ns/1ns
module tb ();
    reg cc = 1'b1;
    reg rr = 1'b1;
    reg ss = 1'b0;
    wire [31:0] mm;
    wire dd;

    reg [31:0] n1 = 32'b00111110110011001100110011001101;
    reg [31:0] n2 = 32'b00111111110011001100110011001101;
    reg [31:0] n3 = 32'b00111111110110011001100110011010;
    reg [31:0] n4 = 32'b00111111101001100110011001100110;
    reg [31:0] ep = 32'b10111110100110011001100110011010;

    Maxnet my_maxnet(.num1(n1), .num2(n2), .num3(n3), .num4(n4), .max(mm), .done(dd), .start(ss), .rst(rr), .clk(cc), .epsilon(ep));
    
    always #20 cc = ~cc;
    initial begin
        #20 rr = 1'b0;
        #20 ss = 1'b1;
        #2000 $stop;
    end
endmodule