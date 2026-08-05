module RISCV_SC_TOP_tb;

reg clk;
reg rst;

RISCV_SC dut(
    .clk(clk),
    .rst(rst)
);

// Clock
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    // Run processor
    #500;

    $stop;
end

endmodule