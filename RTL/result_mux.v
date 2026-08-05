module result_mux(

    input  wire [31:0] ALUResult,
    input  wire [31:0] ReadData,   // from data_memory
    input  wire [31:0] PCPlus4,    // from fetch stage
    input  wire [1:0]  ResultSrc,

    output reg  [31:0] Result      // = write_data back into register_file

);
    localparam RESULT_ALU = 2'b00;
    localparam RESULT_MEM = 2'b01;
    localparam RESULT_PC4 = 2'b10;

    always @(*) begin
        case (ResultSrc)
            RESULT_ALU: Result = ALUResult;
            RESULT_MEM: Result = ReadData;
            RESULT_PC4: Result = PCPlus4;
            default:    Result = 32'd0;
        endcase
    end
endmodule