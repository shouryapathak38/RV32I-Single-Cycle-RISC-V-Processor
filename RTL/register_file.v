module register_file(
    input  wire        clk,
    input  wire        reg_write,
    input  wire [4:0]  RA1,// source regiser 1
    input  wire [4:0]  RA2,// source regiser 2
    input  wire [4:0]  RA3,// destination regiser
    input  wire [31:0] write_data, // data to write

    output wire [31:0] rs1_data,
    output wire [31:0] rs2_data
);
    // 32 Registers (x0 to x31)
    reg [31:0] reg_file [0:31];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1)
        reg_file[i] = 32'd0;
end

// Asynchronous Read Ports
assign rs1_data = (RA1 == 5'd0) ? 32'd0 : reg_file[RA1];
assign rs2_data = (RA2 == 5'd0) ? 32'd0 : reg_file[RA2];

// Synchronous Write Port
always @(posedge clk) begin
    if (reg_write && (RA3 != 5'd0))
        reg_file[RA3] <= write_data;

    // x0 is always zero
    reg_file[0] <= 32'd0;
end
endmodule