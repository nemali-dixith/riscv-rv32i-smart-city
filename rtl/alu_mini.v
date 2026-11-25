module alu_mini (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [1:0] op,
    output reg  [7:0] result,
    output wire       zero
);
    always @(*) begin
        case (op)
            2'b00:   result = a + b;
            2'b01:   result = a - b;
            2'b10:   result = a & b;
            2'b11:   result = a | b;
            default: result = 8'd0;
        endcase
    end

    assign zero = (result == 8'd0);
endmodule