.data
	Message:	.asciiz	"Nhap so nguyen:"
	Title:		.asciiz "\ni	power(2,i)	square(i)	Hexadecimal(i)\n"
	space:		.asciiz "	"
	digit:		.asciiz "0123456789ABCDEF"
	hex_result:	.asciiz "0x"
.text
	main:
		li	$v0, 51
		la	$a0, Message
		syscall
		add	$s0, $zero, $a0
		nop
		jal	convert_powerOfInput
		add	$s1, $zero, $v0
		nop
		jal	convert_squared
		add	$s2, $zero, $v0
		nop
		jal	convert_hex
		add	$s3, $zero, $v0
		nop
		
		la	$a0, Title
		li	$v0, 4
		syscall
		add	$a0, $zero, $s0
		add	$a1, $zero, $s1
		add	$a2, $zero, $s2
		add	$a3, $zero, $s3
		jal	print_table
		nop 		
		li	$v0, 10
		syscall
	endmain:
	
#--------------------------------------------------------------------
# function convert_powerOfInput
# param[in] $a0 the exponent
# return $v0 result of 2 raised to the power of input
#--------------------------------------------------------------------
convert_powerOfInput:
	beq	$a0, $zero, case_zero
	addi	$v0, $zero, 2
	addi	$t0, $zero, 1
	
	loop:
		beq	$a0, $t0, done_powerOfInput
		sll	$v0, $v0, 1
		addi	$t0, $t0, 1
		j	loop
case_zero:
	addi	$v0, $zero, 1
done_powerOfInput:
	jr	$ra

#--------------------------------------------------------------------
# function convert_squared
# param[in] $a0 the base
# return $v0 result of squared base
#--------------------------------------------------------------------	
convert_squared:
	mul	$v0, $a0, $a0
done_squared:
	jr	$ra

#--------------------------------------------------------------------
# function convert_hexa
# param[in] $a0 input integer
# return $v0 the address of the array storing hexa value in string type
#--------------------------------------------------------------------	
convert_hex:
	la	$t0, hex_result
	addi	$t0, $t0, 2
	la	$t1, digit	
	li	$t2, 8			# total loops
	
	loop_hex:
		andi	$t3, $a0, 0xf			# retrieve LSB
		add	$t4, $t0, $t2			# byte-saving address
		
		add	$t5, $t1, $t3			# digit address
		lb	$t3, 0($t5)			# retrieve digit element	
		sb	$t3, 0($t4)
		addi	$t2, $t2, -1
		srl	$a0, $a0, 4
		beq	$a0, $zero, get_hex
		j	loop_hex
	get_hex:
		add	$v0, $zero, $t4
		addi	$v0, $v0, -1
		
		addi	$t0, $zero, 120
		sb	$t0, 0($v0)
		
		addi	$v0, $v0, -1
		addi	$t0, $zero, 48
		sb	$t0, 0($v0)
		
	end_loop_hex:
done_hex:
	jr	$ra
	
#--------------------------------------------------------------------
# function print_table
# param[in] $a0 i
# param[in] $a1 2^i
# param[in] $a2 i squared
# param[in] $a3 hexa value of i
# return table
#--------------------------------------------------------------------
print_table:
	li	$v0, 1
	syscall
	
	nop
	la	$a0, space
	li	$v0, 4
	syscall
	
	nop
	add	$a0, $zero, $s1
	li	$v0, 1
	syscall
	
	nop
	la	$a0, space
	li	$v0, 4
	syscall
	
	nop
	la	$a0, space
	li	$v0, 4
	syscall
	
	nop
	add	$a0, $zero, $s2
	li	$v0, 1
	syscall
	
	nop
	la	$a0, space
	li	$v0, 4
	syscall
	
	nop
	la	$a0, space
	li	$v0, 4
	syscall
	
	nop
	add	$a0, $zero, $s3
	li	$v0, 4
	syscall
	
	
done_print_table:
	jr	$ra
