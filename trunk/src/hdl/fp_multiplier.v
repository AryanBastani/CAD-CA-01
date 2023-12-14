module fp_multiplier(
    input [31:0]a,
    input [31:0]b,
    output reg  [31:0] out
);

    reg a_sign;
    reg b_sign;
    reg out_sign; 
    reg [7:0] a_exp;
    reg [7:0] b_exp;
    reg [7:0] out_exp;
    reg [23:0] a_mantis;
    reg [23:0] b_mantis;
    reg [47:0] mantis;
    reg [22:0] out_mantis;

    always@(*)
    begin
        a_sign = a[31];
        b_sign = b[31];

        a_exp = a[30:23];
        b_exp = b[30:23];

        a_mantis = {1'b1, a[22:0]};
        b_mantis = {1'b1, b[22:0]};


        if(a == 0 || b == 0) begin
            out = 0;
        end

        else begin
            out_exp = a_exp + b_exp - 127;
            mantis = a_mantis * b_mantis;

            out_sign = a_sign ^ b_sign;

            if(mantis[47])begin
                out_mantis = mantis[46:24];
                out_exp = out_exp + 1'b1;
            end
            else begin
                out_mantis = mantis[45:23];
            end

            out = {out_sign, out_exp, out_mantis};
        end
    end
endmodule
