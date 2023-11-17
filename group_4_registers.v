module group_4_registers(clk, rst, clr, en, in1, in2,
    in3, in4, out1, out2, out3, out4);
    input clk, rst, clr, en;
    input [31:0] in1, in2, in3, in4;
    output [31:0] out1, out2, out3, out4;

    reg_32bit x1_reg(clk, rst, clr, en, in1, out1);
    reg_32bit x2_reg(clk, rst, clr, en, in2, out2);
    reg_32bit x3_reg(clk, rst, clr, en, in3, out3);
    reg_32bit x4_reg(clk, rst, clr, en, in4, out4);
endmodule