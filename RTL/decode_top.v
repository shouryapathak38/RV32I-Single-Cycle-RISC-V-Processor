module decode_top(

    
    input  wire        clk,

    input  wire [31:0] instruction,

    // From Write-Back stage
    input  wire [31:0] write_data,

    // Comparator Flags
    input  wire [2:0] Flags,


    // Register Outputs
    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data,

    // Immediate Output
    output wire [31:0] immExt,

    // Control Outputs
    output wire        RegWrite,
    output wire [1:0]  ResultSrc,
    output wire        MemRW,
    output wire        Jump,
    output wire        Branch,
    output wire [1:0]  ALUSrc,
    output wire [3:0]  ALUControl,
    output wire        PCSrc

);

    //--------------------------------------------------
    // Internal Signals
    //--------------------------------------------------

    wire [2:0] ImmSrc;

    //--------------------------------------------------
    // Register File
    //--------------------------------------------------

    register_file u_register_file(

        .clk        (clk),
        .reg_write  (RegWrite),

        .RA1        (instruction[19:15]),
        .RA2        (instruction[24:20]),
        .RA3        (instruction[11:7]),

        .write_data (write_data),

        .rs1_data   (rs1_data),
        .rs2_data   (rs2_data)

    );

    //--------------------------------------------------
    // Immediate Generator
    //--------------------------------------------------

    imm_gen u_imm_gen(

        .instruction(instruction),
        .ImmSrc     (ImmSrc),
        .immExt      (immExt)

    );

    //--------------------------------------------------
    // Control Unit
    //--------------------------------------------------

    control_unit_top u_control_unit(

        .opcode     (instruction[6:0]),
        .funct3     (instruction[14:12]),
        .funct7_5   (instruction[30]),

        .Flags      (Flags),

        .RegWrite   (RegWrite),
        .ResultSrc  (ResultSrc),
        .MemRW      (MemRW),
        .Jump       (Jump),
        .Branch     (Branch),
        .ALUSrc     (ALUSrc),
        .ImmSrc     (ImmSrc),
        .ALUControl (ALUControl),
        .PCSrc      (PCSrc)

    );

endmodule