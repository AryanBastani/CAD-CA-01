module checkOnes(input p0, p1, p2, p3, output reg found);
    always @(*)begin
        case({p0, p1, p2, p3})
            4'b1110: found = 1'b1;
            4'b1101: found = 1'b1;
            4'b1011: found = 1'b1;
            4'b0111: found = 1'b1;
            default: found = 1'b0;  
        endcase
    end
endmodule
