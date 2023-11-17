module Encoder4to2(input p0, p1, p2, p3, output reg [1:0] out);

always @(*) begin
    case ({p3, p2, p1, p0})
        4'b1110: out = 2'b00;
        4'b1101: out = 2'b01;
        4'b1011: out = 2'b10;
        4'b0111: out = 2'b11;
        default: out = 2'b00; // check z or x value aswell.
    endcase
end

endmodule