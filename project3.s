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
        
    afterLoop1:
        addi $s3, $s3, -1
        
    add $t0, $s3, $zero
    
    addi $s4, $sp, 0
    
    loop2:
        slt $t1, $t0, $s2
        bne $t1, $zero, afterLoop2
        
        addi $sp, $sp, -4
        la $a1, input
        add $a1, $a1, $t0
        lb $a1, 0($a1)
        
        sw $a1, 0($sp)
        addi $t0, $t0, -1
        j loop2
        
    afterLoop2:
    
    jal SubProgramA
    exit:
        li $v0, 10
        syscall
        
SubProgramA:
    addi $s5, $sp, 0
    add, $t0, $s5, $zero
    move $t9, $ra
    
    loop3:
        beq $t0, $s4, afterLoop3
        lw $a1, 0($t0)
        
        li $t1, 44
        bne $a1, $t1, nogo
        jal     SubprogramB
        
        li $v0, 11
        la $a0, 44
        syscall
        
        addi $t0, $t0, 4
        j loop3
        nogo:
            addi $sp, $sp, -4
            sw $a1, 0($sp)
            
            addi $t0, $t0, 4
            j loop3
            
    afterLoop3;
        jal SubProgramB
        
    move $ra, $t9
    jr $ra
    
SubprogramB:
    addi $s6, $sp, 0
    add $t2, $s5, $zero
    addi $t3, $s6, -4
    addi $t2, $t2, -4
    
    add $t4, $t2, $zero
    add $t5, $s6, $zero
    
    loop41:
        beq $t4, $t3, afterLoop41
        
        lw $a1, 0($t4)
        seq $t6, $a1, 32
        seq $t7, $a1, 9
        or $t6, $t6, $t7
        beq $t6, $zero, afterLoop41
        addi $t4, $t4, -4
        j loop41
    afterLoop41:
    
    loop42:
        beq $t5, $s5, afterLoop42
        
        lw $al, 0($t5)
        seq $t6, $a1, 32
        seq $t7, $a1, 9
        or $t6, $t6, $t7
        beq $t6, $zero, afterLoop42
        addi $t4, $t4, -4
        

    
            
       
        
        
    
   
