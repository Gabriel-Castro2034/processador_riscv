addi x5, x0, 50
addi x6, x0, 10
sw x5, 0(x0)
lw x7, 0(x0)
sub x10, x7, x6
addi x11, x0, 25
xor x12, x10, x11
addi x13, x0, 2
srl x14, x12, x13
addi x15, x0, 12
beq x14, x15, PASSA

addi x1, x0, 999

PASSA:
addi x16, x0, 99
beq x14, x16, FALHA

sw x14, 8(x0)
beq x0, x0, FIM

FALHA:
sw x1, 8(x0)

FIM:
beq x0, x0, FIM
