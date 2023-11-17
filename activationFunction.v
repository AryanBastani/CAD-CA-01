module activationFunction(input [31:0] in, output reg [31:0] out);

always @(*) begin
    if (in <= 0) begin
        out = 32'b0;
    end else begin
        out = in;
    end
end

endmodule
