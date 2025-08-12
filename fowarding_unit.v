// Detecta dependências e "adianta" os resultados para ULA
module forwarding_unit (
    input [4:0] IDEX_rs1, // Registrador que a instrução ATUAL precisa ler 
    input [4:0] IDEX_rs2, // Registrador que a instrução ATUAL precisa ler
    input [4:0] EXMEM_rd, // Registrador usado na instrução anterior
    input EXMEM_RegWrite, // Verifica se a instrução escreveu em registradores
    input [4:0] MEMWB_rd, // Registrador usado na instrução antes da anterior
    input MEMWB_RegWrite, // Registrador usado na instrução  antes da anterior
    
    // Sinais de controle para os multiplexadores da ULA
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

    always @(*) begin
        // Rs1

        // A instrução na fase MEM precisa ser adiantada para rs1?
        if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs1))
            ForwardA = 2'b10;

        // Pergunta 2: Se não, a instrução na fase WB precisa ser adiantada para rs1?
        else if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rs1) &&
                 !((EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs1)))) // Garante a prioridade
            ForwardA = 2'b01;

        else
            ForwardA = 2'b00;

        // Rs2
        
        // Pergunta 1: A instrução na fase MEM precisa ser adiantada para rs2?
        if (EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs2))
            ForwardB = 2'b10;

        // Pergunta 2: Se não, a instrução na fase WB precisa ser adiantada para rs2?
        else if (MEMWB_RegWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rs2) &&
                 !((EXMEM_RegWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs2)))) // Garante a prioridade
            ForwardB = 2'b01;

        else
            ForwardB = 2'b00;
    end

endmodule