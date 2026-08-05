module fetch_unit_top 
 (
    input  wire        clk,
    input  wire        rst,
    input  wire        pc_src,
    input  wire [31:0] pc_target,

    output wire [31:0] pc,
    output wire [31:0] instruction,
    output wire [31:0] pc_plus4
);

wire [31:0] next_pc;


pc u_pc (
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc(pc)
);

pc_plus4 u_pc_plus4 (
    .pc(pc),
    .pc_plus4(pc_plus4)
);

pc_mux u_pc_mux (
    .pc_src(pc_src),
    .pc_plus4(pc_plus4),
    .pc_target(pc_target),
    .next_pc(next_pc)
);

instruction_memory u_instruction_memory (
    .addr(pc),
    .instr(instruction)
);

endmodule