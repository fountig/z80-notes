org &9c40
km_wait_char 	equ	&bb06
kl_time_please	equ	&bd0d
txt_output	equ 	&bb5a

getmove:
	call km_wait_char
	cp &52
	jp z, saveplayermove
	cp &53
	jp z, saveplayermove
	cp &50
	jp z, saveplayermove
	jp nz, getmove

	saveplayermove:
		ld hl, playermove
		ld (hl), a
		jp computerturn


computerturn:
	call kl_time_please 
	ld a, l
	ld bc, MoveTable
	ld h, &00  
	add hl, bc ; MoveTable address+random offset
	ld a, (hl) ; Store move
	add &50    ; convert it to Rock/Paper/Scissors move.

	MoveTable:      db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3
                        db      0,2,3,0,2,3,0,2,3,0,2,3,0,2,3


	jp savecomputerturn

	savecomputerturn:
		ld hl, computermove
		ld (hl), a
		jp whowins

whowins:
	; all ties will set Z. 
	; Player - Computer
	;
	; 50 - 50 P 
	; 52 - 52 R
	; 53 - 53 S
	; 
	; Result=PlayerMove-ComputerMove

	; 50 - 52 = fe 
	; 50 - 53 = fd

	; 52 - 50 = 02
	; 52 - 53 = ff
 
	; 53 - 50 = 03
	; 53 - 52 = 01

	
	ld hl, playermove
	ld b, (hl)
	ld hl, computermove
	ld c, (hl)
	ld a, b
	sub c

	cp &00
	jp z, tie
	
	cp &fe		
	jp z, userwins
	
	cp &fd		
	jp z, computerwins
	
	cp &02
	jp z, computerwins 

	cp &ff
	jp z, userwins

	cp &03
	jp z, userwins
	
	cp &01
	jp z, computerwins


tie:
	ld a,'T'
	call txt_output
	ret

userwins:
	ld a,'U'
	call txt_output
	ret

computerwins:
	ld a, 'C'
	call txt_output
	ret


playermove:		db 0
computermove:		db 0 


