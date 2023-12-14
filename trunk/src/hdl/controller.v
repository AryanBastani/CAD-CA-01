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
        state6 = 3'b110,
        state7 = 3'b111;

    reg [2:0] ps = state0;
    reg [2:0] ns;

    always@(ps or start or found)
    begin
        ns = state0;
        case (ps)
            state0: ns = start ? state1 : state0;
            state1: ns = state2;
            state2: ns = state3;
            state3: ns = state4;
            state4: ns = state5;
            state5: ns = found ? state7 : state6;
            state6: ns = state3;
            state7: ns = state0;
        endcase
    end

    always @(ps) begin
        {done, actWrite, multWrite, mainRegWrite, addWrite} = 5'b0;
        case (ps)
            state0: ;
            state1: mainRegWrite = 1;
            state2: {s1, s2, s3, s4, actWrite} = 5'b00001;
            state3: multWrite = 1;
            state4: addWrite = 1;
            state5: ;
            state6: {s1, s2, s3, s4, actWrite} = 5'b11111;
            state7: done = 1;
        endcase
    end
    
    always @(posedge clk, posedge rst) begin
        if(rst)
            ps <= state0;
        else
            ps <= ns;
    end
    
endmodule
