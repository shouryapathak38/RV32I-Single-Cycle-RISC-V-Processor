`timescale 1ns/1ps

module RISCV_SC_all37_tb;

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
        input [511:0] name;
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
        $monitor("T=%0t PC=%h Instr=%h", $time, dut.pc, dut.instruction);
    end

    initial begin
        clk = 0;
        rst = 1;
        @(negedge clk);
        rst = 0;

        repeat (3) @(posedge clk); #1;
        check("R-type ADD: x3 == 17", `X3, 32'h00000011);

        repeat (1) @(posedge clk); #1;
        check("R-type SUB: x3 == 7", `X3, 32'h00000007);

        repeat (1) @(posedge clk); #1;
        check("R-type SLL: x3 == 384", `X3, 32'h00000180);

        repeat (1) @(posedge clk); #1;
        check("R-type SLT: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("R-type SLTU: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("R-type XOR: x3 == 9", `X3, 32'h00000009);

        repeat (1) @(posedge clk); #1;
        check("R-type SRL: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("R-type SRA: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("R-type OR: x3 == 13", `X3, 32'h0000000d);

        repeat (1) @(posedge clk); #1;
        check("R-type AND: x3 == 4", `X3, 32'h00000004);

        repeat (1) @(posedge clk); #1;
        check("I-type ADDI: x3 == 17", `X3, 32'h00000011);

        repeat (1) @(posedge clk); #1;
        check("I-type SLTI: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("I-type SLTIU: x3 == 0", `X3, 32'h00000000);

        repeat (1) @(posedge clk); #1;
        check("I-type XORI: x3 == 9", `X3, 32'h00000009);

        repeat (1) @(posedge clk); #1;
        check("I-type ORI: x3 == 13", `X3, 32'h0000000d);

        repeat (1) @(posedge clk); #1;
        check("I-type ANDI: x3 == 4", `X3, 32'h00000004);

        repeat (1) @(posedge clk); #1;
        check("I-type SLLI: x3 == 48", `X3, 32'h00000030);

        repeat (1) @(posedge clk); #1;
        check("I-type SRLI: x3 == 3", `X3, 32'h00000003);

        repeat (1) @(posedge clk); #1;
        check("I-type SRAI: x3 == 3 (positive, matches SRLI)", `X3, 32'h00000003);

        repeat (2) @(posedge clk); #1;
        check("BEQ correctly NOT taken: x3 == 111", `X3, 32'h0000006f);

        repeat (2) @(posedge clk); #1;
        check("BNE correctly TAKEN: x3 == 222", `X3, 32'h000000de);

        repeat (2) @(posedge clk); #1;
        check("BLT correctly NOT taken: x3 == 111", `X3, 32'h0000006f);

        repeat (2) @(posedge clk); #1;
        check("BGE correctly TAKEN: x3 == 222", `X3, 32'h000000de);

        repeat (2) @(posedge clk); #1;
        check("BLTU correctly NOT taken: x3 == 111", `X3, 32'h0000006f);

        repeat (2) @(posedge clk); #1;
        check("BGEU correctly TAKEN: x3 == 222", `X3, 32'h000000de);

        repeat (4) @(posedge clk); #1;
        check("LW round-trip: x3 == 0xFFFFFFFF", `X3, 32'hffffffff);

        repeat (2) @(posedge clk); #1;
        check("LB sign-extend: x3 == 0xFFFFFFFF", `X3, 32'hffffffff);

        repeat (1) @(posedge clk); #1;
        check("LBU zero-extend: x3 == 0x000000FF", `X3, 32'h000000ff);

        repeat (2) @(posedge clk); #1;
        check("LH sign-extend: x3 == 0xFFFFFFFF", `X3, 32'hffffffff);

        repeat (1) @(posedge clk); #1;
        check("LHU zero-extend: x3 == 0x0000FFFF", `X3, 32'h0000ffff);

        repeat (2) @(posedge clk); #1;
        check("LUI+ADDI build constant: x6 == 0x12345678", `X6, 32'h12345678);

        repeat (1) @(posedge clk); #1;
        check("AUIPC == its own PC (204): x7 == 204", `X7, 32'h000000cc);

        repeat (1) @(posedge clk); #1;
        check("JAL return addr: x8 == 212", `X8, 32'h000000d4);

        repeat (1) @(posedge clk); #1;
        check("JAL landed correctly, skipped 2 traps: x3 == 333", `X3, 32'h0000014d);

        repeat (1) @(posedge clk); #1;
        check("JALR return addr: x8 == 228", `X8, 32'h000000e4);

        repeat (1) @(posedge clk); #1;
        check("JALR landed correctly, skipped 2 traps: x3 == 444", `X3, 32'h000001bc);

        repeat (2) @(posedge clk); #1;

        $display("===================================================");
        $display("RESULTS: PASS = %0d   FAIL = %0d", pass_count, fail_count);
        $display("===================================================");

        $stop;
    end

endmodule