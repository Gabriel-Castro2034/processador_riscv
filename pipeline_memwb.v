// MEM/WB Pipeline Register
module pipeline_memwb (
    input wire clk,
    input wire rst,
    input wire [31:0] exmem_ula_result,
    input wire [31:0] mem_read_data,
    input wire [4:0] exmem_rd,
    input wire exmem_RegWrite,
    input wire exmem_MemtoReg,
    output reg [31:0] memwb_ula_result,
    output reg [31:0] memwb_mem_data,
    output reg [4:0] memwb_rd,
    output reg memwb_RegWrite,
    output reg memwb_MemtoReg
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            memwb_ula_result <= 32'b0;
            memwb_mem_data <= 32'b0;
            memwb_rd <= 5'b0;
            memwb_RegWrite <= 1'b0;
            memwb_MemtoReg <= 1'b0;
        end else begin
            memwb_ula_result <= exmem_ula_result;
            memwb_mem_data <= mem_read_data;
            memwb_rd <= exmem_rd;
            memwb_RegWrite <= exmem_RegWrite;
            memwb_MemtoReg <= exmem_MemtoReg;
        end
    end

endmodule