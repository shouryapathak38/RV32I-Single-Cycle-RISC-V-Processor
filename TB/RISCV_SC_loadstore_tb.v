`timescale 1ns/1ps

module RISCV_SC_loadstore_tb;

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
        $monitor("T=%0t PC=%h Instr=%h MemRW=%b ALUControl=%h IEUAdr=%h ReadData=%h",
                  $time, dut.pc, dut.instruction, dut.MemRW, dut.ALUControl, dut.IEUAdr, dut.read_data);
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
        $display("Final register check (after full load/store program)");
        $display("===================================================");
        check("x1 == 100        (base address)",              `X1, 32'd100);
        check("x2 == 0xFFFFFFFF (addi -1)",                    `X2, 32'hFFFFFFFF);
        check("x3 == 0xFFFFFFFF (sw/lw round-trip)",           `X3, 32'hFFFFFFFF);
        check("x4 == 0xFFFFFFFF (lb sign-extends 0xFF)",       `X4, 32'hFFFFFFFF);
        check("x5 == 0x000000FF (lbu zero-extends 0xFF)",      `X5, 32'h000000FF);
        check("x6 == 0xFFFFFFFF (lh sign-extends 0xFFFF)",     `X6, 32'hFFFFFFFF);
        check("x7 == 0x0000FFFF (lhu zero-extends 0xFFFF)",    `X7, 32'h0000FFFF);
        check("x8 == 0x00000000 (neighbor byte untouched)",    `X8, 32'h00000000);

        $display("===================================================");
        $display("RESULTS: PASS = %0d   FAIL = %0d", pass_count, fail_count);
        $display("===================================================");

        $stop;
    end

endmodule