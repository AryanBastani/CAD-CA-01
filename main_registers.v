module main_registers(clk, rst, clr, en, num1, num2,
    num3, num4, x1, x2, x3, x4);
    input clk, rst, clr, en;
    input [31:0] num1, num2, num3, num4;
    output [31:0] x1, x2, x3, x4;

    reg_32bit x1_reg(clk, rst, clr, en, num1, x1);
    reg_32bit x2_reg(clk, rst, clr, en, num2, x2);
    reg_32bit x3_reg(clk, rst, clr, en, num3, x3);
    reg_32bit x3_reg(clk, rst, clr, en, num4, x4);
endmodule