//Armazena os 32 registradores do processador (x0 a x31), permitindo a leitura de dois registradores e a escrita em um por ciclo de clock.
module bancoreg (
    input wire        clk,				//Clock
    input wire        write_enable, //Permite escrita
    input wire [4:0]  regaddr1,		//Endereço do primeiro registrador
    input wire [4:0]  regaddr2,		//Endereço do segundo registrador
    input wire [4:0]  write,			//Endereço do registrador que vai receber a escrita
    input wire [31:0] data,			//Valor a ser escrito no registrador
    output reg [31:0] read1,			//Leitura do registrador 1
    output reg [31:0] read2			//Leitura do registrador 2
);
    //Banco de registradores de 32 bits
    reg [31:0] mem [31:0];

    always @(posedge clk) begin
    // Na borda de subida escreve no registrador
        if (write_enable && (write != 5'd0)) begin
            mem[write] <= data;
        end
    end

    always @(*) begin
    // Lê os registradores assíncronamente
        if (regaddr1 == 5'd0) begin
            read1 = 32'd0;
        end else begin
            read1 = mem[regaddr1];
        end

        if (regaddr2 == 5'd0) begin
            read2 = 32'd0;
        end else begin
            read2 = mem[regaddr2];
        end
    end

endmodule