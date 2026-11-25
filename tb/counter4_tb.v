`timescale 1ns/1ps

module counter4_tb;
    reg        clk;
    reg        rst;
    wire [3:0] count;

    counter4 dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/counter4.vcd");
        $dumpvars(0, counter4_tb);

        rst = 1;
        #22;
        rst = 0;
        #200;
        $finish;
    end

    always @(negedge clk)
        $display("time=%0d ns rst=%b count=%0d", $time, rst, count);
endmodule