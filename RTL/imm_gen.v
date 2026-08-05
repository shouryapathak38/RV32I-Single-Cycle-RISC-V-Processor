module imm_gen(
    input  wire [31:0] instruction,
    input  wire [2:0]  ImmSrc,

    output reg  [31:0] immExt
);

always @(*) begin
    case (ImmSrc)

        // I-Type
        3'b000:
            immExt = {{20{instruction[31]}},
                       instruction[31:20]};

        // S-Type
        3'b001:
            immExt = {{20{instruction[31]}},
                       instruction[31:25],
                       instruction[11:7]};

        // B-Type
        3'b010:
            immExt = {{19{instruction[31]}},
                       instruction[31],
                       instruction[7],
                       instruction[30:25],
                       instruction[11:8],
                       1'b0};

        // U-Type
        3'b011:
            immExt = {instruction[31:12], 12'b0};

        // J-Type
        3'b100:
            immExt = {{11{instruction[31]}},
                       instruction[31],
                       instruction[19:12],
                       instruction[20],
                       instruction[30:21],
                       1'b0};

        default:
            immExt = 32'd0;
    endcase
end
endmodule