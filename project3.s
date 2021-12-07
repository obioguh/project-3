.data
    message: .asciiz "Enter a string: "
    gotHere: .asciiz "Got here \n"
    NaN: .asciiz "NaN"
    input: .space 1001
    
.text

main:
    li $t0, 2846337
    li $t1, 11
    div $t0, $t1
    mfhi $t0
    addi $s0, $t0, 26
    addiu $s1, $s0, -10
    
    li $v0, 4
    la $a0, message
    syscall
    
    li $v0, 8
    la $a0, input
    li $a1, 1001
    syscall
    
    li $s2, 0
    add $s3, $s2, $zero
    
    loop1:
        li $t0, 1000
        beq $s3, $t0, afterLoop1
        
        la $a1, input
        add $a1, $a1, $s3
        lb $a1, 0($a1)
        
        li $t0, 10
        beq $a1, $t0, afterLoop1
        addi $s3, $s3, 1
        j loop1
    
   
