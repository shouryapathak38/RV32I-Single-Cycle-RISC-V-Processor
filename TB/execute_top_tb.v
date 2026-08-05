`timescale 1ns/1ps

module execute_top_tb;

    // Inputs
    reg  [31:0] rs1_data;
    reg  [31:0] rs2_data;
    reg  [31:0] immExt;
    reg  [31:0] PC;

    reg  [1:0]  ALUSrc;
    reg  [3:0]  ALUControl;

    // Outputs
    wire [31:0] ALUResult;
    wire [31:0] IEUAdr;

    // DUT
    execute_top dut(
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .immExt(immExt),
        .PC(PC),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .IEUAdr(IEUAdr)
    );

    initial begin

        // Initialize
        rs1_data = 32'd20;
        rs2_data = 32'd5;
        immExt   = 32'd8;
        PC       = 32'd100;


        // Test 1 : ADD (rs1 + rs2)

        ALUSrc     = 2'b00;
        ALUControl = 4'b0000;
        #10;


        // Test 2 : SUB (rs1 - rs2)

        ALUSrc     = 2'b00;
        ALUControl = 4'b0001;
        #10;


        // Test 3 : ADDI (rs1 + imm)

        ALUSrc     = 2'b01;
        ALUControl = 4'b0000;
        #10;


        // Test 4 : AUIPC (PC + imm)

        ALUSrc     = 2'b11;
        ALUControl = 4'b0000;
        #10;


        // Test 5 : AND

        ALUSrc     = 2'b00;
        ALUControl = 4'b1001;
        #10;


        // Test 6 : OR

        ALUSrc     = 2'b00;
        ALUControl = 4'b1000;
        #10;


        // Test 7 : XOR

        ALUSrc     = 2'b00;
        ALUControl = 4'b0101;
        #10;


        // Test 8 : SLL

        ALUSrc     = 2'b00;
        ALUControl = 4'b0010;
        #10;


        // Test 9 : SRL

        ALUSrc     = 2'b00;
        ALUControl = 4'b0110;
        #10;


        // Test 10 : SRA

        rs1_data   = -32'sd16;
        rs2_data   = 32'd2;

        ALUSrc     = 2'b00;
        ALUControl = 4'b0111;
        #10;


        // Test 11 : SLT

        rs1_data   = -32'sd5;
        rs2_data   = 32'd4;

        ALUSrc     = 2'b00;
        ALUControl = 4'b0011;
        #10;


        // Test 12 : SLTU

        rs1_data   = 32'hFFFFFFFF;
        rs2_data   = 32'd1;

        ALUSrc     = 2'b00;
        ALUControl = 4'b0100;
        #10;


        // Test 13 : LUI (Pass Immediate)

        immExt     = 32'h12345000;

        ALUSrc     = 2'b01;
        ALUControl = 4'b1010;
        #10;

        $stop;

    end

endmodule