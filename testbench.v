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
			  //Memória de instruções
			  $readmemh("C:/Users/gabri/Documents/proc/programa.hex", meu_cpu.if_stage.imem_inst.mem);
			  //Estado inicial registradores
			  $readmemh("registradores.hex", meu_cpu.id_stage.breg_inst.mem);
			  //Estado inicial memória
			  $readmemh("memoria.hex", meu_cpu.mem_stage.dmem_inst.mem);
			  
			  
			  // --- INICIALIZAÇÃO E RESET ---
			  
			  clk = 0; 
			  rst = 1;         
			  #20;
			  rst = 0;
			  
			  #200; 
			  
			  // --- VERIFICAÇÃO DOS RESULTADOS FINAIS ---
			  $display("===========================================");
			  $display("      SIMULACAO FINALIZADA - %t ns", $time);
			  $display("===========================================");
			  $display("\n--- Estado Final dos Registradores ---");
			  
			  
			  for (i = 0; i < 32; i = i + 1) begin
					$display("Register x%0d: %d (0x%h)", i, meu_cpu.id_stage.breg_inst.mem[i], meu_cpu.id_stage.breg_inst.mem[i]);
			  end

			  $display("\n--- Estado Final da Memoria de Dados (Primeiros 32 Bytes) ---");
			  for (i = 0; i < 32; i = i + 4) begin
					$display("Memoria[0x%h]: 0x%h%h%h%h", i, 
					meu_cpu.mem_stage.dmem_inst.mem[i+3], meu_cpu.mem_stage.dmem_inst.mem[i+2],
					meu_cpu.mem_stage.dmem_inst.mem[i+1], meu_cpu.mem_stage.dmem_inst.mem[i+0]);
				end
				

			  $finish;
    end

endmodule
