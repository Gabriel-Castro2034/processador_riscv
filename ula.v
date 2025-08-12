// Executa as operações matemáticas e lógicas sobre dois valores de entrada, com flags para indicar coisas sobre os resultados.
module ula (
    input [31:0] A, 				//Entrada A
    input [31:0] B, 				//Entrada B
    input [2:0] ULAControl, 	//Sinal que indica operação
    output reg [31:0] result, //Resultado
    output reg [2:0] flags 	//Flags: [2]=Overflow, [1]=Carry, [0]=Zero
);

    reg [32:0] temp;
    reg overflow_val;
    reg carry_val;
    reg zero_val;

    always @(*) begin
        case(ULAControl)
            3'b000: temp = A - B;         // sub
            3'b001: temp = A ^ B;         // xor
            3'b010: temp = A + B;         // addi, lw, sw
            3'b011: temp = A >> B[4:0];   // srl
            3'b100: temp = A - B;         // beq
            default: temp = 33'hxxxxxxxx;
        endcase

        result = temp[31:0];
        overflow_val = temp[32] ^ temp[31];
        carry_val = temp[32];
        zero_val = (result == 32'd0);

        case(ULAControl)
            3'b000, 3'b010:
                flags = {overflow_val, carry_val, zero_val};
            
            3'b100:
                flags = {1'b0, 1'b0, zero_val};
            
            default:	
                flags = 3'b000;
        endcase
    end

endmodule