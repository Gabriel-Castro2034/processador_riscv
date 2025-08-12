// Gera o sinal de 3 bits que controla a operação da ULA
module ula_control (
    input wire [1:0]  ULAOp,   		// Comando da Unidade de Controle Principal
    input wire [2:0]  funct3,      // Campo da instrução
    input wire funct7_bit5,   	  // Bit 5 do funct7
    output reg [2:0]  ULAControl   // Saída para a ULA
);

    localparam ULA_SUB = 3'b000;
    localparam ULA_XOR = 3'b001;
    localparam ULA_ADD = 3'b010;
    localparam ULA_SRL = 3'b011;
	 localparam ULA_BEQ = 3'b100;

    always @(*) begin
        case (ULAOp)
            2'b00: ULAControl = ULA_ADD;
            2'b01: ULAControl = ULA_BEQ;
            2'b10: begin
                case (funct3)
                    3'b000: begin
                        if (funct7_bit5) 
									ULAControl = ULA_SUB;
                        else 
									ULAControl = 3'bxxx;
                    end
                    3'b100: ULAControl = ULA_XOR;
                    3'b101: ULAControl = ULA_SRL;
                    default: ULAControl = 3'bxxx;
                endcase
            end
            2'b11: begin
                case (funct3)
                    3'b000: ULAControl = ULA_ADD;
                    default: ULAControl = 3'bxxx;
                endcase
            end
            default: ULAControl = 3'bxxx;
        endcase
    end
endmodule