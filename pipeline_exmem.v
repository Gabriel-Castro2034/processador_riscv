// EX/MEM Pipeline Register
module pipeline_exmem (
    input wire clk,
    input wire rst,
    input wire [31:0] ex_branch_target,
    input wire [31:0] ex_ula_result,
    input wire [31:0] ex_store_data,
    input wire [4:0] idex_rd,
    input wire [2:0] idex_funct3,
    input wire idex_RegWrite,
    input wire idex_MemRead,
    input wire idex_MemWrite,
    input wire idex_MemtoReg,
    input wire idex_Branch,
    input wire ex_zero_flag,
    output reg [31:0] exmem_pc_target,
    output reg [31:0] exmem_ula_result,
    output reg [31:0] exmem_reg_data2,
    output reg [4:0] exmem_rd,
    output reg [2:0] exmem_funct3,
    output reg exmem_RegWrite,
    output reg exmem_MemRead,
    output reg exmem_MemWrite,
    output reg exmem_MemtoReg,
    output reg exmem_Branch,
    output reg exmem_zero_flag
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            exmem_pc_target <= 32'b0;
            exmem_ula_result <= 32'b0;
            exmem_reg_data2 <= 32'b0;
            exmem_rd <= 5'b0;
            exmem_funct3 <= 3'b0;
            exmem_RegWrite <= 1'b0;
            exmem_MemRead <= 1'b0;
            exmem_MemWrite <= 1'b0;
            exmem_MemtoReg <= 1'b0;
            exmem_Branch <= 1'b0;
            exmem_zero_flag <= 1'b0;
        end else begin
            exmem_pc_target <= ex_branch_target;
            exmem_ula_result <= ex_ula_result;
            exmem_reg_data2 <= ex_store_data;
            exmem_rd <= idex_rd;
            exmem_funct3 <= idex_funct3;
            exmem_RegWrite <= idex_RegWrite;
            exmem_MemRead <= idex_MemRead;
            exmem_MemWrite <= idex_MemWrite;
            exmem_MemtoReg <= idex_MemtoReg;
            exmem_Branch <= idex_Branch;
            exmem_zero_flag <= ex_zero_flag;
        end
    end

endmodule