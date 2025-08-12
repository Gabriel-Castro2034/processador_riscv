// Gera os sinais de controle com base no Opcode da instrução.
module control_unit (
    input wire [6:0] Opcode,

    
    output reg       RegWrite,	//Indica se resultado vai ser salvo em um registrador
    output reg       MemRead,		//Indica se vai ler da memória
    output reg       MemWrite,	//Indica que vai escrever na memória
    output reg       MemtoReg,	//0 = salva resultado da ULA, 1 = salva o dado da memória
    output reg       ULASrc,		//Indica se tem valor imediato a ser usado
    output reg       Branch,		//Indica que a instrução é desvio
    output reg [1:0] ULAOp			//Indica o tipo de operação da ULA
);


    localparam OPCODE_LW   = 7'b0000011;
    localparam OPCODE_SW   = 7'b0100011;
    localparam OPCODE_ADDI = 7'b0010011;
    localparam OPCODE_R    = 7'b0110011;
    localparam OPCODE_BEQ  = 7'b1100011;

    
    always @(*) begin
        RegWrite = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        MemtoReg = 1'b0;
        ULASrc   = 1'b0;
        Branch   = 1'b0;
        ULAOp    = 2'bxx;

        case (Opcode)
            // lw
            OPCODE_LW: begin
                ULASrc   = 1'b1;
                MemtoReg = 1'b1;
                RegWrite = 1'b1;
                MemRead  = 1'b1;
                ULAOp    = 2'b00;
            end

            // sw
            OPCODE_SW: begin
                ULASrc   = 1'b1;
                MemWrite = 1'b1;
                ULAOp    = 2'b00;
            end

            // addi
            OPCODE_ADDI: begin
                ULASrc   = 1'b1;
                RegWrite = 1'b1;
                ULAOp    = 2'b11;
            end

            // sub, xor, srl
            OPCODE_R: begin
                RegWrite = 1'b1;
                ULAOp    = 2'b10;
            end

            // beq
            OPCODE_BEQ: begin
                Branch = 1'b1;
                ULAOp  = 2'b01;
            end
        endcase
    end

endmodule