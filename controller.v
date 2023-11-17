module controller (
    input clk,
    input rst,
    input found,
    input start,
    output reg done,
    output reg actWrite,
    output reg addWrite,
    output reg multWrite,
    output reg mainRegWrite,
    output reg s1, s2, s3, s4);


    parameter [2:0]
        state0 = 3'b000,
        state1 = 3'b001,
        state2 = 3'b010,
        state3 = 3'b011,
        state4 = 3'b100,
        state5 = 3'b101,
        state6 = 3'b110;

    reg [2:0] ps = state0;
    reg [2:0] ns;

    always @(ps, start, found) begin
        ns = state0;
        {done, actWrite, multWrite, mainRegWrite, addWrite} = 5'b0;
        case (ps)
            state0: begin 
                if(start) begin
                    mainRegWrite = 1;
                    ns = state1;
                end
                else begin
                    ns = state0;
                end 
            end 
            state1: begin
                s1 = 0;
                s2 = 0;
                s3 = 0;
                s4 = 0;
                actWrite = 1;
                ns = state2;
            end
            state2: begin
                multWrite = 1;
                ns = state3;
            end
            state3: begin
                addWrite = 1;
                ns = state4;
            end
            state4: begin
                if (found)begin
                    ns = state6;
                end
                else begin
                    ns = state5;
                end
            end
            state5: begin
                s1 = 1;
                s2 = 1;
                s3 = 1;
                s4 = 1;
                actWrite = 1;
                ns = state2;
            end
            state6: begin
                done = 1;
                if (start)begin
                    ns = state1;
                end
                else begin
                    ns = state0;
                end
            end
        endcase
    end
    
    always @(posedge clk) begin
        ps <= ns;
    end
    
endmodule
