  # timetemplate.asm
  # Written 2015 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

.macro	PUSH (%reg)
	addi	$sp,$sp,-4
	sw	%reg,0($sp)
.end_macro

.macro	POP (%reg)
	lw	%reg,0($sp)
	addi	$sp,$sp,4
.end_macro

	.data
	.align 2
mytime:	.word 0x5957
timstr:	.ascii "text more text lots of text\0"
	.text
main:
	# print timstr
	la	$a0,timstr
	li	$v0,4
	syscall
	nop
	# wait a little
	li	$a0,10
	jal	delay
	nop
	# call tick
	la	$a0,mytime
	jal	tick
	nop
	# call your function time2string
	la	$a0,timstr
	la	$t0,mytime
	lw	$a1,0($t0)
	jal	time2string
	nop
	# print a newline
	li	$a0,10
	li	$v0,11
	syscall
	nop
	# go back and do it all again
	j	main
	nop
# tick: update time pointed to by $a0
tick:	lw	$t0,0($a0)	# get time
	addiu	$t0,$t0,1	# increase
	andi	$t1,$t0,0xf	# check lowest digit
	sltiu	$t2,$t1,0xa	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x6	# adjust lowest digit
	andi	$t1,$t0,0xf0	# check next digit
	sltiu	$t2,$t1,0x60	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa0	# adjust digit
	andi	$t1,$t0,0xf00	# check minute digit
	sltiu	$t2,$t1,0xa00	# if digit < a, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0x600	# adjust digit
	andi	$t1,$t0,0xf000	# check last digit
	sltiu	$t2,$t1,0x6000	# if digit < 6, okay
	bnez	$t2,tiend
	nop
	addiu	$t0,$t0,0xa000	# adjust last digit
tiend:	sw	$t0,0($a0)	# save updated result
	jr	$ra		# return
	nop

  # you can write your code for subroutine "hexasc" below this line
.global hexasc
hexasc: 
  	andi  $a0, $a0, 0x0f
	addi  $v0, $zero, 0x30  	#ascii 0
	add   $v0, $a0, $v0		#Lägger ihop a0 med v0 så rätt ascii skapas

					
	jr    $ra			#Hoppar tillbaka till där funktionen kallades från början
	nop
	
.global delay	
delay:	
	PUSH $s0
	li $s0, 1000
	ble $0, $a0, loop
	nop
	
	POP $s0
	jr $ra
	nop
.global loop
loop:
	addi $s0, $s0, -1
	bne $s0, 0, loop
	nop
	addi $a0, $a0, -1
	nop
	j 	delay
	nop
 	
.global time2string
time2string:

	PUSH	$s0
	PUSH	$s1
	PUSH	$s2
	PUSH	$s3
	PUSH	$s4
	PUSH	$s5
	PUSH	$s6
	PUSH	$ra
	
	add $s5, $0, $a1 
	srl $s1, $a1, 4 #Ändrar LSB
	srl $s2, $a1, 8
	srl $s3, $a1, 12

	move 	$s0, $a0
	move	$a0, $s3
	jal	hexasc
	nop
	sb	$v0, 0($s0)
	
	move	$a0, $s2

	jal	hexasc
	nop
	sb	$v0, 1($s0)
	
	addi	$s4, $0, 0x3A
	sb	$s4, 2($s0)
		
	move	$a0, $s1

	jal	hexasc
	nop

	sb	$v0, 3($s0)
	
		
	move	$a0, $s5

	jal	hexasc
	nop
	sb	$v0, 4($s0)
	
	sb $0, 5($s0)
	sb $0, 6($s0)
	#addi	$s4, $0, 0x0
	#sb	$s4, 5($s0)
	
Checklast:
	sb $0, 5($s0)
	sb $0, 6($s0)
	
	andi	$s5, $s5, 0xf
	bne	$s5, 2, End
	nop
	
	PUSH $s1
	PUSH $s2
	PUSH $s3
	li $s1,  0x54
	li $s2,  0x57
	li $s3,  0x4f
	sb $s1, 4($s0)
	sb $s2, 5($s0)
	sb $s3, 6($s0)
	
	
	andi $s1, $0, 0x0
	sb $s1, 7($s0)
	
	POP $s3
	POP $s2
	POP $s1
	

End:	
	POP 	$ra
	POP	$s6
	POP	$s5
	POP	$s4
	POP	$s3
	POP	$s2
	POP	$s1
	POP	$s0
	
	
	jr	$ra
	nop


	
	
