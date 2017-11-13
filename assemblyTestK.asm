#lw, sw, j, jr, jal, bne, xori, addi, add, sub, slt
#addi, add, sub, slt
addi $t0, $zero, 1
addi $t2, $zero, 3
add $t1, $t0, $t2
sub $t3, $t2, $t1 #should = 36 = $t0
slt $t4, $t3, $t0
slt $t6, $t0, $t3
slt $t5, $t3, $t2
