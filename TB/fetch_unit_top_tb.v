module fetch_unit_top_tb;
    reg         clk;
    reg         rst;
    reg         pc_src;
    reg [31:0]  pc_target;

    wire [31:0] pc;
    wire [31:0] instruction;

    // DUT
    fetch_unit_top dut (
        .clk(clk),
        .rst(rst),
        .pc_src(pc_src),
        .pc_target(pc_target),
        .pc(pc),
        .instruction(instruction)
    );

    // Clock generation (10 ns period)
    always #5 clk = ~clk;

    initial begin

        // Initialize signals
        clk       = 0;
        rst       = 1;
        pc_src    = 0;
        pc_target = 32'd0;

        #10;
        rst = 0;

        // Fetch instructions sequentially
        #50;

        // Test a branch
        pc_target = 32'd32;
        pc_src    = 1;

        #10;

        // Return to sequential execution
        pc_src = 0;

        #40;

        $finish;

    end
endmodule