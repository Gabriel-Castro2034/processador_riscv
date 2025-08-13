//Simula uma memória ROM que armazena o programa (programa.hex) e o entrega ao processador quando um endereço é solicitado.
module instruction_memory (
    input  wire [31:0] Address,
    output wire [31:0] Instruction
);
    
    reg [31:0] mem [0:1023];
    assign Instruction = mem[Address[31:2]];


endmodule
