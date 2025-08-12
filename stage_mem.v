// Acessa a memória, lê ou guarda
module stage_mem (
    input wire clk,
    input wire mem_read,
    input wire mem_write,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire [2:0] funct3,

    output wire [31:0] read_data
);

    data_memory dmem_inst (
        .clk(clk),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .Address(address),
        .WriteData(write_data),
        .funct3(funct3),
        .ReadData(read_data)
    );

endmodule