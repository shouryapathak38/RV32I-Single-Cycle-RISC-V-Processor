module comparator(

    input  wire [31:0] A,
    input  wire [31:0] B,

    output reg [2:0] Flags

);

//=====================================================
// Flags Encoding
//=====================================================
// Flags[2] : Equal
// Flags[1] : Signed Less Than
// Flags[0] : Unsigned Less Than
//=====================================================

always @(*) begin

    // Default
    Flags = 3'b000;

    // Equal
    Flags[2] = (A == B);

    // Signed Less Than
    Flags[1] = ($signed(A) < $signed(B));

    // Unsigned Less Than
    Flags[0] = (A < B);

end

endmodule