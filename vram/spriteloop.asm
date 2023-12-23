org &9c40
;; set mode 1

ld a, 1  
call &bc0e

; set xy for sprite
ld de, &0010
ld hl, &00a0

; get sprite address in HL
call &bc1d

; set sprite source and loop 8 lines
ld de, rhombus
ld b,8

SpriteNextLine:
	push hl
		ld a, (de)	; 
		ld (hl), a
		
		inc de
		inc hl
		
		ld a, (de)
		ld (hl), a
	
		inc de
		inc hl
	pop hl
	call &bc26	; SCR_NEXT_LINE
	djnz SpriteNextLine

NoRet:
	jp NoRet

;; sprite definition (mode 1)
 

rhombus:	db	&00, &00
		db	&10, &80
		db	&21, &48
	 	db	&53, &ac
		db	&21, &48
	 	db	&10, &80
		db	&00, &00
