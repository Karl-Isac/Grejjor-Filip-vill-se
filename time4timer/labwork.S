  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm
  #
  # Please add your own code below this line
  #
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
	li $s0, 9000
	bne $a0, $0, loop
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
	
	
	#addi	$s4, $0, 0x0
	#sb	$s4, 5($s0)
	
.global Checklast
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
	
.global End
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

	
	

