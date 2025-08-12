//Simula a memória RAM principal do sistema, onde o processador pode ler e escrever dados através das instruções lw e sw
module data_memory (
    input wire        clk,                //Clock
    input wire        MemWrite,           //Sinal de controle para escrita
    input wire        MemRead,            //Sinal de controle para leitura
    input wire [31:0] Address,            //Endereço de byte calculado pela ULA
    input wire [31:0] WriteData,          //Valor a ser escrito na memória
    input wire [2:0]  funct3,             //Usado para identificar o tamanho do acesso
    output reg [31:0] ReadData            //Valor lido
);

    // Memória de 4096 bytes
    reg [7:0] mem [0:4095];

    // --- LÓGICA DE ESCRITA (SÍNCRONA) ---
    always @(posedge clk) begin
        if (MemWrite) begin
            if (funct3 == 3'b010) begin
                // Armazena a palavra de 32 bits em 4 posições de memória de 8 bits
                mem[Address]   <= WriteData[7:0];
                mem[Address+1] <= WriteData[15:8];
                mem[Address+2] <= WriteData[23:16];
                mem[Address+3] <= WriteData[31:24];
            end
        end
    end

    // --- LÓGICA DE LEITURA (COMBINACIONAL) ---
    always @(*) begin
        if (MemRead) begin
            if (funct3 == 3'b010) begin
                // Lê 4 bytes da memória e os concatena para formar a palavra de 32 bits
                ReadData = {mem[Address+3], mem[Address+2], mem[Address+1], mem[Address]};
            end else begin
                // Se for uma instrução de load de outro tamanho, retorna indefinido
                ReadData = 32'hxxxxxxxx;
            end
        end else begin
            // Se não for uma operação de leitura, a saída é indefinida
            ReadData = 32'hxxxxxxxx;
        end
    end

endmodule