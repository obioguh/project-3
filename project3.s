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
        addi $t5, $t5, 4
        j loop42
    AfterLoop42
    
    sub $t6, $t4, $t5
    
    slt $t7, $t6, 0
    sgt $t8, $t6, 12
    or $t7, $t7, $t8
    bne $t7, $zero, invalid
    
    add $t6, $t4, $zero
    li $t7, 0
  
    addi $t5, $t5, -4
    loop5:
        beq $t6, $t5, afterLoop5
        lw $a1, 0($t6)
        
        sgt $t1, $a1, 64
        addi $a2, $s1, 65
        slt $t8, $a1, $a2
        and $a3, $t1, $t8
        
        sgt $t1, $a1, 96
        addi $a2, $s1, 97
        slt $t8, $a1, $a2
        and $s7, $t1, $t8
        
        sgt $t1, $a1, 47
        li $a2, 58
        slt $t8, $a1, $a2
        and $t1, $t1, $t8
        
        or $a3, $a3, $s7
        or $a3, $a3, $t1
        beq $a3, $zero, invalid
        
        move $a0, $t6
        move $t1, $ra 
        # $t1 is not to be touched as it has ra
        li $a2, $t5, 0
        addi $a2, $t5, 4
        sub $a2, $t6, $a2
        li $s7, 4
        div $a2, $s7
        jal SubProgramC
        move $ra, $t1
        add $t7, $t7, $v0
        addi $t6, $t6, -4
        j loop5
        
    afterLoop5:
        li $t6, 1
        j endSubProgramB
        
    endSubProgramB:
        popLoop:
            beq $sp, $s5, endPopLoop
            addi $sp, $sp, 4
            j popLoop
        endPoploop:
            beq $t6, $zero, appendSpace
            j appendTotal
            
        appendSpace:
            li $v0, 4
            la $a0, NaN
            syscall
            j back
        appendTotal:
            li $v0, 1
            move $a0, $t7
            syscall
            j back
            
    back:
        jr $ra
        
SubProgramC:
    li $s7, 65
    add $s7, $s1, $s7
    sgt $t8, $a1, 64
    slt $a3, $a1, $s7
    and $t8, $t8, $a3
    bne $t8, $zero, upperLetter
    
    li $s7, 97
    add $s7, $s7, $s1
    sgt $t8, $a1, 96
    slt $a3, $a1, $s7
    and $t8, $t8, $a3
    bne $t8, $zero, lowerLetter
    
    sgt $t8, $a1, 47
    slt $a3, $a1, 58
    and $t8, $t8, $a3
    bne $t8, $zero, number
    
    j number
    
    lowerLetter:
        addiu $a1, $a1, -87
        j powerOff
        
    upperLetter:
        addiu $a1, $a1, -55
        j powerOff
        
    number:
        addiu $a1, $a1, -48
        j powerOff
        
    powerOff:
    li $t8, 0
    li $v0, 1
    slt $a3, $t8, $v1
    beq $a3, $zero, pAfterLoop
    
    pLoop:
        mult $v0, $s0
        mflo $v0
        addi $t8, $t8, 1
        
        slt $a3, $t8, $v1
        bne $a3, $zero, pLoop
        
    pAfterLoop:
    
        mult $a1, $v0
        
        mflo $v0
        
        jr $ra
        
        
        
    
    
        
    


        

    
            
       
        
        
    
   
