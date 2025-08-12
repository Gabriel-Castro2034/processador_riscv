// O que a instrução vai fazer
module stage_id (
    input wire clk,
    input wire [31:0] instruction,
    input wire [4:0] write_reg,
    input wire [31:0] write_data,
    input wire reg_write,

    output wire [31:0] reg_data1,
    output wire [31:0] reg_data2,
    output wire [31:0] immediate,
    output wire s_RegWrite,
    output wire s_MemRead,
    output wire s_MemWrite,
    output wire s_MemtoReg,
    output wire s_ULASrc,
    output wire s_Branch,
    output wire [1:0] s_ULAOp
);

    control_unit ctrl_inst (
        .Opcode(instruction[6:0]),
        .RegWrite(s_RegWrite),
        .MemRead(s_MemRead),
        .MemWrite(s_MemWrite),
        .MemtoReg(s_MemtoReg),
        .ULASrc(s_ULASrc),
        .Branch(s_Branch),
        .ULAOp(s_ULAOp)
    );

    imm_gen imm_gen_inst (
        .Instruction(instruction),
        .Immediate(immediate)
    );

    bancoreg breg_inst (
        .clk(clk),
        .write_enable(reg_write),
        .regaddr1(instruction[19:15]),
        .regaddr2(instruction[24:20]),
        .write(write_reg),
        .data(write_data),
        .read1(reg_data1),
        .read2(reg_data2)
    );

endmodule