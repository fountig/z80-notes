; multichar tokenizer
; buffer up until a 00 is reached
; check each char if its a digit
; increment IX if the char is a digit
; increment IY in each read (calculate length)
; if its a digit then IX=IY. Final calculation is not implemented yet


org &4000

stack_bottom_address equ &5555
txt_output   	     equ &BB5A 
banner 	             db  &b2, &ba,"orth 0", 255
cls 		     equ &bc14

ld bc, stack_bottom_address
push bc


init_txt_buffer:
ld a,0

ld (&4800),a
ld (&4801),a
ld (&4802),a
ld (&4803),a
ld (&4804),a
ld (&4805),a
ld (&4806),a
ld (&4807),a
ld (&4808),a
ld (&4809),a

call cls
ld hl, &4800
call &BD5E


get_next_token:
	
	ld a, (hl)
	cp 0 

	call z, execute_init
	inc hl 
	pop bc
	ld (bc),a
	inc bc
	push bc
	inc iyl	
	jp get_next_token

execute_init:
	pop bc
	ld bc, stack_bottom_address
	ld ix, &0000
execute:


	; is it a integer number ? if yes, push to stack and return to txt_input
	; does it contain non-integer values? if yes, must be a primitive, compute
        ; its hash and see if it exists, if it doesn't throw error, if it does, execute it

	
	ld a, (bc)

	cp &30
	jp   z, a_n
	call nz, a_nan

	cp &31
	jp   z, a_n
	call nz, a_nan

	cp &32
	jp   z, a_n
	call nz, a_nan

	cp &33
	jp   z, a_n
	call nz, a_nan

	cp &34
	jp   z, a_n
	call nz, a_nan

	cp &35
	jp   z, a_n
	call nz, a_nan
	
	cp &36
	jp   z, a_n
	call nz, a_nan

	cp &37
	jp   z, a_n
	call nz, a_nan

	cp &38
	jp   z, a_n
	call nz, a_nan

	cp &39
	jp   z, a_n
	call nz, a_nan

	cp 0
	call z, init_txt_buffer
	inc bc
	
	ret

exit:
halt

a_nan:
	ret
a_n:
	inc ixl
	inc bc
	jp execute

print_result:
	; if IY-IX=0 then token is a number


ret
