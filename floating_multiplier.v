module floating_multiplier(
    input [31:0] a, b,
    output [31:0] out
);

    reg a_sign;
    reg b_sign;
    reg out_sign; 
    reg [7:0] a_exp;
    reg [7:0] b_exp;
    reg [7:0] out_exp;
    reg [23:0] a_mantis;
    reg [23:0] b_mantis;
    reg [47:0] out_mantis;


    always @* begin
        a_sign = a[31];
        b_sign = b[31];
        a_exp = a[30:23] - 8'b01111111;
        b_exp = b[30:23] - 8'b01111111;
        a_mantis = {1'b1, a[22:0]};
        b_mantis = {1'b1, b[22:0]};

        out_exp = a_exp + b_exp;
        out_sign = (a_sign ^ b_sign) ? 1'b1 : 1'b0;

        out_mantis = a_mantis * b_mantis;

        if(|out_mantis) begin
            while(!out_mantis[47]) begin
                out_mantis = out_mantis << 1;
                out_exp = out_exp - 1'b1;
            end
        end
	
	out_exp = out_exp + 8'b01111111;
    end

    assign out = {out_sign, out_exp, out_mantis[46:24]};
endmodule
