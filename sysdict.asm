org &9c40
txt_output equ &bb5a
text_input equ &bd5e

forth_line equ &9faa


xor a
nop

ld hl, forth_line
call text_input



ld a,(hl) ; store buffer character to A

; ok this works hardwired
; but what about the user defined ones in sysdict?
cp &2b
call z, PLUS
cp &2d
call z, MINUS
cp &2e
call z, DOT
inc hl



ret

PLUS:
	ld a,'+'
	call txt_output
	ld a,'!'
	call txt_output
	ret
MINUS:
	ld a,'-'
	call txt_output
	ld a,'!'
	call txt_output
	ret

DOT:
	ld a,'.'
	call txt_output
	ld a,'!'
	call txt_output
	ret
org &9caa

sysdict:	db &2b, &a0, &00; 'p'  &a000
	 	db &2d, &a0, &ff; '%'  &a0ff
		db &2e, &a1, &fe; '*'  &a1fe

org &a000
LC_PI: 
	ld a,'p'
	call txt_output
	ld a,'!'
	call txt_output
	ret

org &a0ff
SIGN_PERCENT:
	ld a,'%'
	call txt_output
	ld a,'!'
	call txt_output
	ret

org &a1fe
MULT:
	ld a,'*'
	call txt_output
	ld a,'!'
	call txt_output
	ret

