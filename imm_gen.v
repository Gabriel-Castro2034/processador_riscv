// Gerador de Imediatos
module imm_gen (
    input wire [31:0] Instruction,
    output reg [31:0] Immediate
);

    // Opcodes para identificar o formato do imediato
    localparam OPCODE_L = 7'b0000011; // loads
    localparam OPCODE_S = 7'b0100011; // saves
    localparam OPCODE_I = 7'b0010011; // imediatos
    localparam OPCODE_B = 7'b1100011; // branches

    always @(*) begin
        case (Instruction[6:0]) 
            OPCODE_L, OPCODE_I:
                Immediate = {{20{Instruction[31]}}, Instruction[31:20]};
            
            OPCODE_S:
                Immediate = {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7]};
            
            OPCODE_B:
                Immediate = {{20{Instruction[31]}}, Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0};
            
            default:
                Immediate = 32'hxxxxxxxx;
        endcase
    end

endmodule