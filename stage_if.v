// Qual instrução será
module stage_if (
    input wire clk,
    input wire rst,
    input wire PCWrite,
    input wire pc_src,
    input wire [31:0] branch_target,

    output wire [31:0] pc_out,
    output wire [31:0] pc_plus_4,
    output wire [31:0] instruction
);

    reg [31:0] pc_reg;
    
    assign pc_plus_4 = pc_reg + 32'd4;
    wire [31:0] pc_next = pc_src ? branch_target : pc_plus_4;
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_reg <= 32'b0;
        else if (PCWrite)
            pc_reg <= pc_next;
    end
    
    assign pc_out = pc_reg;
    
    instruction_memory imem_inst (
        .Address(pc_reg),
        .Instruction(instruction)
    );

endmodule