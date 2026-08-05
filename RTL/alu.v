module alu(

    input  wire [31:0] SrcA,
    input  wire [31:0] SrcB,
    input  wire [3:0]  ALUControl,

    output reg  [31:0] ALUResult,   // goes to writeback / ResultSrc mux path
    output wire [31:0] IEUAdr       // same value as ALUResult, exposed separately for PCnext
);

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
    localparam ALU_PASSB = 4'b1010;

    always @(*) begin
        case (ALUControl)
            ALU_ADD:   ALUResult = SrcA + SrcB;
            ALU_SUB:   ALUResult = SrcA - SrcB;
            ALU_SLL:   ALUResult = SrcA << SrcB[4:0];
            ALU_SLT:   ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'd1 : 32'd0;
            ALU_SLTU:  ALUResult = (SrcA < SrcB) ? 32'd1 : 32'd0;
            ALU_XOR:   ALUResult = SrcA ^ SrcB;
            ALU_SRL:   ALUResult = SrcA >> SrcB[4:0];
            ALU_SRA:   ALUResult = $signed(SrcA) >>> SrcB[4:0];
            ALU_OR:    ALUResult = SrcA | SrcB;
            ALU_AND:   ALUResult = SrcA & SrcB;
            ALU_PASSB: ALUResult = SrcB;
            default:   ALUResult = 32'h00000000;
        endcase
    end

    // IEUAdr is architecturally the same computation as ALUResult (per the
    // diagram: for loads/stores, ALUSrc = rs1+imm, and that same sum is both
    // the "ALU result" and the memory address). Exposed as a separate named
    // port purely so downstream wiring to data_memory's address input is
    // explicit and self-documenting -- it is not a different value.
    assign IEUAdr = ALUResult;

endmodule