module branch_decision (

    input  wire       Branch,
    input  wire [2:0] funct3,
    input  wire [2:0] Flags,

    output reg        BranchTaken

);

// Flags Encoding
// Flags[2] : Equal
// Flags[1] : Signed Less Than
// Flags[0] : Unsigned Less Than

wire Eq;
wire Lt;
wire Ltu;

assign Eq  = Flags[2];
assign Lt  = Flags[1];
assign Ltu = Flags[0];

// Branch Decision Logic

always @(*) begin

    BranchTaken = 1'b0;

    if (Branch) begin

        case (funct3)

            // BEQ
            3'b000 : BranchTaken = Eq;

            // BNE
            3'b001 : BranchTaken = ~Eq;

            // BLT
            3'b100 : BranchTaken = Lt;

            // BGE
            3'b101 : BranchTaken = ~Lt;

            // BLTU
            3'b110 : BranchTaken = Ltu;

            // BGEU
            3'b111 : BranchTaken = ~Ltu;

            default : BranchTaken = 1'b0;

        endcase

    end

end

endmodule