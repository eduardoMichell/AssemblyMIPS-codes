# Disciplina: Arquitetura e Programacao de Computadores
# Atividade: Avaliacao 03: Programacao de Procedimentos
# Aluno: Eduardo Michel

.data

#Definindo o tamanho da matriz

	matrizA: .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0
		 
	matrizB: .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0
		 
		 
	matrizC: .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0
		 .word 0,0,0,0


	linA: .asciiz "Digite a quantidade de linhas da matriz A (max 4): "
	colA: .asciiz "Digite a quantidade de colunas da matriz A (max 4): "
	linB: .asciiz "Digite a quantidade de linhas da matriz B (max 4): "
	colB: .asciiz "Digite a quantidade de colunas da matriz B (max 4): "
	newLine: .asciiz "\n"
	space: .asciiz " "
	matriz_error: .asciiz "As matrizes nao podem ser multiplicadas, coluna A e diferente de linha B."
	lin_error: .asciiz "A quantidade de linhas e invalida."
	col_error: .asciiz "A quantidade de colunas e invalida."
	leitura_MatrizA1: .asciiz "A["
	leitura_MatrizA2: .asciiz "]["
	leitura_MatrizA3: .asciiz "]: "
	leitura_MatrizB1: .asciiz "B["
	leitura_MatrizB2: .asciiz "]["
	leitura_MatrizB3: .asciiz "]: "
	print_Matriz: .asciiz "C: \n"	

.text

# LEGENDA
# $s7 = linA
# $s6 = colA
# $s5 = linB
# $s4 = colB
# $s2 = endereco base da matriz A
# $s1 = endereco base da matriz B
# $s0 = endereco base da matriz C
	
# (i * X * 4) + (j * 4)   

j main
   
matrix_multiply:
sub  $sp, $sp, 16     				# Ajusta a pilha para receber 1 valor.
sw   $ra, 12($sp)     				# Salva $ra na pilha.
sw   $s7, 8($sp)				# Salva $s7 na pilha.
sw   $s6, 4($sp)			        # Salva $s6 na pilha.
sw   $s4, 0($sp)				# Salva $s4 na pilha.	


loop:
li $t1,0                     			# J = 0, para um novo loop.
 
loop1:
beq $t0,$s7, done	      			# Quando $t0 (i) == $s7 (linA), vai para done.
	  
loop2:
beq $t1,$s4,desc 	    			# Quando $t1 (j) == $s4 (colB), vai para desc.
li $t8,0 	             		        # Registrador de soma.
  	     
j loop3	
  		
sum_store:

# Deslocamento da matriz C.	

mul $t4,$t0,$s4   				# $t4 = $t0 (i) * $s4 (colB)
mul $t4,$t4,4     				# $t4 = $t4 * 4
mul $t9,$t1,4      				# $t9 = $t1 (j) * 4
add $t4,$t4,$t9   				# #t4 = $t4 + $t9    |   (i * colB * 4) + (j * 4)
sw $t8, matrizC($t4)  				# Adiciona o registrador de soma na matriz C em $t4.
  		
addi $t1,$t1,1    				# j++
  		
li $t2,0  					# Zera 0 k para um novo loop.
li $t9,0  					# Zera $t9 para um novo deslocamento.
  		
j loop2

loop3:
beq $t2,$s6,sum_store       			# Quando $t2 (k) == $s6 (colA), entao vai para sum_store.
  	          
# Deslocamento da matriz A
  	          
mul $t5,$t0,$s6           			# $t5 = $t0 (i) * $s6 (colA)
mul $t5,$t5,4 	           			# $t5 = $t5 * 4		
mul $t9,$t2,4  	            			# $t9 = $t2 (k) * 4
add $t5,$t5,$t9 	    			# $t5 = $t5 + $t9     |   (i * ColA * 4) + (k * 4)
lw $t5,matrizA($t5)         			# Adiciona o numero que esta na posicao $t5 da matriz A em $t5.         
 
li $t9,0		    			# Zera $t9 para um novo deslocamento.
 
# Deslocamento da matriz B  	           	          
  	          
mul $t6,$t2,$s7	            			# $t6 = $t2 (k) * $s7 (linA)
mul $t6,$t6,4	            			# $t6 = $t6 * 4
mul $t9,$t1,4	            			# $t9 = $t1 (j) * 4
add $t6,$t6,$t9 	    			# $t6 = $t6 * $t9     |   (k * linA * 4) + (j * 4)
lw $t6,matrizB($t6)	    			# Adiciona o numero que esta na posicao $t6 da matriz B em $t6.	 	     	
  	     	  
#################################################################################################################################################
#  			                     Utilizando o procedimento mult_escalar	  			
  	     	 add $a0,$zero,$t5     	      	# passando o numero $t5 para o $a0
  	     	 add $a1,$zero,$t6           	# passando o numero $t6 para o $a1
  	     	  
  	     	 jal mult_escalar	      	# chama o mult_escalar  
  	     	 
#################################################################################################################################################   
	
add $t8,$t8,$v0	  				# Adiciona $v0 no registrador $t8 (Soma).  	     	 
add $t2,$t2,1      				# k++
  	     	
j loop3
  	     	     
desc:
add $t0,$t0,1  					# i++
	    	
j loop

done:
lw $s4,0($sp)					# Restaura $s4 da pilha.
lw $s6,4($sp)					# Restaura $s6 da pilha.
lw $s7,8($sp)					# Restaura $s7 da pilha.
lw  $ra, 12($sp)      				# Restaura $ra, retorno da pilha.
add $sp, $sp, 16      				# Elimina 1 valor da pilha.
 
jr $ra		     				# Retorna.
	
 
mult_escalar:
li $s3,0             				# Zera o $s3 para uma nova soma.
li $a2,0             				# Zera o indice para um novo loop.
 
add $v0, $zero, $a0   				# $v0 recebe  $a0.
add $v1, $zero, $a1   				# $v1 recebe $a1.
  
while:    
blt $a2, $a0, while_1  				# Quando $a2 == $a0, vai para while_1.

add $v0,$zero,$s3      				# $v0 = $s3
   
jr $ra         					# Retorna.
    
while_1:

add $s3, $s3, $a1    				# $s3 = $s3 + 1
addi $a2,$a2,1       				# $a2++

j while

main:

la  $s2, matrizA   				# Endereco base da matriz A.
la  $s1, matrizB   				# Endereco base da matriz B.
la  $s0, matrizC   				# Endereco base da matriz C.

# Leitura do limite das matrizes.

linA_1:
addi $t0, $zero, 1 			 	# Inicia $t0 em 1.
addi $s7, $zero, 0                     		# Inicia $s7 em 0.

li $v0, 4         			 	# Carrega o servico 4.
la $a0, linA			         	# Print na linA.
syscall 	   	 
  
li $v0, 5 	    			 	# Carrega o servico 5 (leitura de um numero inteiro).
syscall 

add $s7, $s7, $v0  			 	# Adiciona $v0 em $s7.
  
ble $t0, $s7, linA_2			 	# Se $t0 <= $s7, vai para linA_2 
                       			 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, lin_error 			 	# Print na label alertSize.
syscall 	         
      
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	         	
       
j linA_1             			 	
 
linA_2:      
  
ble $s7, 4 , colA_1 	                 	# Se $s7 <= 4, vai para colA_1
 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, lin_error  			 	# print na label lin_error.
syscall 	     
       
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   		        	# Print na label newLine.
syscall	         	
          
j linA_1                               		

colA_1:
addi $s6, $zero, 0			 	# Inicia $s6 em 0.

li $v0, 4         			 	# Carrega o servico 4.
la $a0, colA			         	# Print na label colA.
syscall 	   	 
  
li $v0, 5 	    			 	# Carrega o servico 5  (leitura de um numero inteiro).
syscall     

add $s6, $s6, $v0  			 	# Adiciona $v0 em $s6.
  
ble $t0, $s6, colA_2			 	# se $t0 <= $s6, vai para colA_1
                       			 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, col_error 			 	# Print na label col_error.
syscall 	         
      
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	         	
       
j colA_1             			 	
 
colA_2:      
ble $s6, 4 , linB_1 	              		# Se $s6 <= 4, entao pula para o linB_1.
 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, col_error  			 	# Print na label col_error.
syscall 	     
       
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   		         	# Print na label newLine..
syscall	         
          
j colA_1                               		

linB_1:
addi $t0, $zero, 1 			 	# Inicia $t0 em 0.
addi $s5, $zero, 0                     		# Inicia $s5 em 0.

li $v0, 4         			 	# Carrega o servico 4.
la $a0, linB			         	# Print na linB.
syscall 	   	 
  
li $v0, 5 	    			 	# Carrega o servico 5  (leitura de um numero inteiro).
syscall

add $s5, $s5, $v0  			 	# Adiciona $v0 em $s5.
  
ble $t0, $s5, linB_2			 	# Se $t0 e menor que $s5 entao vai para linB_2. 
                       			 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, lin_error 			 	# Print na label lin_error.
syscall 	         
      
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	         	
       
j linB_1             			
  
linB_2:      
  
ble $s5, 4 , colB_1 	                 	# Se $s5 <= $4, vai para colB_1.
 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, lin_error  			 	# print na label lin_error.
syscall 	     
       
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   		         	# Print na label newLine.
syscall	         
          
j linB_1

colB_1:
addi $t0, $zero, 1 			 	# Inicia $t0 em 0.
addi $s4, $zero, 0			 	# Inicia $s4 em 0.

li $v0, 4         			 	# Carrega o servico 4.
la $a0, colB			         	# Print na label colB.
syscall 	   	 
  
li $v0, 5 	    			 	# Carrega o servico 5  (leitura de um numero inteiro).
syscall

add $s4, $s4, $v0  			 	# Adiciona $v0 em $s4.
  
ble $t0, $s4, colB_2			 	# se $t0 <= $s4, vai para colB_2.
                       			 
li $v0, 4         			 	# Carrega o servico 4.
la $a0, col_error 			 	# Print na label col_error.
syscall 	         
      
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	         	
       
j colB_1             			 	
  
colB_2:      
  
ble $s4, 4 , if_Matriz 	         	#  se $s4 <= 4, vai para if_Matriz
 
li $v0, 4        			 	# Carrega o servico 4.
la $a0, col_error  			 	# print na label col_error.
syscall 	     
       
li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   		         	# Print na label newLine.
syscall	         
          
j colB_1 		 		


# Aqui vemos se e possivel multiplicar as matrizes.
# So e possivel multiplicar as matrizes que tem a coluna A == linha B.

if_Matriz:

li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	

# Se s6 (colA) == s5 (linB) entao a multiplicacao podera ser feita.

beq $s6, $s5, ler_matrizA    			# se $s6 == $s5, entao vai para ler_MatrizA.

li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall		
		
li $v0, 4					# Carrega o servico 4.
la $a0, matriz_error  				# Print na label matriz_error.
syscall 

li $v0, 10	             			# Carrega o servico 10 (encerramento do programa).
syscall

ler_matrizA:

# leitura da matriz A

li $t0,0   					# Zera o $t0 para o loop.         

insert_MatrizA:
li $t1,0  					# Zera o $t1 (j) para um novo loop
beq $t0,$s7,ler_MatrizB				# Se $t0 (i) == $s7 (linA), entao vai para ler_matrizB.
ler_matrizA1:
beq $t1,$s6,ler_MatrizA2			# Se $t1 (j) == $s6 (colA), entao vai para ler_matrizA2.
 		
add $t7, $t9, $t9  				# $t7 = 2 * i
add $t7, $t7, $t7    				# $t7 = 4 * i
add $t7, $t7, $s2				# $t7 = end.base + 4.i (deslocamento) = end. de save[i]
 	   	
li $v0,4					# Carrega o servico 4.	
la $a0,leitura_MatrizA1				# Print na label leitura_MatrizA1.
syscall

li $v0,1					# Carrega o servico 1.
la $a0,($t0)					# Print no $t0 (i).
syscall

li $v0,4					# Carrega o servico 4.	
la $a0, leitura_MatrizA2			# Print na label leitura_MatrizA2.			
syscall			
   
li $v0,1					# Carrega o servico 1.
la $a0,($t1)					# Print no $t1 (j).
syscall

li $v0,4					# Carrega o servico 4.
la $a0, leitura_MatrizA3			# Print na label leitura_MatrizA3.
syscall

li $v0,5 					# Carrega o servico 5.
syscall
		
sw $v0, 0($t7) 					# Adiciona o numero lido em $t7 (matriz A).
		
addi $t1,$t1,1					# j++
addi $t9,$t9,1                 			# Soma 1 em $t9 para adicionar o proximo numero.

j ler_matrizA1
	
ler_MatrizA2:
	
addi $t0,$t0,1					# i++ 	
	
j insert_MatrizA

ler_MatrizB:

 li $v0, 4	        			# Carrega o servico 1.
 la $a0, newLine   		        	# Print na label newLine.
 syscall

addi $t7,$zero,0				# Zera $t7 para outro deslocamento.
addi $t9,$zero,0    				# Zera $t9 para outro deslocamento.
addi $t0,$zero,0 				# Zera $t0 para outro loop.
addi $t1,$zero,0				# Zera $t1 para outro loop.

insert_MatrizB:

li $t1,0 					# Zera o $t1 (j) para um novo loop
beq $t0,$s5,mul_matriz  			# Se $t0 (i) == $s5 (linB), entao vai para mul_matriz.

ler_matrizB1:
 	
beq $t1,$s4,ler_matrizB2 			# Se $t1 (j) == $s4 (colB), entao vai para ler_matrizB2.
 	  
add $t7, $t9, $t9 			 	# $t7 = 2 * i
add $t7, $t7, $t7    			 	# $t7 = 4 * i
add $t7, $t7, $s1			 	# $t7 = end.base + 4.i (deslocamento) = end. de save[i]		 	  
  		 	   	   	  
li $v0,4					# Carrega o servico 4.
la $a0,leitura_MatrizB1				# Print na label leitura_MatrizB1.
syscall
	
li $v0,1					# Carrega o servico 1.
la $a0,($t0)					# Print no $t0 (i).
syscall

li $v0,4					# Carrega o servico 4.
la $a0, leitura_MatrizB2			# Print na label leitura_MatrizB2.
syscall		
  
li $v0,1					# Carrega o servico 1.
la $a0,($t1)
syscall						# Print no $t1 (j).

li $v0,4					# Carrega o servico 4.
la $a0, leitura_MatrizB3			#  Print na label leitura_MatrizB3.
syscall

li $v0,5					# Carrega o servico 5.
syscall
		
sw $v0, 0($t7)					# Adiciona o numero lido em $t7 (matriz B).
		
addi $t1,$t1,1					# j++
addi $t9,$t9,1					# Soma 1 em $t9 para adicionar o proximo numero.

j ler_matrizB1
		 
ler_matrizB2:
	
addi $t0,$t0,1 					# i++ 
	
j insert_MatrizB


mul_matriz:

li $t0,0 					# Zera $t0.
li $t7,0 					# Zera $t7.
li $t9,0 					# Zera $t9. 


jal matrix_multiply

li $t0,0 					# Zera $t0.
li $t7,0 					# Zera $t7.
li $t9,0 					# Zera $t9.

li $v0, 4	        		 	# Carrega o servico 4.
la $a0, newLine   			 	# Print na label newLine.
syscall	

li $v0,4					# Carrega o servico 4.
la $a0,print_Matriz 				# Print na label print_Matriz.
syscall

print_Matrizz:

li $t1,0    					# Zera o $t1 (j) para um novo loop.
beq $t0,$s7,end 				# Se $t0 (i) == $s7 (linA), entao vai para end.
 		
	
print_Matriz1:
beq $t1,$s4,print_Matriz2 			# Se $t1 (j) == $s4 (colB), entao vai para print_Matriz2.
 	  
add $t7, $t9, $t9 			 	# $t7 = 2 * i
add $t7, $t7, $t7    			 	# $t7 = 4 * i
add $t7, $t7, $s0				# $t7 = end.base + 4.i (deslocamento) = end. de save[i]	
  		
lw $t6, 0($t7)				 	# Salva matrizC em $t6.
		
li $v0,1                               		# Carrega o servico 1.
la $a0,($t6)			     		# Print no $t6 (Numero da matrizC).
syscall
		
li $v0, 4			   		# Carrega o servico 4.
la $a0, space			   		# Print na label space.
syscall
	
addi $t1,$t1,1					# j++		
addi $t9,$t9,1 					# Soma 1 em $t9 para adicionar o proximo numero.

j print_Matriz1
		 
print_Matriz2:
	
li $v0, 4			  		# Carrega o servico 4.
la $a0, newLine			  		# Print na label newLine.
syscall
		
addi $t0,$t0,1 	   				# i++

j print_Matrizz

end:

nop

