module pipeline_ifid (
    input wire clk,
    input wire rst,
    input wire IFIDWrite,
    input wire [31:0] if_pc,
    input wire [31:0] if_pc_plus_4,
    input wire [31:0] if_instruction,
    output reg [31:0] ifid_pc,
    output reg [31:0] ifid_pc_plus_4,
    output reg [31:0] ifid_instruction
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ifid_pc <= 32'b0;
            ifid_pc_plus_4 <= 32'b0;
            ifid_instruction <= 32'b0;
        end else if (IFIDWrite) begin
            ifid_pc <= if_pc;
            ifid_pc_plus_4 <= if_pc_plus_4;
            ifid_instruction <= if_instruction;
        end
    end

endmodule