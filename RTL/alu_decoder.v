module alu_decoder(
    input  wire [1:0] ALUOp,
    input  wire [2:0] funct3,
    input  wire       funct7_5,
    input  wire       opb5,       // Instr[5]: 1 = R-type, 0 = I-type (needed to disambiguate ADD/SUB)
    output reg  [3:0] ALUControl
);
//=====================================================
// ALU Control Encoding
//=====================================================
localparam ALU_ADD   = 4'b0000;
localparam ALU_SUB   = 4'b0001;
localparam ALU_SLL   = 4'b0010;
localparam ALU_SLT   = 4'b0011;
localparam ALU_SLTU  = 4'b0100;
localparam ALU_XOR   = 4'b0101;
localparam ALU_SRL   = 4'b0110;
localparam ALU_SRA   = 4'b0111;
localparam ALU_OR    = 4'b1000;
localparam ALU_AND   = 4'b1001;
localparam ALU_PASSB = 4'b1010;   // pass SrcB straight through (used for LUI)

//=====================================================
// ALUOp Encoding
//=====================================================
localparam ALU_ADD_OP = 2'b00;
localparam ALU_BRANCH = 2'b01;
localparam ALU_FUNC   = 2'b10;
localparam ALU_LUI    = 2'b11;

//=====================================================
always @(*) begin
    ALUControl = ALU_ADD;
    case(ALUOp)

    // ADD Operations (loads, stores, AUIPC, JAL, JALR)
    ALU_ADD_OP :
        ALUControl = ALU_ADD;

    // Branch Target Address Calculation (PC + ImmExt)
    ALU_BRANCH :
        ALUControl = ALU_ADD;

    // LUI: bypass ALU, just pass ImmExt (SrcB) through
    ALU_LUI :
        ALUControl = ALU_PASSB;

    
    // Decode using funct3/funct7 (R-type and I-type ALU ops)
    ALU_FUNC :
    begin
        case(funct3)
        3'b000 :
        begin
            // funct7_5 only means SUB for R-type (opb5=1).
            // For I-type (addi), bit 30 is part of the immediate, not funct7 -> must always ADD.
            if(funct7_5 & opb5)
                ALUControl = ALU_SUB;
            else
                ALUControl = ALU_ADD;
        end
        3'b001 : ALUControl = ALU_SLL;
        3'b010 : ALUControl = ALU_SLT;
        3'b011 : ALUControl = ALU_SLTU;
        3'b100 : ALUControl = ALU_XOR;
        3'b101 :
        begin
            // srli/srai DO encode a real funct7[5] bit even in I-type,
            // so no opb5 guard needed here.
            if(funct7_5)
                ALUControl = ALU_SRA;
            else
                ALUControl = ALU_SRL;
        end
        3'b110 : ALUControl = ALU_OR;
        3'b111 : ALUControl = ALU_AND;
        default :
            ALUControl = ALU_ADD;
        endcase
    end

    default :
        ALUControl = ALU_ADD;
    endcase
end
endmodule