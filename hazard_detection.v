// Módulo responsável por detectar conflitos que exigem uma parada (stall) no pipeline
module hazard_detection (
    input clk,
    input rst,
    input [4:0] IFID_rs1, // Registrador usado na instrução atual
    input [4:0] IFID_rs2, // Registrador usado na instrução atual
    input [4:0] IDEX_rd, //Registrador usado na instrução anterior
    input IDEX_MemRead, // Verifica se instrução anterior leu a memória
    input [31:0] IFID_instruction, // Instrução completa para decodificação do tipo de instrução (ex: desvio).

    // Saídas de controle para parar o pipeline.
    output reg PCWrite,
    output reg IFIDWrite,
    output reg ControlMux
);

    reg [1:0] beq_stall_counter; // Contador para implementar um stall de 2 ciclos

    // --- LÓGICA SEQUENCIAL PARA O CONTADOR DE STALL DE DESVIO ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            beq_stall_counter <= 2'b00;
        end else begin
            if ((IFID_instruction[6:0] == 7'b1100011/* SE DESVIO*/) && beq_stall_counter == 2'b00) begin
                beq_stall_counter <= 2'b10;
            end 
            else if (beq_stall_counter > 2'b00) begin
                beq_stall_counter <= beq_stall_counter - 1;
            end
        end
    end

    // --- LÓGICA COMBINACIONAL PARA GERAR OS SINAIS DE STALL ---
    always @(*) begin
        // Verifica se há load-use
        if (IDEX_MemRead &&
            ((IDEX_rd == IFID_rs1) || (IDEX_rd == IFID_rs2)) && (IDEX_rd != 0)) begin
            PCWrite = 0; // Não avança o PC
            IFIDWrite = 0; // Congele a instrução na fase ID.
            ControlMux = 1; // Injete um NOP
        end
        // Verifica se está em stall calculado anteriormente
        else if (beq_stall_counter > 2'b00) begin
            PCWrite = 0;
            IFIDWrite = 0;
            ControlMux = 1;
        end 
        else begin
            PCWrite = 1;
            IFIDWrite = 1;
            ControlMux = 0;
        end
    end

endmodule