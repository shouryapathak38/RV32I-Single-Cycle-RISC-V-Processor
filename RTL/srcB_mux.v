module srcB_mux(

    input  wire [31:0] rs2_data,
    input  wire [31:0] immExt,
    input  wire        SrcB_sel,

    output wire [31:0] SrcB

);

assign SrcB = (SrcB_sel) ? immExt : rs2_data;

endmodule