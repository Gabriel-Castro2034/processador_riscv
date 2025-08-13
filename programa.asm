addi x1, x0, 10
addi x2, x0, 10
addi x3, x0, 20
sw x3, 0(x0)
beq x1, x2, L1_pula_erro

addi x4, x0, 999

L1_pula_erro:
lw x5, 0(x0)
sub x6, x5, x1

beq x5, x6, L2_pula_acerto

sw x6, 4(x0)
beq x0, x0, FIM

L2_pula_acerto:
sw x4, 4(x0)

FIM:
beq x0, x0, FIM
