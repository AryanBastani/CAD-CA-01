module Maxnet(
    input clk,
    input rst,
    input start,
    input[31:0] epsilon,
    input[31:0] num1, num2, num3, num4,
    output done,
    output[31:0] max
);

wire actWrite, addWrite, multWrite,
    mainRegWrite, s1, s2, s3, s4;

wire found;

datapath my_datapath(
    clk,
    rst,
    actWrite,
    addWrite,
    multWrite,
    mainRegWrite,
    s1, s2, s3, s4,
    epsilon,
    num1, num2, num3, num4,
    found,
    max
);

controller my_controller(
    clk,
    rst,
    found,
    start,
    done,
    actWrite,
    addWrite,
    multWrite,
    mainRegWrite,
    s1, s2, s3, s4);

endmodule