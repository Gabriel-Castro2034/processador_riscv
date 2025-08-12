//Armazena e atualiza o endereço da instrução que o processador deve buscar na memória a cada ciclo de clock.
module programcounter(
input clk,					//Clock
input rst,					//Reset
input [31:0]PC_in,		//Endereço de entrada
output reg [31:0]PC_out //Endereço de saída
);

always @(posedge clk) begin
	if(rst==1'b1)
		PC_out <= 32'd0;
	else
		PC_out <= PC_in;
end
endmodule