# Disciplina: Arquitetura e Organização de Computadores 
# Atividade: Exercicio 03

# int vet[8];

#   cout << "Digite os valores do vetor: " << endl;

# for (int i=0; i<8; i++){
#   cout << "Numero " << i+1 << ": " << endl;
#   cin >> vet[i];

# for (int i=0; i<8; i++){
#    cout << "A[" << i+1 << "]: " << vet[i] << endl;

        .data
   array: .word 0 0 0 0 0 0 0 0
   insertValue: .asciiz "Digite os valores do vetor"
   insertArray_1: .asciiz "A["
   insertArray_2: .asciiz "]: "   
   newLine: .asciiz "\n"
   mensagem: .asciiz "Vetor: "

        .text
 main:
    
  la $s6, array          # $s6 contem o endereço base de array[]
  addi $s3, $zero, 0     # inicializando i=0 
  addi $t3,$t3,0
  
  li $v0, 4		 # chamada 4
  la $a0, insertValue    # carrega a labble insertValue
  syscall		 # carrega o serviço
  
   li $v0, 4		 # chamada 4
   la $a0, newLine 	 # # carrega a labble newLine
   syscall		 # carrega o serviço
  
 loop:

   beq $t3,8,exit  

   add $t1, $s3, $s3     # $t1 = 2 * i
   add $t1, $t1, $t1     # $t1 = 4 * i
   add $t1, $t1, $s6     # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       
   li $v0, 4		 # chamada 4
   la $a0, insertArray_1 # carrega a labble insertArray_1
   syscall               # carrega o serviço
   
   li $v0, 1		 # chamada 1
   move $a0, $t3	 # imprime o indice 
   syscall		 # carrega o serviço
   
   li $v0, 4		 # chamada 4
   la $a0, insertArray_2 # carrega a labble insertArray_2
   syscall		 # carrega o serviço
   
   li $v0, 4		 # chamada 4
   la $a0, newLine 	 # # carrega a labble newLine
   syscall		 # carrega o serviço

   li $v0,5		 # chamada 5 (leitura de um numero inteiro)
   syscall               # carrega o serviço
        
   sw $v0, 0($t1)	 # salva $v0 em array[]
   
   addi $s3, $s3 , 1     # i++
   
   addi $t3,$t3,1        # soma $t3 para o loop
      
   j loop                # jump para o loop
   
 exit:
 
   li $v0, 4		 # chamada 4
   la $a0, newLine 	 # carrega a labble newLine
   syscall		 # carrega o serviço
   	
   addi $t3, $zero, 0	 
   addi $s6, $zero, 0	
   la $s6, array          # $s6 contem o endereço base de array[]
   addi $s3, $zero, 0     # inicializando i=0 
   
   li $v0, 4
   la $a0, mensagem
   syscall 
   
   li $v0, 4		 # chamada 4
   la $a0, newLine 	 # # carrega a labble newLine
   syscall		 # carrega o serviço 

  
loop_print:

  
 
   beq $t3,8,exit_1       # se $t3 = 8 entao vai para exit

   add $t1, $s3, $s3     # $t1 = 2 * i
   add $t1, $t1, $t1     # $t1 = 4 * i
   add $t1, $t1, $s6     # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       
   li $v0, 4		 # chamada 4
   la $a0, insertArray_1 # carrega a labble insertArray_1
   syscall               # carrega o serviço
   
   li $v0, 1		 # chamada 1
   move $a0, $t3	 # imprime o indice 
   syscall		 # carrega o serviço
   
   li $v0, 4		 # chamada 4
   la $a0, insertArray_2 # carrega a labble insertArray_2
   syscall		 # carrega o serviço  
       
   lw $t6, 0($t1)	 # salva array em $v0
   
   li $v0, 1
   la $a0, ($t6)
   syscall
   
   li $v0, 4		 # chamada 4
   la $a0, newLine 	 # # carrega a labble newLine
   syscall		 # carrega o serviço 
   
   addi $s3, $s3 , 1     # i++
   
   addi $t3,$t3,1        # soma $t3 para o loop
      
   j loop_print          # jump para o loop
      
exit_1:
nop











