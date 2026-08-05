`timescale 1ns/1ps

module RISCV_SC_jumps_tb;

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
    `define X7 dut.u_decode_top.u_register_file.reg_file[7]
    `define X8 dut.u_decode_top.u_register_file.reg_file[8]

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
        $monitor("T=%0t PC=%h Instr=%h Jump=%b PCSrc=%b IEUAdr=%h",
                  $time, dut.pc, dut.instruction, dut.Jump, dut.PCSrc, dut.IEUAdr);
    end

    initial begin
        clk = 0;
        rst = 1;
        @(negedge clk);
        rst = 0;

        // 11 real instructions + headroom
        repeat (12) @(posedge clk);
        #1;

        $display("===================================================");
        $display("Final register check (after full jumps/LUI/AUIPC program)");
        $display("===================================================");
        check("x1 == 0x12345678 (lui+addi build full constant)", `X1, 32'h12345678);
        check("x2 == 8           (auipc = PC+0)",                 `X2, 32'd8);
        check("x3 == 16          (jal return addr = PC+4)",       `X3, 32'd16);
        check("x4 == 0           (skipped by jal)",               `X4, 32'd0);
        check("x5 == 0           (base addr for jalr)",           `X5, 32'd0);
        check("x6 == 32          (jalr return addr = PC+4)",      `X6, 32'd32);
        check("x7 == 0           (skipped by jalr)",              `X7, 32'd0);
        check("x8 == 55          (jalr landing pad executed)",    `X8, 32'd55);

        $display("===================================================");
        $display("RESULTS: PASS = %0d   FAIL = %0d", pass_count, fail_count);
        $display("===================================================");

        $stop;
    end

endmodule