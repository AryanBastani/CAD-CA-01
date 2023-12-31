module PU(
    input clk,
    input rst,
    input mult_write,
    input[31:0] x1, x2, x3, x4,
    input[31:0] w1, w2, w3, w4,
    output[31:0] a
);

    wire[31:0] mult_out1, mult_out2, mult_out3, mult_out4,
        add_in1, add_in2, add_in3, add_in4,
        add_out1, add_out2;

    fp_multiplier multi1(x1, w1, mult_out1);
    fp_multiplier multi2(x2, w2, mult_out2);
    fp_multiplier multi3(x3, w3, mult_out3);
    fp_multiplier multi4(x4, w4, mult_out4);

    group_4_registers mult_registers(clk, rst, mult_write,
        mult_out1, mult_out2, mult_out3, mult_out4,
        add_in1, add_in2, add_in3, add_in4);

    fp_adder adder1_1(add_in1, add_in2, add_out1);
    fp_adder adder1_2(add_in3, add_in4, add_out2);

    fp_adder adder2_1(add_out1, add_out2, a);
endmodule
