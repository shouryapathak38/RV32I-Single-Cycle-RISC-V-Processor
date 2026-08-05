module pc(
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] next_pc,

    output reg  [31:0] pc
);

always @(posedge clk)
begin
    if(rst)
        pc <= 32'd0;
    else
        pc <= next_pc;
end

endmodule