module datapath(
    input clk,
    input rst,
    input main_write,
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

    reg[31:0] x1, x2, x3, x4, b1, b2, b3, b4,
    act_in1, act_in2, act_in3, act_in4,
    act_out1, act_out2, act_out3, act_out4;

    group_4_registers main_registers(clk, rst, main_write,
        num1, num2, num3, num4, x1, x2, x3, x4);

    mux_2_to_1 input_mux1(x1, b1, s1, act_in1);
    mux_2_to_1 input_mux2(x2, b2, s2, act_in2);
    mux_2_to_1 input_mux3(x3, b3, s3, act_in3);
    mux_2_to_1 input_mux4(x4, b4, s4, act_in4);

    group_4_registers activation_registers(clk, rst, actWrite,
        act_in1, act_in2, act_in3, act_in4,
        act_out1, act_out2, act_out3, act_out4);
    
    
endmodule