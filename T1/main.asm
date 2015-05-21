.data

	message_first_number: .word 'Insira o primeiro número:'
	message_second_number: .word 'Insira o segundo número:'
	message_operator: .word 'Insira o operador da operação'
	message_final: .word 'O resultado final da operação é:'
	message_error: .word 'O operador não  foi reconhecido:'
	result: .word 0

	soma: .word '+'
	subtracao: .word '-'
	divisao: .word '/'
	resto: .word '%'
	multiplicacao: .word '*'

.text

	;###########################################################################
	;	Leitura dos paramêtros.
	;###########################################################################

	; Exibindo a mensagem requisitando a inserção do primeiro número
	li $v0, 4
	la $a0, message_first_number
	syscall

	; Lendo e colocando o primeiro número na variável temporária t0
	li $v0, 5 ; number
	syscall
	move $t0, $v0

	; Exibindo a mensagem requisitando a inserção do segundo número
	la $a0, message_second_number
	syscall

	; Lendo e colocando o segundo número na variável temporária t1
	li $v0, 5 ; number
	syscall
	move $t1, $v0

	; Exibindo a mensagem requisitando a inserção do operador
	la $a0, message_operator
	syscall

	; Lendo e colocando o operador na variável temporária t2
	li $v0, 12 ; char
	syscall
	move $t2, $v0

	;###########################################################################
	;	Seleção e execução da operação.
	;###########################################################################

	; Iniciando o case na primeira validação.
	; Cada case inicia com uma comparação que caso falhe
	; pula a execução para o próximo case.
	j case1

	; case soma(+)
	case1:
		bne $t2, soma, case2
		add $t7, $t0, $t1
		j exit

	; case subtração(-)
	case2:
		bne $t2, subtracao, case3
		sub $t7, $t0, $t1
		j exit

	; case divisao(/)
	case3:
		bne $t2, divisao, case4
		div $t0, $t1
		mflo $t7
		j exit

	; case resto(%)
	case4:
		bne $t2, resto, default
		div $t0, $t1
		mfhi $t7
		j exit

	; case multiplicação(*)
	case5:
		bne $t2, multiplicacao, default
		mult $t0, $t1
		mfhi $t7
		j exit

	; default error
	default:
		la $a0, message_error
		syscall

	exit:
		; Exibindo a mensagem de apesentação do resultado
		la $a0, message_final
		syscall

		; Exibindo o resultado final do programa
		move $a0, $t7
		syscall
