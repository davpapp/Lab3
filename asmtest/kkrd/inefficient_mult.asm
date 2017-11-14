# Inefficient Multiplication
#  Multiplication that was designed in order to use more instructions

# multiply $a0x$a1
main: 
# Set up arguments for call multiTest
addi  $a0, $zero, 4	# arg0 = 4
addi  $a1, $zero, 10	# arg1 = 10

jal   multTestWrapper

addi  $a0, $zero, 72	# arg0 = 4
addi  $a1, $zero, 5	# arg1 = 10
jal   multTestWrapper

# Jump to "exit", rather than falling through to subroutines
j     program_end

#------------------------------------------------------------------------------
multTestWrapper:
addi  $sp, $sp, -8
sw    $ra, 4($sp)
sw    $s0, 0($sp)

add   $v0, $zero, $zero # Make sure that there is no value already in v0
add   $s0, $zero, $zero # or in s0, which is now a counter
jal   multTest

lw    $ra, 4($sp)
lw    $s0, 0($sp)
addi  $sp, $sp, 8

jr    $ra
#------------------------------------------------------------------------------
multTest:

slt   $t0, $s0, $a1          # check to see if the count is less than a1, in which case you want to keep going
bne   $t0, $zero, mult_case
jr $ra                       # Go home, you're done

mult_case:
add   $v0, $v0, $a0          # Add arg0 to the result
addi  $s0, $s0, 1            # Increment the counter

j multTest                   # and go again!

#------------------------------------------------------------------------------
# Jump loop to end execution, so we don't fall through to .data section
program_end:
j program_end

#------------------------------------------------------------------------------
.data
# Null-terminated string to print as part of result
result_str: .asciiz "\nMult(4,10) = "