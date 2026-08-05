module data_memory(

    input  wire        clk,
    input  wire [31:0] address,     // = IEUAdr from execute stage (byte address)
    input  wire [31:0] write_data,  // = rs2_data, store source
    input  wire        MemRW,       // 1 = write (store), 0 = read (load)
    input  wire [2:0]  funct3,      // selects byte/half/word width + signed/unsigned

    output reg  [31:0] read_data

);

    // byte-addressable memory array
    localparam MEM_SIZE_BYTES = 2048; // 2KB DTIM, adjust as needed
    reg [7:0] mem [0:MEM_SIZE_BYTES-1];

    integer i;
    initial begin
        for (i = 0; i < MEM_SIZE_BYTES; i = i + 1)
            mem[i] = 8'd0;
    end

    // Extract lower 11 bits to safely index the 2KB memory
    wire [10:0] byte_addr = address[10:0];

    // STORE path: funct3-driven byte-enable write
    
    always @(posedge clk) begin
        if (MemRW) begin
            case (funct3)
                3'b000: begin // SB - 1 byte
                    mem[byte_addr]         <= write_data[7:0];
                end
                3'b001: begin // SH - 2 bytes
                    mem[byte_addr]         <= write_data[7:0];
                    mem[byte_addr + 11'd1] <= write_data[15:8];
                end
                3'b010: begin // SW - 4 bytes
                    mem[byte_addr]         <= write_data[7:0];
                    mem[byte_addr + 11'd1] <= write_data[15:8];
                    mem[byte_addr + 11'd2] <= write_data[23:16];
                    mem[byte_addr + 11'd3] <= write_data[31:24];
                end
                default: begin
                    // unrecognized funct3 for a store: do nothing
                end
            endcase
        end
    end

    // LOAD path: raw byte/half/word read, then sign/zero-extend

    wire [7:0]  raw_byte = mem[byte_addr];
    wire [15:0] raw_half = {mem[byte_addr + 11'd1], mem[byte_addr]};
    wire [31:0] raw_word = {mem[byte_addr + 11'd3], mem[byte_addr + 11'd2],
                            mem[byte_addr + 11'd1], mem[byte_addr]};

    always @(*) begin
        case (funct3)
            3'b000:  read_data = {{24{raw_byte[7]}},  raw_byte};  // LB  - sign-extend
            3'b001:  read_data = {{16{raw_half[15]}}, raw_half};  // LH  - sign-extend
            3'b010:  read_data = raw_word;                        // LW  - no extend
            3'b100:  read_data = {24'd0, raw_byte};               // LBU - zero-extend
            3'b101:  read_data = {16'd0, raw_half};               // LHU - zero-extend
            default: read_data = 32'd0;
        endcase
    end
endmodule