// Executa a instrução
module stage_ex (
    input wire clk,
    input wire [31:0] pc,
    input wire [31:0] reg_data1,
    input wire [31:0] reg_data2,
    input wire [31:0] immediate,
    input wire [1:0] ula_op,
    input wire [2:0] funct3,
    input wire funct7_bit5,
    input wire ula_src,
    input wire [1:0] ForwardA,
    input wire [1:0] ForwardB,
    input wire [31:0] forward_exmem,
    input wire [31:0] forward_memwb,

    output wire [31:0] ula_result,
    output wire [2:0] ula_flags,
    output wire [31:0] branch_target,
    output wire [31:0] store_data
);

    reg [31:0] ula_input_a, forwarded_b;
    wire [31:0] ula_input_b;
    wire [3:0] ula_control_out;
    
    always @(*) begin
        case (ForwardA)
            2'b00: ula_input_a = reg_data1;
            2'b01: ula_input_a = forward_memwb;
            2'b10: ula_input_a = forward_exmem;
            default: ula_input_a = reg_data1;
        endcase
        
        case (ForwardB)
            2'b00: forwarded_b = reg_data2;
            2'b01: forwarded_b = forward_memwb;
            2'b10: forwarded_b = forward_exmem;
            default: forwarded_b = reg_data2;
        endcase
    end
    
    assign ula_input_b = ula_src ? immediate : forwarded_b;
    assign branch_target = pc + immediate;
    assign store_data = forwarded_b;

    ula_control ula_ctrl_inst (
        .ULAOp(ula_op),
        .funct3(funct3),
        .funct7_bit5(funct7_bit5),
        .ULAControl(ula_control_out)
    );

    ula ula_inst (
        .A(ula_input_a),
        .B(ula_input_b),
        .ULAControl(ula_control_out[2:0]),
        .result(ula_result),
        .flags(ula_flags)
    );
    

endmodule