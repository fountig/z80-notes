; We setup a text buffer at &9c40 using the &BD5E call.
; Let's say the buffer contains '2 2 +'
; 
ORG &4000

cur_token_address equ &4096

;  Firmware calls we need. 
LD DE, cur_token_address
LD HL, &9C40
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

	ret


