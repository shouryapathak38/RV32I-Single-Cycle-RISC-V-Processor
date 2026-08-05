module srcA_mux(

    input  wire [31:0] rs1_data,
    input  wire [31:0] PC,
    input  wire        SrcA_sel,

    output wire [31:0] SrcA

);

assign SrcA = (SrcA_sel) ? PC : rs1_data;

endmodule