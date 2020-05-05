# Disciplina: Arquitetura e Organização de Computadores 
# Atividade: Avaliação 01 – Programação em Linguagem de Montagem 
# Programa 02
# Aluno:  Eduardo Michel

.data

   Array_A: .word 0 0 0 0 0 0 0 0
   Array_B: .word 0 0 0 0 0 0 0 0
   Array_C: .word 0 0 0 0 0 0 0 0
   
   # Labels para escrever na tela
   
   insertValue: .asciiz "Digite os valores do vetor"
   insertArray_1A: .asciiz "A["
   insertArray_2A: .asciiz "]: "   
   insertArray_1B: .asciiz "B["
   insertArray_2B: .asciiz "]: "
   insertArray_1C: .asciiz "C["
   insertArray_2C: .asciiz "]: "
   resultMessage: .asciiz "Resultado: "
   newLine: .asciiz "\n"
   sizeMessage: .asciiz "Entre com o tamanho do vetor (máx. = 8): "
   alertSize: .asciiz "Valor inválido, tente novamente."

.text

main:		
  la $s6, Array_A      			 # $s6 contem o endereço base de array_A[].
  addi $s3, $zero, 0   			 # $s3 é o indice do Array_A e esta sendo inicializado em 0.
  addi $t3,$t3,0       			 # Inicializa o $t3 em 0 para usar no loop.

if_1:
  addi $t0,$zero,0 			 # Inicia $t0 em 0
                                     
  li $v0, 4         			 # Carrega o serviço 4.
  la $a0, sizeMessage    		 # Print na label sizeMessage.
  syscall 	   			
  
  li $v0, 5 	    			 # Carrega o serviço 5  (leitura de um número inteiro).
  syscall          				
  
  add $t0, $t0, $v0 		         # Adiciona $v0 em $t0 (limite do vetor).
    
  slti $s0, $t0, 1        		 # Se $t0 > 0, então $s0 = 0.
       
      
  bne  $s0, 1, if_2        		 # $s0 = 0, então pula para a segunda comparação (if_2).
  				 	 # Se $s0 for 1 então ele imprime a label abaixo.
     		
  li $v0, 4         			 # Carrega o serviço 4.
  la $a0, alertSize 			 # Print na label alertSize.
  syscall 	        
      
  li $v0, 4	        		 # Carrega o serviço 1.
  la $a0, newLine   			 # Print na label newLine.
  syscall	       			
 	
  j if_1				 # Volta para a label if_1 para ler o número de novo.
 
if_2:         	
  slti $s0, $t0, 9     	 		 # Se $t0 < 9, então $s0 recebe 0. 
     
  bne $s0, $zero, loopArray_A		 # Se $s0 = 0, então pula para o loopArray_A.
 
  li $v0, 4         			 # Carrega o serviço 4.
  la $a0, alertSize  		         # Print na label alertSize.
  syscall 	 
       
  li $v0, 4	        		 # Carrega o serviço 1.
  la $a0, newLine   			 # Print na label newLine.
  syscall	         			
                                                 
  j if_1                                 # Volta para a label if_1 para ler o número de novo.    
                                                   
loopArray_A:                                     
                                                  
  beq $t3, $t0, exit_1     		 # Quando $t3 = $t0, entao vai para exit_1.

  add $t1, $s3, $s3                      # $t1 = 2 * i
  add $t1, $t1, $t1                      # $t1 = 4 * i
  add $t1, $t1, $s6   		         # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       
  li $v0, 4		 	         # Carrega o serviço 4.
  la $a0, insertArray_1A		 # Print na label insertArray_1A.
  syscall               		       
   
  li $v0, 1                              # Carrega o serviço 1.
  move $a0, $t3			         # Imprime o $s3, que seria o indice do vetor A neste loop.
  syscall				      
   
  li $v0, 4				 # Carrega o serviço 4.
  la $a0, insertArray_2A 		 # Print na label insertArray_2A.
  syscall		 		
  
  li $v0, 5		 		 # Carrega o serviço 5 (leitura de um numero inteiro).
  syscall               		
           		
  sw $v0, 0($t1)			 # Salva $v0 em array[].
   
  addi $s3, $s3, 1    			 # Equivalente ao i++.
   
  addi $t3, $t3, 1       		 # Soma $t3 para o loop.
       
  j loopArray_A             		 # Jump para o loopArray_A.
   
exit_1:      
  addi $t3, $zero, 0		 	 # Inicializa o $t3 em 0.
  la $s7, Array_B         		 # $s7 contem o endereço base de array_B[].
  addi $s3, $zero, 0       	 	 # Inicializando $s3 em 0 (i=0).
  
  li $v0, 4	        		 # Carrega o serviço 1.
  la $a0, newLine   			 # Print na label newLine.
  syscall	       			
     
loopArray_B:

  beq $t3, $t0, exit_2    		 # Se $t3 = $s1 entao ativa a labble exit_2

  add $t1, $s3, $s3   			 # $t1 = 2 * i
  add $t1, $t1, $t1    			 # $t1 = 4 * i
  add $t1, $t1, $s7   			 # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       
  li $v0, 4		   		 # Carrega o serviço 4.
  la $a0, insertArray_1B 		 # Print na label insertArray_1B.
  syscall              			 
   	
  li $v0, 1			 	 # Carrega o serviço 1.
  move $a0, $t3				 # Imprime o $s3, que seria o indice do vetor B neste loop.
  syscall				 
   
  li $v0, 4		 		 # Carrega o serviço 4.
  la $a0, insertArray_2B		 # Print na label insertArray_2B.
  syscall				
  		
  li $v0, 5				 # Carrega o serviço 5 (leitura de um numero inteiro).
  syscall              		 	
                
  sw $v0, 0($t1)			 # Salva $v0 em array[].
   
  addi $s3, $s3, 1   			 # Equivalente ao i++.
   
  addi $t3, $t3, 1      		 # soma $t3 para o loop.
      
  j loopArray_B               		 # jump para o loopArray_B.
   
exit_2:
  addi $t3, $zero, 0		 	 # Inicializa o $t3 em 0.
  la $s5, Array_C         		 # $s5 contem o endereço base de array_C[].
  addi $s3, $zero, 0       	 	 # Inicializando $s3 em 0 (i=0).

	
setArray_C:
  addi $t4, $zero, 0			 # Zera o $t4 para um novo numero.
  addi $t5, $zero, 0 			 # Zera o $t5 para um novo numero.
  addi $t7, $zero, 0 			 # Zera o $t7 para um novo numero.
  
  beq $t3, $t0, exit_3   		 # se $t3 = $s1 entao ativa a labble exit_3.
  
  add $t1, $s3, $s3   			 # $t1 = 2 * i
  add $t1, $t1, $t1    			 # $t1 = 4 * i
  add $t1, $t1, $s5  			 # $t1 = end.base + 4.i (deslocamento) = end. de save[i] 
  		
  add $t2, $s3, $s3			 # $t2 = 2 * i
  add $t2, $t2, $t2			 # $t2 = 4 * i
  add $t2, $t2, $s6  			 # $t2 = end.base + 4.i (deslocamento) = end. de save[i] 
  
  lw $t7, 0($t2)			 # Salva Array_A em $t7.
  
  add $t6, $s3, $s3			 # $t6 = 2 * i	
  add $t6, $t6, $t6			 # $t6 = 4 * i
  add $t6, $t6, $s7  			 # $t6  = end.base + 4.i (deslocamento) = end. de save[i] 
 
    
  lw $t5 ,0($t6)	                 # Salva array_B em $t5.
     
  add $t4, $t5, $t7		         # $t4 = $t5 + $t7 (somando os numeros do Array_A e Array_B).
   
  sw $t4, 0($t1)  			 # Salva $t4 em array_C[].   
  
  addi $s3, $s3, 1			 # Equivalente ao i++.
  
  addi $t3, $t3, 1  			 # Soma $t3 para o loop.
 
  j setArray_C				 # jump para o setArray_C.
 
exit_3:    
  addi $s3, $zero, 0   			 # $s3 é o indíce e esta sendo inicializado em 0.
  addi $t3, $zero, 0			 # Inicializa o $t3 em 0 para usar no loop.
   
  li $v0, 4				 # Carrega o serviço 4.
  la $a0, newLine 			 # Print na label newLine.
  syscall		
  
  li $v0, 4		 		 # Carrega o serviço 4.
  la $a0, resultMessage  	 	 # Print na label resultMessage.
  syscall		
  
  li $v0, 4				 # Carrega o serviço 4.
  la $a0, newLine 	 		 # Print na label newLine.
  syscall		
  
printArray_C:    
  beq $t3, $t0, end   			 # Quando $t3 = $t0, entao vai para end.

  add $t1, $s3, $s3     		 # $t1 = 2 * i
  add $t1, $t1, $t1    			 # $t1 = 4 * i
  add $t1, $t1, $s5     		 # $t1 = end.base + 4.i (deslocamento) = end. de save[i]
       	
  li $v0, 4				 # Carrega o serviço 4.
  la $a0, insertArray_1C 		 # Print na label insertArray_1C.
  syscall       
   
  li $v0, 1				 # Carrega o serviço 1.
  move $a0, $t3				 # $t3 tem o indíce do Array_C.
  syscall		
   
  li $v0, 4		 		 # Carrega o serviço 4.
  la $a0, insertArray_2C 		 # Print na label insertArray_2C.
  syscall		
       
  lw $t6, 0($t1)			 # Salva array em $t6.
   
  li $v0, 1				 # Carrega o serviço 1.
  la $a0, ($t6)				 # $t6 tem o resultado da soma.
  syscall
   
  li $v0, 4				 # Carrega o serviço 4.
  la $a0, newLine 			 # Print na label newLine.
  syscall				
   
  addi $s3, $s3, 1   		 	 # Equivalente ao i++.
   
  addi $t3, $t3, 1     		 	 # Soma $t3 para o loop.
      
  j printArray_C             		 # Jump para o printArray_C.
      
end:
  li $v0, 10         			 # Carrega o serviço 10.
  syscall				 # O serviço 10 encerra o terminal.	                                                                                                          


