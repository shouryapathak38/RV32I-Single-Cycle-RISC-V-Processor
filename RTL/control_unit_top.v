module control_unit_top(

    input  wire [6:0] opcode,
    input  wire [2:0] funct3,
    input  wire       funct7_5,

    input  wire [2:0] Flags,

    output wire       RegWrite,
    output wire [1:0] ResultSrc,
    output wire       MemRW,
    output wire       Jump,
    output wire       Branch,
    output wire [1:0] ALUSrc,
    output wire [2:0] ImmSrc,
    output wire [3:0] ALUControl,
    output wire       PCSrc

);

// Internal Signals

wire [1:0] ALUOp;
wire       BranchTaken;
wire opcode5;

assign opcode5 = opcode[5];

// Main Decoder

main_decoder u_main_decoder(

    .opcode     (opcode),
    .RegWrite   (RegWrite),
    .ResultSrc  (ResultSrc),
    .MemRW      (MemRW),
    .Jump       (Jump),
    .Branch     (Branch),
    .ALUSrc     (ALUSrc),
    .ImmSrc     (ImmSrc),
    .ALUOp      (ALUOp)

);

// ALU Decoder

alu_decoder u_alu_decoder(

    .ALUOp      (ALUOp),
    .funct3     (funct3),
    .funct7_5   (funct7_5),
    .opb5        (opcode5),
    .ALUControl (ALUControl)

);

// Branch Decision

branch_decision u_branch_decision(

    .Branch      (Branch),
    .funct3      (funct3),
    .Flags       (Flags),
    .BranchTaken (BranchTaken)

);

// PC Source Logic

assign PCSrc = Jump | BranchTaken;

endmodule