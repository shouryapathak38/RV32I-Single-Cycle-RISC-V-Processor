`timescale 1ns/1ps

module RISCV_SC_branch_tb;

    reg clk;
    reg rst;

    integer pass_count = 0;
    integer fail_count = 0;

    RISCV_SC dut(
        .clk (clk),
        .rst (rst)
    );

    always #5 clk = ~clk;

    `define X1 dut.u_decode_top.u_register_file.reg_file[1]
    `define X2 dut.u_decode_top.u_register_file.reg_file[2]
    `define X3 dut.u_decode_top.u_register_file.reg_file[3]
    `define X4 dut.u_decode_top.u_register_file.reg_file[4]
    `define X5 dut.u_decode_top.u_register_file.reg_file[5]
    `define X6 dut.u_decode_top.u_register_file.reg_file[6]

    task check;
        input [255:0] name;
        input [31:0]  actual;
        input [31:0]  expected;
        begin
            if (actual === expected) begin
                pass_count = pass_count + 1;
                $display("  PASS: %0s", name);
            end else begin
                fail_count = fail_count + 1;
                $display("  FAIL: %0s | expected=%h actual=%h", name, expected, actual);
            end
        end
    endtask

    initial begin
        $monitor("T=%0t PC=%h Instr=%h PCSrc=%b Branch=%b Flags=%b",
                  $time, dut.pc, dut.instruction, dut.PCSrc, dut.Branch, dut.Flags);
    end

    initial begin
        clk = 0;
        rst = 1;
        @(negedge clk);
        rst = 0;

        // Run enough cycles for all 10 real instructions + a couple NOPs
        repeat (11) @(posedge clk);
        #1;

        $display("===================================================");
        $display("Final register check (after full program execution)");
        $display("===================================================");
        check("x1 == 5  (addi x1,x0,5)",              `X1, 32'd5);
        check("x2 == 5  (addi x2,x0,5)",               `X2, 32'd5);
        check("x3 == 0  (skipped instrs never wrote)", `X3, 32'd0);
        check("x4 == 44 (branch target executed)",     `X4, 32'd44);
        check("x5 == 55 (bne not-taken, fell through)",`X5, 32'd55);
        check("x6 == 66 (beq not-taken, fell through)",`X6, 32'd66);

        $display("===================================================");
        $display("RESULTS: PASS = %0d   FAIL = %0d", pass_count, fail_count);
        $display("===================================================");

        $stop;
    end

endmodule