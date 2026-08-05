module execute_top(

    // datapath values coming in from decode stage / fetch stage
    input  wire [31:0] rs1_data,
    input  wire [31:0] rs2_data,
    input  wire [31:0] immExt,
    input  wire [31:0] PC,

    // control signals coming in from control_unit_top (via decode_top)
    input  wire [1:0]  ALUSrc,
    input  wire [3:0]  ALUControl,

    // outputs
    output wire [31:0] ALUResult,   // goes to ResultSrc mux (writeback path)
    output wire [31:0] IEUAdr       // goes to data_memory address port

);

    wire [31:0] SrcA;
    wire [31:0] SrcB;

    srcA_mux u_srcA_mux(
        .rs1_data (rs1_data),
        .PC       (PC),
        .SrcA_sel (ALUSrc[1]),
        .SrcA     (SrcA)
    );

    srcB_mux u_srcB_mux(
        .rs2_data (rs2_data),
        .immExt   (immExt),
        .SrcB_sel (ALUSrc[0]),
        .SrcB     (SrcB)
    );

    alu u_alu(
        .SrcA       (SrcA),
        .SrcB       (SrcB),
        .ALUControl (ALUControl),
        .ALUResult  (ALUResult),
        .IEUAdr     (IEUAdr)
    );

endmodule