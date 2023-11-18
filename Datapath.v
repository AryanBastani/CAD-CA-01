module datapath(
    input clk,
    input rst,
    input actWrite,
    input addWrite,
    input multWrite,
    input mainRegWrite,
    input s1, s2, s3, s4,
    input[31:0] epsilon,
    input[31:0] num1, num2, num3, num4,
    output found,
    output[31:0] max
);

    wire[31:0] b1, b2, b3, b4;
    wire p1, p2 ,p3, p4;

    wire [1:0] encoder_out;
    wire [31:0] x1, x2, x3, x4, act_in1, act_in2, act_in3, act_in4,
        act_out1, act_out2, act_out3, act_out4,
        a1, a2, a3, a4,f_out1, f_out2, f_out3,
        f_out4;

    group_4_registers main_registers(clk, rst, mainRegWrite,
        num1, num2, num3, num4, x1, x2, x3, x4);

    mux_2_to_1 input_mux1(x1, b1, s1, act_in1);
    mux_2_to_1 input_mux2(x2, b2, s2, act_in2);
    mux_2_to_1 input_mux3(x3, b3, s3, act_in3);
    mux_2_to_1 input_mux4(x4, b4, s4, act_in4);

    group_4_registers activation_registers(clk, rst, actWrite,
        act_in1, act_in2, act_in3, act_in4,
        act_out1, act_out2, act_out3, act_out4);
    
    PU pu1(clk, rst, multWrite, act_out1, act_out2,
        act_out3, act_out4, 1, -epsilon, -epsilon, -epsilon, a1);
    PU pu2(clk, rst, multWrite, act_out1, act_out2,
        act_out3, act_out4, -epsilon, 1, -epsilon, -epsilon, a2);
    PU pu3(clk, rst, multWrite, act_out1, act_out2,
        act_out3, act_out4, -epsilon, -epsilon, 1, -epsilon, a3);
    PU pu4(clk, rst, multWrite, act_out1, act_out2,
        act_out3, act_out4, -epsilon, -epsilon, -epsilon, 1, a4);

    activationFunction f1(a1, f_out1);
    activationFunction f2(a2, f_out2);
    activationFunction f3(a3, f_out3);
    activationFunction f4(a4, f_out4);

    reg_32bit f_reg1(clk, rst, addWrite, f_out1, b1);
    reg_32bit f_reg2(clk, rst, addWrite, f_out2, b2);
    reg_32bit f_reg3(clk, rst, addWrite, f_out3, b3);
    reg_32bit f_reg4(clk, rst, addWrite, f_out4, b4);

    Comparator cmp1(0, b1, p1);
    Comparator cmp2(0, b2, p2);
    Comparator cmp3(0, b3, p3);
    Comparator cmp4(0, b4, p4);

    checkOnes chek_ones(p1, p2, p3, p4, found);
    
    Encoder4to2 encoder(p1, p2, p3, p4, encoder_out);

    mux_4to1 output_mux(x1, x2, x3, x4, encoder_out, max);
endmodule
