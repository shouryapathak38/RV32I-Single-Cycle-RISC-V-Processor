module RISCV_SC(

    input wire clk,
    input wire rst

    // Debug outputs (temporary for synthesis)
   // output wire [31:0] pc_out,
   // output wire [31:0] instruction_out,
   // output wire [31:0] ALUResult_out,
   // output wire [31:0] IEUAdr_out,
   // output wire [31:0] ReadData_out,
    //output wire [31:0] Result_out

);

    // Inter-stage wires

    // Fetch stage outputs
    wire [31:0] pc;       //we remove this for syn. for perventing missing signal
    wire [31:0] instruction;
    wire [31:0] pc_plus4;

    // Decode stage outputs
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [31:0] immExt;
    wire        RegWrite;
    wire [1:0]  ResultSrc;
    wire        MemRW;
    wire        Jump;
    wire        Branch;
    wire [1:0]  ALUSrc;
    wire [3:0]  ALUControl;
    wire        PCSrc;

    // Comparator output
    wire [2:0]  Flags;

    // Execute stage outputs
    wire [31:0] ALUResult;
    wire [31:0] IEUAdr;

    // Memory stage output
    wire [31:0] read_data;

    // Writeback stage output
    wire [31:0] Result;

    // Fetch

    fetch_unit_top u_fetch_unit_top(
        .clk        (clk),
        .rst        (rst),
        .pc_src     (PCSrc),
        .pc_target  (IEUAdr),

        .pc         (pc),
        .instruction(instruction),
        .pc_plus4   (pc_plus4)
    );

    // Decode

    decode_top u_decode_top(
        .clk        (clk),
        .instruction(instruction),
        .write_data (Result),
        .Flags      (Flags),

        .rs1_data   (rs1_data),
        .rs2_data   (rs2_data),
        .immExt     (immExt),
        .RegWrite   (RegWrite),
        .ResultSrc  (ResultSrc),
        .MemRW      (MemRW),
        .Jump       (Jump),
        .Branch     (Branch),
        .ALUSrc     (ALUSrc),
        .ALUControl (ALUControl),
        .PCSrc      (PCSrc)
    );

    // Comparator (branch condition, taps rs1/rs2 directly)

    comparator u_comparator(
        .A     (rs1_data),
        .B     (rs2_data),
        .Flags (Flags)
    );

    // Execute

    execute_top u_execute_top(
        .rs1_data   (rs1_data),
        .rs2_data   (rs2_data),
        .immExt     (immExt),
        .PC         (pc),
        .ALUSrc     (ALUSrc),
        .ALUControl (ALUControl),

        .ALUResult  (ALUResult),
        .IEUAdr     (IEUAdr)
    );

    // Memory
    data_memory u_data_memory(
        .clk        (clk),
        .address    (IEUAdr),
        .write_data (rs2_data),
        .MemRW      (MemRW),
        .funct3     (instruction[14:12]),

        .read_data  (read_data)
    );

    // Writeback

    result_mux u_result_mux(
        .ALUResult (ALUResult),
        .ReadData  (read_data),
        .PCPlus4   (pc_plus4),
        .ResultSrc (ResultSrc),

        .Result    (Result)
    );

//======================================================
// Debug Outputs
//======================================================

//assign pc_out          = pc;
//assign instruction_out = instruction;
//assign ALUResult_out   = ALUResult;
//assign IEUAdr_out      = IEUAdr;
//assign ReadData_out    = read_data;
//assign Result_out      = Result;

endmodule