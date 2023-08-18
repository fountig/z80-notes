ORG &4000

stack_bottom_address equ &5555
txt_output   EQU &BB5A 

ld bc, stack_bottom_address
push bc

LD HL, &4800
CALL &BD5E


get_next_token:
	
	ld a, (hl)
	inc hl 
	; don't increment de, we don't need another buffer, just a place
	; where the current character is stored. 
	; inc de
	
	cp &30
	jp z, exec_lit_0
	cp &31
	jp z, exec_lit_1
	cp &32
	jp z, exec_lit_2
	cp &33
	jp z, exec_lit_3
	cp &34
	jp z, exec_lit_4
	cp &35
	jp z, exec_lit_5
	cp &36
	jp z, exec_lit_6
	cp &37
	jp z, exec_lit_7
	cp &38
	jp z, exec_lit_8
	cp &39
	jp z, exec_lit_9
	cp &2b
	jp z, exec_op_add
	cp &2d
	jp z, exec_op_sub
	cp &57 ; W
	jp z, exec_op_swap
	cp &44 ; D
	jp z, exec_op_dup
	cp &2e ; .
	jp z, exec_op_dot ; prints last value and removes it from stack
	
	cp &20 ; ' '
	jp z, exec_op_space
	
	cp &00; end 

	jp z, exit_gamma
	jp nz, parse_error 
	jp get_next_token
	
exec_op_space:
	
	jp get_next_token

exec_lit_0:
	pop bc ; pop the stack pointer
	ld a, 0
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_1:
	pop bc ; pop the stack pointer
	ld a,1
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_2:
	pop bc ; pop the stack pointer
	ld a,2
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_3:
	pop bc ; pop the stack pointer
	ld a,3
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_4:
	pop bc ; pop the stack pointer
	ld a,4
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_5:
	pop bc ; pop the stack pointer
	ld a,5
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_6:
	pop bc ; pop the stack pointer
	ld a,6
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_7:
	pop bc ; pop the stack pointer
	ld a,7
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_8:
	pop bc ; pop the stack pointer
	ld a,8
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_lit_9:
	pop bc ; pop the stack pointer
	ld a,9
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

exec_op_sub:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_op_add:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_op_swap:
	pop bc
	dec bc
	ld a,(bc)
	push bc
	push af
	dec bc
	; dup start
	ld a,(bc)
	inc bc
	ld (bc), a
	; dup end

	dec bc ; go back 
	pop af ; store the previous value
	ld (bc),a
	inc bc
	inc bc
	push bc
	jp get_next_token

exec_op_dot:
	pop bc
	dec bc
	ld a, (bc)	
	add &30	; this works only for integer literals pushed in the stack. 
	call txt_output
	ld a,0 ; remove element
	ld (bc),a
	push bc
	jp get_next_token

	
exec_op_dup:
	pop bc ; pop the stack pointer
	dec bc
	ld a,(bc)
	inc bc
	ld (bc), a
	inc bc
	push bc
	jp get_next_token

parse_error:
	ld a, &e1
	call txt_output
	jp get_next_token

exit_gamma:
	pop bc
	ret
	

ret



