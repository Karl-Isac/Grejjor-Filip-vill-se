  # hexmain.asm
  # Written 2015-09-04 by F Lundevall
  # Copyright abandonded - this file is in the public domain.

	.text
main:
	li	$a0,17		# change this to test different values

	jal	hexasc		# call hexasc
	nop			# delay slot filler (just in case)	

	move	$a0,$v0		# copy return value to argument register

	li	$v0,11		# syscall with v0 = 11 will print out
	syscall			# one byte from a0 to the Run I/O window
	
stop:	j	stop		# stop after one run
	nop			# delay slot filler (just in case)

  # You can write your own code for hexasc here
hexasc: 
	andi $a0, $a0, 0x0f 	#tar bort LSB
	addi  $v0, $zero, 0x30  	#ascii 0
	addi  $t0, $zero, 0x9		#kollar ifall mindre än 9 så ej behövs göras om till ascii?
	
	ble   $a0, $t0, nonletter 		#Ifall a0 mindre än eller lika med 9 hoppar ej till L1
        nop
        addi  $v0,  $v0, 0x7		#Lägger till 7 på v0 för att hoppa över ascii som ej ska användas.
 
nonletter:
	add   $v0, $v0, $a0		#Lägger ihop a0 med v0 så rätt ascii skapas
	jr    $ra			#Hoppar tillbaka till där funktionen kallades från början
	nop
  

