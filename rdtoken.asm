; We setup a text buffer at &9c40 using the &BD5E call.


 
org &5030

; jump table experiment
LIT_INT_ZER defb &C9
LIT_INT_ONE defb &C9
LIT_INT_TWO defb &C9
LIT_INT_THR defb &C9
LIT_INT_FOU defb &C9
LIT_INT_FIV defb &C9
LIT_INT_SIX defb &C9
LIT_INT_SEV defb &C9
LIT_INT_EIG defb &C9
LIT_INT_NIN defb &C9



ORG &4100

cur_token_address equ &4700

;  Firmware calls we need. 
LD DE, cur_token_address

LD HL, &4800
CALL &BD5E


; parse the buffer text. Let's try reading until we hit an ASCII code of '20'

get_next_token:
	; read byte at &9c40
	; is it 20 ? if so, then jump to parse
	; is it sth else? increase 
	
	ld a, (hl)
	cp &20
	jp z, parse_token
	ld (de), a
	inc hl 
	inc de
	jp nz, get_next_token
	



parse_token:
	; jump table ?
	; &80nn for every ASCII character
	; undefined tokens  do a 'JP error'
	; defined tokens, such as integers from 0 to 9, do a ld (mystack), digit
	; you can use an offset to calculate the jump addres, it probably wont be the ASCII code.
	
	
	dec de
	ld h, &50
	ld a, (de)
	ld l, a
	jp (hl)
	
ret




