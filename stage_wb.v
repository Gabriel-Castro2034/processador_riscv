// salva no registrador
module stage_wb (
    input wire mem_to_reg,
    input wire [31:0] ula_result,
    input wire [31:0] mem_data,
    output wire [31:0] write_back_data
);

    assign write_back_data = mem_to_reg ? mem_data : ula_result;

endmodule