// Processador RISC-V Completamente Modular com Pipeline de 5 estágios
module processador (
    input wire clk,
    input wire rst
);

    // --- SINAIS DOS ESTÁGIOS ---
    
    // Estágio IF (Busca de Instrução)
    wire [31:0] if_pc_out, if_pc_plus_4, if_instruction;
    wire        pc_src;
    
    // Registrador de Pipeline IF/ID
    wire [31:0] ifid_pc, ifid_pc_plus_4, ifid_instruction;
    
    // Estágio ID (Decodificação de Instrução)
    wire [31:0] id_reg_data1, id_reg_data2, id_immediate;
    wire        id_RegWrite, id_MemRead, id_MemWrite, id_MemtoReg, id_ULASrc, id_Branch;
    wire [1:0]  id_ULAOp;
    
    // Registrador de Pipeline ID/EX
    wire [31:0] idex_pc, idex_pc_plus_4, idex_reg_data1, idex_reg_data2, idex_imm;
    wire [4:0]  idex_rs1, idex_rs2, idex_rd;
    wire [2:0]  idex_funct3;
    wire        idex_funct7_bit5;
    wire        idex_RegWrite, idex_MemRead, idex_MemWrite, idex_MemtoReg, idex_ULASrc, idex_Branch;
    wire [1:0]  idex_ULAOp;
    
    // Estágio EX (Execução)
    wire [31:0] ex_ula_result, ex_branch_target, ex_store_data;
    wire [2:0]  ex_ula_flags;
    
    // Registrador de Pipeline EX/MEM
    wire [31:0] exmem_pc_target, exmem_ula_result, exmem_reg_data2;
    wire [4:0]  exmem_rd;
    wire [2:0]  exmem_funct3;
    wire        exmem_RegWrite, exmem_MemRead, exmem_MemWrite, exmem_MemtoReg, exmem_Branch;
    wire        exmem_zero_flag;
    
    // Estágio MEM (Acesso à Memória)
    wire [31:0] mem_read_data;
    
    // Registrador de Pipeline MEM/WB
    wire [31:0] memwb_ula_result, memwb_mem_data;
    wire [4:0]  memwb_rd;
    wire        memwb_RegWrite, memwb_MemtoReg;
    
    // Estágio WB (Write-Back)
    wire [31:0] wb_write_back_data;
    
    // Detecção de Conflitos (Hazard)
    wire PCWrite, IFIDWrite, ControlMux;
    
    // Adiantamento (Forwarding)
    wire [1:0] ForwardA, ForwardB;

    // --- INSTANCIAÇÃO DOS ESTÁGIOS ---
    
    // Desvia quando a condição é atendida e limpa o pipeline
    // For BEQ: branch when zero flag is 1 (A == B)
    wire branch_condition_met = ex_ula_flags[0]; // zero flag
    wire branch_taken = idex_Branch && branch_condition_met;
    assign pc_src = branch_taken;
    
    // Limpa os registradores de pipeline quando o desvio é tomado
    wire flush_pipeline = branch_taken;
	 
	 // Estágio IF
    stage_if if_stage (
        .clk(clk),
        .rst(rst),
        .PCWrite(PCWrite),
        .pc_src(pc_src),
        .branch_target(ex_branch_target),
        .pc_out(if_pc_out),
        .pc_plus_4(if_pc_plus_4),
        .instruction(if_instruction)
    );

    // Registrador de Pipeline IF/ID
    pipeline_ifid ifid_reg (
        .clk(clk),
        .rst(rst),
        .IFIDWrite(IFIDWrite),
        .if_pc(if_pc_out),
        .if_pc_plus_4(if_pc_plus_4),
        .if_instruction(if_instruction),
        .ifid_pc(ifid_pc),
        .ifid_pc_plus_4(ifid_pc_plus_4),
        .ifid_instruction(ifid_instruction)
    );

    // Estágio ID
    stage_id id_stage (
        .clk(clk),
        .instruction(ifid_instruction),
        .write_reg(memwb_rd),
        .write_data(wb_write_back_data),
        .reg_write(memwb_RegWrite),
        .reg_data1(id_reg_data1),
        .reg_data2(id_reg_data2),
        .immediate(id_immediate),
        .s_RegWrite(id_RegWrite),
        .s_MemRead(id_MemRead),
        .s_MemWrite(id_MemWrite),
        .s_MemtoReg(id_MemtoReg),
        .s_ULASrc(id_ULASrc),
        .s_Branch(id_Branch),
        .s_ULAOp(id_ULAOp)
    );

    // Registrador de Pipeline ID/EX
    pipeline_idex idex_reg (
        .clk(clk),
        .rst(rst),
        .ControlMux(ControlMux),
        .ifid_pc(ifid_pc),
        .ifid_pc_plus_4(ifid_pc_plus_4),
        .id_reg_data1(id_reg_data1),
        .id_reg_data2(id_reg_data2),
        .id_immediate(id_immediate),
        .ifid_rs1(ifid_instruction[19:15]),
        .ifid_rs2(ifid_instruction[24:20]),
        .ifid_rd(ifid_instruction[11:7]),
        .ifid_funct3(ifid_instruction[14:12]),
        .ifid_funct7_bit5(ifid_instruction[30]),
        .id_RegWrite(id_RegWrite),
        .id_MemRead(id_MemRead),
        .id_MemWrite(id_MemWrite),
        .id_MemtoReg(id_MemtoReg),
        .id_ULASrc(id_ULASrc),
        .id_Branch(id_Branch),
        .id_ULAOp(id_ULAOp),
        .idex_pc(idex_pc),
        .idex_pc_plus_4(idex_pc_plus_4),
        .idex_reg_data1(idex_reg_data1),
        .idex_reg_data2(idex_reg_data2),
        .idex_imm(idex_imm),
        .idex_rs1(idex_rs1),
        .idex_rs2(idex_rs2),
        .idex_rd(idex_rd),
        .idex_funct3(idex_funct3),
        .idex_funct7_bit5(idex_funct7_bit5),
        .idex_RegWrite(idex_RegWrite),
        .idex_MemRead(idex_MemRead),
        .idex_MemWrite(idex_MemWrite),
        .idex_MemtoReg(idex_MemtoReg),
        .idex_ULASrc(idex_ULASrc),
        .idex_Branch(idex_Branch),
        .idex_ULAOp(idex_ULAOp)
    );

    // Estágio EX
    stage_ex ex_stage (
        .clk(clk),
        .pc(idex_pc),
        .reg_data1(idex_reg_data1),
        .reg_data2(idex_reg_data2),
        .immediate(idex_imm),
        .ula_op(idex_ULAOp),
        .funct3(idex_funct3),
        .funct7_bit5(idex_funct7_bit5),
        .ula_src(idex_ULASrc),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB),
        .forward_exmem(exmem_ula_result),
        .forward_memwb(wb_write_back_data),
        .ula_result(ex_ula_result),
        .ula_flags(ex_ula_flags),
        .branch_target(ex_branch_target),
        .store_data(ex_store_data)
    );

    // Registrador de Pipeline EX/MEM
    pipeline_exmem exmem_reg (
        .clk(clk),
        .rst(rst),
        .ex_branch_target(ex_branch_target),
        .ex_ula_result(ex_ula_result),
        .ex_store_data(ex_store_data),
        .idex_rd(idex_rd),
        .idex_funct3(idex_funct3),
        .idex_RegWrite(idex_RegWrite),
        .idex_MemRead(idex_MemRead),
        .idex_MemWrite(idex_MemWrite),
        .idex_MemtoReg(idex_MemtoReg),
        .idex_Branch(idex_Branch),
        .ex_zero_flag(ex_ula_flags[0]),
        .exmem_pc_target(exmem_pc_target),
        .exmem_ula_result(exmem_ula_result),
        .exmem_reg_data2(exmem_reg_data2),
        .exmem_rd(exmem_rd),
        .exmem_funct3(exmem_funct3),
        .exmem_RegWrite(exmem_RegWrite),
        .exmem_MemRead(exmem_MemRead),
        .exmem_MemWrite(exmem_MemWrite),
        .exmem_MemtoReg(exmem_MemtoReg),
        .exmem_Branch(exmem_Branch),
        .exmem_zero_flag(exmem_zero_flag)
    );

    // Estágio MEM
    stage_mem mem_stage (
        .clk(clk),
        .mem_read(exmem_MemRead),
        .mem_write(exmem_MemWrite),
        .address(exmem_ula_result),
        .write_data(exmem_reg_data2),
        .funct3(exmem_funct3),
        .read_data(mem_read_data)
    );

    // Registrador de Pipeline MEM/WB
    pipeline_memwb memwb_reg (
        .clk(clk),
        .rst(rst),
        .exmem_ula_result(exmem_ula_result),
        .mem_read_data(mem_read_data),
        .exmem_rd(exmem_rd),
        .exmem_RegWrite(exmem_RegWrite),
        .exmem_MemtoReg(exmem_MemtoReg),
        .memwb_ula_result(memwb_ula_result),
        .memwb_mem_data(memwb_mem_data),
        .memwb_rd(memwb_rd),
        .memwb_RegWrite(memwb_RegWrite),
        .memwb_MemtoReg(memwb_MemtoReg)
    );

    // Estágio WB
    stage_wb wb_stage (
        .mem_to_reg(memwb_MemtoReg),
        .ula_result(memwb_ula_result),
        .mem_data(memwb_mem_data),
        .write_back_data(wb_write_back_data)
    );

    // --- UNIDADE DE DETECÇÃO DE CONFLITOS ---
    hazard_detection hazard_unit (
        .IFID_rs1(ifid_instruction[19:15]),
        .IFID_rs2(ifid_instruction[24:20]),
        .IDEX_rd(idex_rd),
        .IDEX_MemRead(idex_MemRead),
        .PCWrite(PCWrite),
        .IFIDWrite(IFIDWrite),
        .ControlMux(ControlMux)
    );
    
    // --- UNIDADE DE ADIANTAMENTO ---
    forwarding_unit forward_unit (
        .IDEX_rs1(idex_rs1),
        .IDEX_rs2(idex_rs2),
        .EXMEM_rd(exmem_rd),
        .MEMWB_rd(memwb_rd),
        .EXMEM_RegWrite(exmem_RegWrite),
        .MEMWB_RegWrite(memwb_RegWrite),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

endmodule
