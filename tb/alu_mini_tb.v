`timescale 1ns/1ps

module alu_mini_tb;
    reg  [7:0] a, b;
    reg  [1:0] op;
    wire [7:0] result;
    wire       zero;
    integer    errors;

    alu_mini dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero)
    );

    task check;
        input [7:0] expected;
        begin
            #1;
            if (result !== expected) begin
                $display("FAIL: a=%0d b=%0d op=%b result=%0d expected=%0d",
                         a, b, op, result, expected);
                errors = errors + 1;
            end else begin
                $display("PASS: a=%0d b=%0d op=%b result=%0d zero=%b",
                         a, b, op, result, zero);
            end
        end
    endtask

    initial begin
        $dumpfile("sim/alu_mini.vcd");
        $dumpvars(0, alu_mini_tb);
        errors = 0;

        a = 8'd10;  b = 8'd5;   op = 2'b00; check(8'd15);
        a = 8'd10;  b = 8'd5;   op = 2'b01; check(8'd5);
        a = 8'hF0;  b = 8'h3C;  op = 2'b10; check(8'h30);
        a = 8'hF0;  b = 8'h0F;  op = 2'b11; check(8'hFF);
        a = 8'd7;   b = 8'd7;   op = 2'b01; check(8'd0);
        a = 8'd5;   b = 8'd10;  op = 2'b01; check(8'd251);
        a = 8'd200; b = 8'd100; op = 2'b00; check(8'd44);

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("%0d TESTS FAILED", errors);
        $finish;
    end
endmodule