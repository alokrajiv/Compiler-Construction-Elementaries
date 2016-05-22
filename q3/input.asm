.data
a: .word 10
b: .word 12
s: .word 0

.text
.globl main
main:

lw $t0, a
lw $t1, b
add $t2, $t0, $t1
sw  $t2, s

.end main