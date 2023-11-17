module floating_adder(
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
    reg [24:0] out_mantis;


    always @* begin
        a_sign = a[31];
        b_sign = b[31];
        a_exp = a[30:23] - 8'b01111111;
        b_exp = b[30:23] - 8'b01111111;
        a_mantis = {1'b1, a[22:0]};
        b_mantis = {1'b1, b[22:0]};

        b_mantis = (a_exp > b_exp) ? b_mantis >> (a_exp - b_exp) : b_mantis;
        b_exp = (a_exp > b_exp) ? a_exp : b_exp;
        a_mantis = (b_exp > a_exp) ? a_mantis >> (b_exp - a_exp) : a_mantis;
        a_exp = (b_exp > a_exp) ? b_exp : a_exp;

        if(a_sign ^ b_sign) begin
            out_sign = (a_mantis > b_mantis) ? a_sign : b_sign;
            if(a_sign) begin
                a_mantis = ~a_mantis + 1'b1;
            end
            else begin
                b_mantis = ~b_mantis + 1'b1;
            end
        end
        else begin
            out_sign = a_sign;
        end

        out_mantis = a_mantis + b_mantis;
        out_exp = a_exp;

        if(|out_mantis) begin
            if(out_mantis[24]) begin
                out_mantis = out_mantis >> 1;
                out_exp = out_exp + 1'b1;
            end
            while(!out_mantis[23]) begin
                out_mantis = out_mantis << 1;
                out_exp = out_exp - 1'b1;
            end
        end
	
	out_exp = out_exp + 8'b01111111;
    end

    assign out = {out_sign, out_exp, out_mantis[22:0]};
endmodule
