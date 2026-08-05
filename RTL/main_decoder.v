module main_decoder(

    input  wire [6:0] opcode,

    output reg        RegWrite,
    output reg [2:0]  ImmSrc,
    output reg [1:0]  ALUSrc,
    output reg        MemRW,
    output reg [1:0]  ResultSrc,
    output reg [1:0]  ALUOp,
    output reg        Branch,
    output reg        Jump

);

// RV32I Opcodes

localparam OPCODE_RTYPE   = 7'b0110011;
localparam OPCODE_ITYPE   = 7'b0010011;
localparam OPCODE_LOAD    = 7'b0000011;
localparam OPCODE_STORE   = 7'b0100011;
localparam OPCODE_BRANCH  = 7'b1100011;
localparam OPCODE_JALR    = 7'b1100111;
localparam OPCODE_JAL     = 7'b1101111;
localparam OPCODE_LUI     = 7'b0110111;
localparam OPCODE_AUIPC   = 7'b0010111;

// Immediate Type

localparam IMM_I = 3'b000;
localparam IMM_S = 3'b001;
localparam IMM_B = 3'b010;
localparam IMM_U = 3'b011;
localparam IMM_J = 3'b100;

// Result Source

localparam RESULT_ALU = 2'b00;
localparam RESULT_MEM = 2'b01;
localparam RESULT_PC4 = 2'b10;

// ALU Operation

localparam ALU_ADD    = 2'b00;
localparam ALU_BRANCH = 2'b01;
localparam ALU_FUNC   = 2'b10;
localparam ALU_LUI    = 2'b11;

// ALU Source
// ALUSrc[1] -> SrcA
// ALUSrc[0] -> SrcB
//
// 00 : rs1 , rs2
// 01 : rs1 , imm
// 10 : PC  , rs2
// 11 : PC  , imm


always @(*) begin

    // Default values

    RegWrite = 1'b0;
    ImmSrc   = IMM_I;
    ALUSrc   = 2'b00;
    MemRW    = 1'b0;
    ResultSrc= RESULT_ALU;
    ALUOp    = ALU_ADD;
    Branch   = 1'b0;
    Jump     = 1'b0;

    case(opcode)

    // R-Typ

    OPCODE_RTYPE:
    begin
        RegWrite = 1'b1;
        ALUSrc   = 2'b00;
        ResultSrc= RESULT_ALU;
        ALUOp    = ALU_FUNC;
    end

    // I-Type ALU
    
    OPCODE_ITYPE:
    begin
        RegWrite = 1'b1;
        ImmSrc   = IMM_I;
        ALUSrc   = 2'b01;
        ResultSrc= RESULT_ALU;
        ALUOp    = ALU_FUNC;
    end

    // LOAD

    OPCODE_LOAD:
    begin
        RegWrite = 1'b1;
        ImmSrc   = IMM_I;
        ALUSrc   = 2'b01;
        ResultSrc= RESULT_MEM;
        ALUOp    = ALU_ADD;
    end

    // STORE

    OPCODE_STORE:
    begin
        ImmSrc   = IMM_S;
        ALUSrc   = 2'b01;
        MemRW    = 1'b1;
        ALUOp    = ALU_ADD;
    end

    // BRANCH

    OPCODE_BRANCH:
    begin
        ImmSrc   = IMM_B;
        ALUSrc   = 2'b11;
        Branch   = 1'b1;
        ALUOp    = ALU_BRANCH;
    end

    // LUI

    OPCODE_LUI:
    begin
        RegWrite = 1'b1;
        ImmSrc   = IMM_U;
        ALUSrc   = 2'b01;
        ResultSrc= RESULT_ALU;
        ALUOp    = ALU_LUI;  // ← changed from ALU_ADD
    end

    // AUIPC

    OPCODE_AUIPC:
    begin
        RegWrite = 1'b1;
        ImmSrc   = IMM_U;
        ALUSrc   = 2'b11;
        ResultSrc= RESULT_ALU;
        ALUOp    = ALU_ADD;
    end

    // JAL

    OPCODE_JAL:
    begin
        RegWrite = 1'b1;
        Jump     = 1'b1;
        ImmSrc   = IMM_J;
        ALUSrc   = 2'b11;
        ResultSrc= RESULT_PC4;
        ALUOp    = ALU_ADD;
    end

    // JALR

    OPCODE_JALR:
    begin
        RegWrite = 1'b1;
        Jump     = 1'b1;
        ImmSrc   = IMM_I;
        ALUSrc   = 2'b01;
        ResultSrc= RESULT_PC4;
        ALUOp    = ALU_ADD;
    end

    default:
    begin
        RegWrite = 1'b0;
    end
    endcase
end
endmodule