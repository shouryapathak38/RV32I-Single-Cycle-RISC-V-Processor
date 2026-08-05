module instruction_memory(
    input  wire [31:0] addr,
    output wire [31:0] instr
);

    reg [31:0] mem [0:255];

    initial begin
        $readmemh("programs/program_all37.mem", mem);// for synthsis have to have it while simulation to progeams/program_all37.mem
    end

    assign instr = mem[addr[31:2]]; //The PC is a byte address, but the memory array is indexed by instruction number (word address). Since each instruction is 4 bytes, we ignore the lowest two bits.

endmodule