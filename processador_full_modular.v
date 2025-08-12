// Processador RISC-V
module processador_full_modular (
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
    wire branch_taken = idex_Branch && ex_ula_flags[0];
    assign pc_src = branch_taken || (exmem_Branch && exmem_zero_flag);
    
    // Limpa os registradores de pipeline quando o desvio é tomado
    wire flush_pipeline = branch_taken;
    
    // Estágio IF
    stage_if if_stage (
        /* ... conexões ... */
    );

    // Registrador de Pipeline IF/ID
    pipeline_ifid ifid_reg (
        /* ... conexões ... */
    );

    // Estágio ID
    stage_id id_stage (
        /* ... conexões ... */
    );

    // Registrador de Pipeline ID/EX
    pipeline_idex idex_reg (
        /* ... conexões ... */
    );

    // Estágio EX
    stage_ex ex_stage (
        /* ... conexões ... */
    );

    // Registrador de Pipeline EX/MEM
    pipeline_exmem exmem_reg (
        /* ... conexões ... */
    );

    // Estágio MEM
    stage_mem mem_stage (
        /* ... conexões ... */
    );

    // Registrador de Pipeline MEM/WB
    pipeline_memwb memwb_reg (
        /* ... conexões ... */
    );

    // Estágio WB
    stage_wb wb_stage (
        /* ... conexões ... */
    );

    // --- UNIDADE DE DETECÇÃO DE CONFLITOS ---
    hazard_detection hazard_unit (
        /* ... conexões ... */
    );
    
    // --- UNIDADE DE ADIANTAMENTO ---
    forwarding_unit forward_unit (
        /* ... conexões ... */
    );

endmodule