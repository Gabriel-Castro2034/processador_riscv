//Simula uma memória ROM que armazena o programa (programa.hex) e o entrega ao processador quando um endereço é solicitado.
module instruction_memory (
    input  wire [31:0] Address,
    output wire [31:0] Instruction
);

    reg [31:0] mem [0:1023];
    integer i;

    initial begin
        mem[0] = 32'h03200293;  // addi x5, x0, 50
        mem[1] = 32'h00a00313;  // addi x6, x0, 10
        mem[2] = 32'h00502023;  // sw x5, 0(x0)
        mem[3] = 32'h00002383;  // lw x7, 0(x0)
        mem[4] = 32'h40638533;  // sub x10, x7, x6
        mem[5] = 32'h01900593;  // addi x11, x0, 25
        mem[6] = 32'h00b54633;  // xor x12, x10, x11
        mem[7] = 32'h00200693;  // addi x13, x0, 2
        mem[8] = 32'h00d65733;  // srl x14, x12, x13
        mem[9] = 32'h00c00793;  // addi x15, x0, 12
        mem[10] = 32'h00f70463; // beq x14, x15, 8
        mem[11] = 32'h3e700093; // addi x1, x0, 999
        mem[12] = 32'h06300813; // addi x16, x0, 99
        mem[13] = 32'h01070663; // beq x14, x16, 12
        mem[14] = 32'h00e02423; // sw x14, 8(x0)
        mem[15] = 32'h00000463; // beq x0, x0, 8
        mem[16] = 32'h00102423; // sw x1, 8(x0)
        mem[17] = 32'h00000063; // beq x0, x0, 0
        
        // Memória restante = 0
        for (i = 18; i < 1024; i = i + 1) begin
            mem[i] = 32'h00000000;
        end
    end

    assign Instruction = mem[Address[31:2]];

endmodule