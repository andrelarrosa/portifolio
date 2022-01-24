.data
msg:    .asciiz "Os elementos ordenados são:"
space:  .asciiz " "
comma:  .asciiz ","
arr:    .space 80
.text

MAIN:   

    addi $v0, $zero, 5
    syscall
    add $s1, $zero, $v0

    la $s0, arr

    add $a0, $zero, $s0
    add $a1, $zero, $s1

    jal FILL            

    jal  SORT            

    jal PRINT           

    addi $v0, $zero, 10     
    syscall

FILL:   
    addi $sp, $sp, -8      
    sw $s0, 0($sp)         
    sw $s1, 4($sp)         
    addi $t0, $zero, 0     
    add $s0, $zero, $t0    

FILL_LOOP:
    slt $t1, $s0, $a1       
    beq $t1, $zero, FILL_RETURN    

    addi $v0, $zero 5  
    syscall            

    addi $s1, $zero, 0   
    add $s1, $zero, $v0  

    add $t3, $zero, $s0  
    sll $t3, $t3, 2      
    add $t3, $t3, $a0    
    sw $s1, 0($t3)       

    addi $s0, $s0, 1    

    j   FILL_LOOP       

FILL_RETURN:
    lw $s0, 0($sp)   
    lw $s1, 4($sp)   
    addi $sp, $sp 8  
    jr $ra           

SORT:
    addi $sp, $sp, -28   
    sw $a0, 0($sp)       
    sw $a1, 4($sp)       
    sw $ra, 8($sp)       
    sw $s0, 12($sp)      
    sw $s1, 16($sp)      
    sw $s2, 20($sp)      
    sw $s3, 24($sp)      

    addi $s0, $zero, 0   
    add $t0, $zero, $a1  
    addi $t0, $t0, -1    

FOR_1:
    slt $t1, $s0, $t0      
    beq $t1, $zero, SORT_RETURN  

    add $s3, $zero, $s0    
    addi $t1, $s0, 1       
    add $s1, $zero, $t1    

FOR_2:
    slt $t1, $s1, $a1      
    beq $t1, $zero, IF_1   

IF_2: 

    add $t2, $zero, $s1  
    sll $t2, $t2, 2      
    add $t2, $t2, $a0    
    lw $t3, 0($t2)       

    
    add $t4, $zero, $s3  
    sll $t4, $t4, 2      
    add $t4, $t4, $a0    
    lw $t5, 0($t4)       

    slt $t1, $t3, $t5      
    beq $t1, $zero, LOOP_2 
    add $s3, $zero, $s1    

LOOP_2:
    addi $s1, $s1, 1     
    j FOR_2

IF_1: 
    beq $s3, $s0, LOOP_1       

    add $t2, $zero, $s3 
    sll $t2, $t2, 2     
    add $t2, $t2, $a0   
    lw $s2, 0($t2)      

    add $t3, $zero, $s0 
    sll $t3, $t3, 2     
    add $t3, $t3, $a0   
    lw $t6, 0($t3)      

    sw $t6, 0($t2)       

    sw $s2, 0($t3)

LOOP_1:
    addi $s0, $s0, 1      
    j FOR_1 

SORT_RETURN:
    lw $a0, 0($sp)   
    lw $a1, 4($sp)   
    lw $ra, 8($sp)   
    lw $s0, 12($sp)  
    lw $s1, 16($sp)  
    lw $s2,  20($sp) 
    lw $s3, 24($sp)  
    addi $sp, $sp 28 
    jr $ra           

PRINT:
    addi $sp, $sp, -4     
    sw $s0, 0($sp)        
    addi $t0, $zero, 0    
    add $s0, $zero, $t0   

    
    la $s3, msg         
    add $a0, $zero, $s3 
    addi $v0, $zero, 4  
    syscall             

    la $s3, space      
    add $a0, $zero, $s3
    addi $v0, $zero, 4 
    syscall            

PRINT_LOOP:
    slt $t2, $s0, $a1       
    beq $t2, $zero, PRINT_RETURN 

    la $a0, arr            

    add $t3, $zero, $s0   
    sll $t3, $t3, 2       
    add $t3, $t3, $a0     

    lw $t4, 0($t3)        
    add $a0, $zero, $t4   

    addi $v0, $zero, 1    
    syscall            

   
   
    addi $t3, $a1, -1       
    beq $t3, $s0, PRINT_RETURN 

    
    la $s3, comma       
    add $a0, $zero, $s3 
    addi $v0, $zero, 4  
    syscall             

    la $s3, space       
    add $a0, $zero, $s3 
    addi $v0, $zero, 4  
    syscall             

    addi $s0, $s0, 1       

    j PRINT_LOOP

PRINT_RETURN:
    lw $s0, 0($sp)    
    addi $sp, $sp 4   
    jr $ra            