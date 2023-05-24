.data
	msgInput:	.asciiz	"Enter a number"
	msgResult:	.asciiz "Digit degree is "
.text
	main:
		la	$a0, msgInput
		li	$v0, 51
		syscall
		add	$s0, $zero, $a0
		
		add	$a0, $zero, $s0
		jal	calculate_digit_degree
		add	$s1, $zero, $v0
		nop
		
		la	$a0, msgResult
		add	$a1, $zero, $v0
		li	$v0, 56
		syscall
		nop
		
		li	$v0, 10
		syscall
	endmain:
#--------------------------------------------------------------------
# function calculate_digit_degree
# param[in] $a0 input number
# return $v0 digit degree
#--------------------------------------------------------------------
calculate_digit_degree:
	xor	$t0, $zero, $zero		# Digit degree = 0
	addi	$t1, $zero, 10
	blt	$a0, $t1, end_digit_degree

	set_sum:
		xor	$t2, $zero, $zero	# sum = 0
	sumOfDigits_loop:
		div	$a0, $t1
		mfhi	$t3
		add	$t2, $t2, $t3
		mflo	$a0
		beq	$a0, $zero, check_end
		j	sumOfDigits_loop
	check_end:
		addi	$t0, $t0, 1
		blt	$t2, $t1, end_digit_degree
		add	$a0, $zero, $t2
		j	set_sum
		
end_digit_degree:
	add	$v0, $zero, $t0
	jr	$ra	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	