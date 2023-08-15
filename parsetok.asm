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
txt_output   EQU &BB5A 

LD DE, cur_token_address

LD HL, &4800
CALL &BD5E


; parse the buffer text. Let's try reading until we hit an ASCII code of '20'

get_next_token:
	; read byte at &9c40
	; is it 20 ? if so, then jump to parse
	; is it sth else? increase 
	
	ld a, (hl)

	cp &30
	call z, exec_lit_0
	cp &31
	call z, exec_lit_1
	cp &32
	call z, exec_lit_2
	cp &33
	call z, exec_lit_3
	cp &34
	call z, exec_lit_4
	cp &35
	call z, exec_lit_5
	cp &36
	call z, exec_lit_6
	cp &35
	call z, exec_lit_7
	cp &35
	call z, exec_lit_8
	cp &35
	call z, exec_lit_9
	cp &2b
	call z, exec_op_add
	cp &2d
	call z, exec_op_sub
	cp &57 ; W
	call z, exec_op_swap
	cp &44 ; D
	call z, exec_op_dup
	
	cp &20 ; ' '
	call z, exec_op_space

	cp &3d; CR
	inc hl 
	inc de
	ld (de), a
	jp z, exit_gamma
	jp nz, get_next_token 

	
	
	
exec_op_space:
	nop
	ret


exec_lit_0:
	ld a,&e4
	call txt_output
	ret

exec_lit_1:
	ld a,&e4
	call txt_output
	ret

exec_lit_2:
	ld a,&e4
	call txt_output
	ret

exec_lit_3:
	ld a,&e4
	call txt_output
	ret

exec_lit_4:
	ld a,&e4
	call txt_output
	ret

exec_lit_5:
	ld a,&e4
	call txt_output
	ret

exec_lit_6:
	ld a,&e4
	call txt_output
	ret

exec_lit_7:
	ld a,&e4
	call txt_output
	ret

exec_lit_8:
	ld a,&e4
	call txt_output
	ret

exec_lit_9:
	ld a,&e4
	call txt_output
	ret

exec_op_sub:
	ld a,&e4
	call txt_output
	ret

exec_op_add:
	ld a,&e4
	call txt_output
	ret

exec_op_swap:
	ld a,&e4
	call txt_output
	ret

exec_op_dup:
	ld a,&e4
	call txt_output
	ret

parse_error:
	ld a, &e1
	call txt_output
	ret

exit_gamma:
	ret
	
ret




;parse_token:
	; jump table ?
	; &80nn for every ASCII character
	; undefined tokens  do a 'JP error'
	; defined tokens, such as integers from 0 to 9, do a ld (mystack), digit
	; you can use an offset to calculate the jump addres, it probably wont be the ASCII code.
	
	
;	dec de
;	ld h, &50
;	ld a, (de)
;	ld l, a
;	jp (hl)
	




