.data

	message_first_number: .ascii "Insira o primeiro numero:"
	message_second_number: .ascii "Insira o segundo numero:"
	message_operator: .ascii "Insira o operador da operacao"
	message_final: .ascii "O resultado final da operacao e:"
	message_error: .ascii "O operador nao  foi reconhecido:"
	result: .word 0

.text

	###########################################################################
	#	Leitura dos parametros.
	###########################################################################

	# Exibindo a mensagem requisitando a inser��o do primeiro n�mero
	li $v0, 4
	la $a0, message_first_number
	syscall

	# Lendo e colocando o primeiro n�mero na vari�vel tempor�ria t0
	li $v0, 5 # number
	syscall
	move $t0, $v0

	# Exibindo a mensagem requisitando a inser��o do segundo n�mero
	la $a0, message_second_number
	syscall

	# Lendo e colocando o segundo n�mero na vari�vel tempor�ria t1
	li $v0, 5 # number
	syscall
	move $t1, $v0

	# Exibindo a mensagem requisitando a inser��o do operador
	la $a0, message_operator
	syscall

	# Lendo e colocando o operador na vari�vel tempor�ria t2
	li $v0, 12 # char
	syscall
	move $t2, $v0

	############################################################################
	#	Sele��o e execu��o da opera��o.
	############################################################################

	# Iniciando o case na primeira valida��o.
	# Cada case inicia com uma compara��o que caso falhe
	# pula a execu��o para o pr�ximo case.
	j case1
	
	addi $t3, $0, 1
	addi $t4, $0, 2
	addi $t5, $0, 3
	addi $t6, $0, 4

	# case soma(+)
	case1:
		bne $t2, $t3, case2
		add $t7, $t0, $t1
		j exit

	# case subtra��o(-)
	case2:
		bne $t2, $t4, case3
		sub $t7, $t0, $t1
		j exit

	# case divisao(/)
	case3:
		bne $t2, $t5, case4
		div $t0, $t1
		mflo $t7
		j exit

	# case multiplica��o(*)
	case4:
		bne $t2, $t6, default
		mult $t0, $t1
		mfhi $t7
		j exit

	# default error
	default:
		la $a0, message_error
		syscall

	exit:
		# Exibindo a mensagem de apesenta��o do resultado
		la $a0, message_final
		syscall

		# Exibindo o resultado final do programa
		move $a0, $t7
		syscall
