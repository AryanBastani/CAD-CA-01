module activationFunction(input [31:0] in, output reg [31:0] out);

reg[31:0] zero_val = 32'h0;

// always @(*) begin
//     if (in <= zero_val) begin
//         out = 32'b0;
//     end else begin
//         out = in;
//     end
// end
assign out = (in[31]) ? zero_val : in;

endmodule
