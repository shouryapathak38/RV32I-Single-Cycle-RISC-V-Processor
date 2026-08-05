module pc_mux (
    input  wire        pc_src,
    input  wire [31:0] pc_plus4,
    input  wire [31:0] pc_target,

    output reg  [31:0] next_pc
);

always @(*) begin
    if (pc_src)
        next_pc = pc_target;
    else
        next_pc = pc_plus4;
end

endmodule