# Disciplina: Arquitetura e Organiza��o de Computadores 
# Atividade: Avalia��o 01 � Programa��o em Linguagem de Montagem 
# Programa 01 
# Aluno:  Eduardo Michel

.data

   Array_A: .word 0 0 0 0 0 0 0 0        # Inicializa o vetor com 8 posi��es em 0.
   
   # Labels para escrever na tela
   
   insertValue: .asciiz "Digite os valores do vetor"
   insertArray_1: .asciiz "A["
   insertArray_2: .asciiz "]: "   
   newLine: .asciiz "\n"
   insertArraySize: .asciiz "Entre com o tamanho do vetor (m�x. = 8): "
   alertSize: .asciiz "Valor inv�lido, tente novamente."
   result_1: .asciiz "O maior n�mero do vetor e sua posi��o � A["
   result_2: .asciiz "]: "

      
.text

main:
  la $s6, Array_A       		 # $s6 contem o endere�o base de array[].
  addi $s3, $zero, 0    		 # $s3 � o ind�ce e esta sendo inicializado em 0.
  addi $t3, $t3, 0         		 # Inicializa o $t3 em 0 para usar no loop.

if_1:
  addi $t0, $zero, 0 			 # Inicia $t0 em 0.

  li $v0, 4         			 # Carrega o servi�o 4.
  la $a0, insertArraySize     		 # Print na labelinsertArraySize.
  syscall 	   	 
  
  li $v0, 5 	    			 # Carrega o servi�o 5  (leitura de um n�mero inteiro).
  syscall          	 
  
  add $t0, $t0, $v0  			 # Adiciona $v0 em $t0 (limite do vetor).
  
  slti $s0, $t0,1       		 # Se $t0 > 0, ent�o $s0 = 0.
     
  bne  $s0, 1, if_2    			 # $s0 = 0, ent�o pula para a segunda compara��o (if_2).
                       			 # Se $s0 for 1 ent�o ele imprime a label abaixo.
                       			 
  li $v0, 4         			 # Carrega o servi�o 4.
  la $a0, alertSize 			 # Print na label alertSize.
  syscall 	         
      
  li $v0, 4	        		 # Carrega o servi�o 1.
  la $a0, newLine   			 # Print na label newLine.
  syscall	         	
       
  j if_1              			 # Volta para a label if para ler o n�mero de novo.
 
if_2:         
  slti $s0, $t0, 9         		 # Se $t0 < 9, ent�o $s0 recebe 0. 
     
  bne $s0, $zero, loop                   # Se $s0 = 0, ent�o pula para o loop.
 
  li $v0, 4         			 # Carrega o servi�o 4.
  la $a0, alertSize  			 # print na label alertSize.
  syscall 	     
       
  li $v0, 4	        		 # Carrega o servi�o 1.
  la $a0, newLine   		         # Coloca o newLine para ser impresso.
  syscall	         
          
  j if_1				 # Volta para a label if para ler o n�mero de novo.
  
loop:
  beq $t3, $t0, exit     		 # Quando $t3 = $t0, entao vai para exit.

  add $t1, $s3, $s3    			 # $t1 = 2 * i 
  add $t1, $t1, $t1     		 # $t1 = 4 * i 
  add $t1, $t1, $s6     		 # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       
  li $v0, 4		 		 # Carrega o servi�o 4.
  la $a0, insertArray_1 		 # Print na label insertArray_1.
  syscall               
   
  li $v0, 1				 # Carrega o servi�o 1.
  move $a0, $s3	 		         # Imprime o $s3, que seria o indice do vetor.
  syscall		
   
  li $v0, 4		 		 # Carrega o servi�o 4.
  la $a0, insertArray_2 		 # Print na label insertArray_1.
  syscall		 		
    
  li $v0, 5		                 # Carrega o servi�o 5 (leitura de um numero inteiro).
  syscall               
        
  sw $v0, 0($t1)	 		 # Salva $v0 em array[].
   
  addi $s3, $s3, 1     		         # Equivalente ao i++.
   
  addi $t3, $t3, 1        		 # Soma $t3 para o loop.
      
  j loop                                 # Jump para o loop.
   
exit: 
  li $v0, 4				 # Carrega o servi�o 4.
  la $a0, newLine 			 # Print na label newLine.
  syscall		 	
      
  addi $t3, $zero, 0	 		 # Inicializa o $t3 em 0.
  addi $s3, $zero, 0        		 # Inicializando $s3 em 0 (i=0).
  addi $t7, $zero, 0         		 # Inicializando $t7 em 0.
       
seeGreater:         
  beq $t3, $t0, end       		 # Se $t3 = $t0 entao vai para end;
         
  add $t1, $s3, $s3    			 # $t1 = 2 * i
  add $t1, $t1, $t1     		 # $t1 = 4 * i
  add $t1, $t1, $s6     	         # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
          
  lw $t6, 0($t1)	      		 # Salva array em $t6.
   
  slt $s1, $t7, $t6       		 # $s1 = $t7 < $t6 entao $s1 � true.
  
  beq $s1, 1, greaterThen		 # Se $s1 � true entao vai para greaterThen.
  
  j else                          	 # Se $s1 n�o for true ele pula direto para o else.
       
greaterThen:  
  move $t7, $t6          		 # $t7 = $t6    (comparador).
  move $t8, $t7           		 # $t8 = $t7    (numero a ser escrito).
  move $t9, $t3            		 # $t9 = $t3    (indice).
   
else:  
  addi $s3, $s3, 1    			 # Equivalente ao i++.
  addi $t3, $t3, 1        		 # Soma $t3 para o loop.
      
  j seeGreater				 # Jump para a label seeGreater.
             
end:
  li $v0, 4	        		 # Carrega o servi�o 4.
  la $a0, result_1  			 # Print na label result_1.
  syscall	    
 
  li $v0, 1           			 # Carrega o servi�o 1.
  la $a0, ($t9)      			 # $t9 tem o numero do ind�ce do maior numero.
  syscall
 
  li $v0, 4	       			 # Carrega o servi�o 4.
  la $a0, result_2			 # Print na label result_2
  syscall	     			
 
  li $v0, 1           			 # Carrega o servi�o 1 (impress�o de um numero inteiro).
  la $a0, ($t8)      			 # $t8 tem o numero o maior numero do vetor.
  syscall
  
  li $v0, 10         			 # Carrega o servi�o 10.
  syscall				 # O servi�o 10 encerra o terminal.	
   
 
 
 

      
       
 
 
 
