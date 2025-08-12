// Módulo de Testbench para o Processador RISC-V
module testbench;

    reg clk;
    reg rst;
	 integer i;

    processador meu_cpu (
        .clk(clk),
        .rst(rst)
    );
	 

    always #5 clk = ~clk;


    initial begin
		  
        clk = 0; 
        rst = 1; 
        #20;
        rst = 0;

        #2000;
        
        //Resultados finais
        $display("===========================================");
        $display("      SIMULACAO FINALIZADA - %t ns", $time);
        $display("===========================================");
        $display("\n--- Estado Final dos Registradores ---");
        
        for (i = 0; i < 32; i = i + 1) begin
            $display("Register x%0d: 0x%h", i, meu_cpu.breg_inst.mem[i]);
        end

        $display("\n--- Estado Final da Memoria de Dados (Primeiros 32 Bytes) ---");
        for (i = 0; i < 32; i = i + 4) begin
            $display("Memoria[0x%h]: 0x%h%h%h%h", i, 
                meu_cpu.dmem_inst.mem[i+3], meu_cpu.dmem_inst.mem[i+2],
                meu_cpu.dmem_inst.mem[i+1], meu_cpu.dmem_inst.mem[i+0]);
        end
        
        $finish;
    end

endmodule