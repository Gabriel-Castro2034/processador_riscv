// ID/EX Pipeline Register
module pipeline_idex (
    input wire clk,
    input wire rst,
    input wire ControlMux,
    input wire [31:0] ifid_pc,
    input wire [31:0] ifid_pc_plus_4,
    input wire [31:0] id_reg_data1,
    input wire [31:0] id_reg_data2,
    input wire [31:0] id_immediate,
    input wire [4:0] ifid_rs1,
    input wire [4:0] ifid_rs2,
    input wire [4:0] ifid_rd,
    input wire [2:0] ifid_funct3,
    input wire ifid_funct7_bit5,
    input wire id_RegWrite,
    input wire id_MemRead,
    input wire id_MemWrite,
    input wire id_MemtoReg,
    input wire id_ULASrc,
    input wire id_Branch,
    input wire [1:0] id_ULAOp,
    output reg [31:0] idex_pc,
    output reg [31:0] idex_pc_plus_4,
    output reg [31:0] idex_reg_data1,
    output reg [31:0] idex_reg_data2,
    output reg [31:0] idex_imm,
    output reg [4:0] idex_rs1,
    output reg [4:0] idex_rs2,
    output reg [4:0] idex_rd,
    output reg [2:0] idex_funct3,
    output reg idex_funct7_bit5,
    output reg idex_RegWrite,
    output reg idex_MemRead,
    output reg idex_MemWrite,
    output reg idex_MemtoReg,
    output reg idex_ULASrc,
    output reg idex_Branch,
    output reg [1:0] idex_ULAOp
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            idex_pc <= 32'b0;
            idex_pc_plus_4 <= 32'b0;
            idex_reg_data1 <= 32'b0;
            idex_reg_data2 <= 32'b0;
            idex_imm <= 32'b0;
            idex_rs1 <= 5'b0;
            idex_rs2 <= 5'b0;
            idex_rd <= 5'b0;
            idex_funct3 <= 3'b0;
            idex_funct7_bit5 <= 1'b0;
            idex_RegWrite <= 1'b0;
            idex_MemRead <= 1'b0;
            idex_MemWrite <= 1'b0;
            idex_MemtoReg <= 1'b0;
            idex_ULASrc <= 1'b0;
            idex_Branch <= 1'b0;
            idex_ULAOp <= 2'b0;
        end else begin
            idex_pc <= ifid_pc;
            idex_pc_plus_4 <= ifid_pc_plus_4;
            idex_reg_data1 <= id_reg_data1;
            idex_reg_data2 <= id_reg_data2;
            idex_imm <= id_immediate;
            idex_rs1 <= ifid_rs1;
            idex_rs2 <= ifid_rs2;
            idex_rd <= ifid_rd;
            idex_funct3 <= ifid_funct3;
            idex_funct7_bit5 <= ifid_funct7_bit5;
            
            if (ControlMux) begin
                idex_RegWrite <= 1'b0;
                idex_MemRead <= 1'b0;
                idex_MemWrite <= 1'b0;
                idex_MemtoReg <= 1'b0;
                idex_ULASrc <= 1'b0;
                idex_Branch <= 1'b0;
                idex_ULAOp <= 2'b00;
            end else begin
                idex_RegWrite <= id_RegWrite;
                idex_MemRead <= id_MemRead;
                idex_MemWrite <= id_MemWrite;
                idex_MemtoReg <= id_MemtoReg;
                idex_ULASrc <= id_ULASrc;
                idex_Branch <= id_Branch;
                idex_ULAOp <= id_ULAOp;
            end
        end
    end

endmodule