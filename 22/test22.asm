.data
	arr:		.space	100
	sortedArr:	.space	100
	msgInput:	.asciiz	"Enter the word"
	msgResultTitle:	.asciiz	"Result:\n"
	msgTrue:	.asciiz "Cyclone word"
	msgFalse:	.asciiz "Non-cyclone word"
.text
	main:
		li	$v0, 54
		la	$a0, msgInput
		la	$a1, arr
		addi	$a2, $zero, 100
		jal	get_string
		add	$s0, $zero, $v0
		nop
		
		la	$a0, arr
		jal	get_length
		add	$s1, $zero, $v0
		nop
		
		la	$a0, arr
		la	$a1, sortedArr
		add	$a2, $zero, $s1
		jal	sort_string
		add	$s2, $zero, $v0
		nop
		
		la	$a0, sortedArr
		add	$a1, $zero, $s1
		jal	cyclone_check
		nop
		
		li	$v0, 10
		syscall
	endmain:
	
#--------------------------------------------------------------------
# function get_string
# param[in] $a0 the message address
# param[in] $a1 bufffer address
# param[in] $a2 maximum number of characters to read
# return $v0 address of the stored string
#--------------------------------------------------------------------
get_string:
	syscall
end_get_string:
	la	$v0, arr
	jr	$ra
	
#--------------------------------------------------------------------
# function get_length
# param[in] $a0 the address of string
# return $v0 the string length
#--------------------------------------------------------------------
get_length:
	xor	$t0, $zero, $zero
	
	loop:
		add	$t1, $t0, $a0
		lb	$t1, 0($t1)
		beq	$t1, $zero, endloop
		addi	$t0, $t0, 1
		j	loop
	endloop:
		addi	$t0, $t0, -1
end_get_length:
	add	$v0, $zero, $t0
	jr	$ra
	
#--------------------------------------------------------------------
# function sort_string
# param[in] $a0 the address of string
# param[in] $a1 the address of buffer for sorted string
# param[in] $a2 string length
# return $v0 the address of sorted string
#--------------------------------------------------------------------
sort_string:
	xor	$t0, $zero, $zero		# lowest bit
	addi	$t0, $t0, -1
	addi	$t1, $a2, -1			# highest bit
	addi	$t1, $t1, 1

	addi	$a1, $a1, -1
	
	running_hi_lo:
		addi	$t0, $t0, 1
		addi	$t1, $t1, -1
		beq	$t0, $t1, stop_equal_hilo
		blt	$t1, $t0, stop_non_equal_hilo
	start_sort:
		add	$t2, $t0, $a0
		lb	$t3, 0($t2)
		addi	$a1, $a1, 1
		sb	$t3, 0($a1)
		
		add	$t2, $t1, $a0
		lb	$t3, 0($t2)
		addi	$a1, $a1, 1
		sb	$t3, 0($a1)
		
		j	running_hi_lo
	stop_equal_hilo:
		add	$t2, $t0, $a0
		lb	$t3, 0($t2)
		addi	$a1, $a1, 1
		sb	$t3, 0($a1)
		j	end_sort_string
	stop_non_equal_hilo:
		j	end_sort_string
end_sort_string:
	la	$v0, sortedArr
	jr	$ra	
	

#--------------------------------------------------------------------
# function cyclone_check
# param[in] $a0 the address of sorted string
# param[in] $a1 string length
# return $v0: 1 if true - 0 if false
#--------------------------------------------------------------------
cyclone_check:
	xor	$t0, $zero, $zero
	
	check_loop:
		addi	$t1, $t0, 1
		beq	$t1, $a1, cyclone_str
		
		add	$t2, $t0, $a0
		lb	$t3, 0($t2)
		add	$t2, $t1, $a0
		lb	$t4, 0($t2)
		blt	$t4, $t3, non_cyclone_str
		
		addi	$t0, $t0, 1
		j	check_loop
	cyclone_str:
		la	$a1, msgTrue
		j	end_cyclone_check
	non_cyclone_str:
		la	$a1, msgFalse
		j	end_cyclone_check
end_cyclone_check:
	la	$a0, msgResultTitle
	li	$v0, 59
	syscall
	jr	$ra











