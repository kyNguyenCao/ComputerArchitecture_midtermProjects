.data
	Message:	.asciiz	"Nhap so nguyen:"
	hex_result:	.asciiz "Hexadecimal result: "
.text
	main:
		li	$v0, 51
		la	$a0, Message
		syscall
		nop
		jal	convert_powerOfInput
		add	$s0, $zero, $v0
		nop
		jal	convert_squared
		add	$s1, $zero, $v0
		nop
		jal	convert_hex
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
	li	$v0, 34
	syscall
done_hex:
	jr	$ra