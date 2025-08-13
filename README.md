# Processador RISC-V – Trabalho Prático CSI509

Implementação de um **processador RISC-V simplificado** com caminho de dados e unidade de controle em **Verilog**, desenvolvido como parte da disciplina **CSI509 – Organização e Arquitetura de Computadores II** (UFOP – João Monlevade).

O projeto contempla **simulação** (testbench) e **síntese** (FPGA Mercúrio IV), seguindo as especificações fornecidas pelo professor.

---

## 📌 Objetivo do Projeto

- Implementar um subconjunto de instruções **RISC-V** definido pelo professor.
- Simular e validar o funcionamento do processador via **testbench**.
- Sintetizar o design para execução em FPGA **Mercúrio IV**.
- Documentar a implementação e os resultados de forma clara e estruturada.

---

## 🛠 Conjunto de Instruções Implementadas

De acordo com a tabela fornecida, o grupo implementou as seguintes instruções:

LW, SW, SUB, XOR, ADDI, SRL, BEQ


O testbench foi configurado para:

* Executar o código `programa.asm` (convertido para .hex).
* Imprimir o conteúdo dos 32 registradores e as primeiras 32 posições da memória no final da execução.
