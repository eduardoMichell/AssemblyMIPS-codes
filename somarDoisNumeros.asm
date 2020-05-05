# Disciplina: Arquitetura e Organização de Computadores 
# Atividade: Exercicio 01

# cout << "Digite o valor de dois numeros inteiros: " << endl;
# cin >> x >> y;
# soma = x + y;
# cout << "Resultado: " << x << " + " << y  << " = " << soma << endl;
 
.data
    valor_x : .asciiz "Informe o valor de x: "
    valor_y : .asciiz "informe o valor de y: "
    result : .asciiz "Resultado da soma: "

.text
  li $v0, 4         # Carrega o serviço 4
  la $a0, valor_x   # print na labble valor x
  syscall 	    # chama o serviço
  
  li $v0,5 	    # Carrega o serviço 5  (leitura de um numero inteiro)
  syscall           # chama o serviço
  
  move $t0, $v0     # move o primeiro valor para o registrador $t0

  li $v0, 4         # Carrega o serviço 4  
  la $a0, valor_y   # print na labble valor y
  syscall           # chama o serviço
  
  li $v0,5	    # Carrega o serviço 5  (leitura de um numero inteiro)
  syscall           # chama o serviço
  
  move $t1, $v0     # move o segundo valor para o registrador $t1
   
  # $t0 tem o primeiro valor e $t1 tem o segundo valor
  
  add $t2, $t1, $t0 # soma os valores de $t0 e $t1 e coloca no restrador $t2
  
  li $v0, 4	    # Carrega o serviço 4
  la $a0, result    # print na labble result
  syscall           # chama o serviço 
   
  li $v0,1	    # Carrega o serviço 1
  move $a0, $t2     # print no resultado guardado no registrador $t2
  syscall           # chama o serviço

jr $ra