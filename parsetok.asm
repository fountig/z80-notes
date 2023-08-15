ORG &4000

cur_token_address equ &4700
txt_output   EQU &BB5A 

LD DE, cur_token_address
LD HL, &4800
CALL &BD5E

get_next_token:
	
	ld a, (hl)
	inc hl 
	inc de
	ld (de), a
	
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
	cp &35
	jp z, exec_lit_7
	cp &35
	jp z, exec_lit_8
	cp &35
	jp z, exec_lit_9
	cp &2b
	jp z, exec_op_add
	cp &2d
	jp z, exec_op_sub
	cp &57 ; W
	jp z, exec_op_swap
	cp &44 ; D
	jp z, exec_op_dup
	
	cp &20 ; ' '
	jp z, exec_op_space
	
	cp &00; end 

	jp z, exit_gamma
	jp nz, parse_error 
	jp get_next_token
	
exec_op_space:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_0:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_1:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_2:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_3:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_4:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_5:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_6:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_7:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_8:
	ld a,&e4
	call txt_output
	jp get_next_token

exec_lit_9:
	ld a,&e4
	call txt_output
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
	ld a,&e4
	call txt_output
	jp get_next_token

exec_op_dup:
	ld a,&e4
	call txt_output
	jp get_next_token

parse_error:
	ld a, &e1
	call txt_output
	jp get_next_token

exit_gamma:
	ret
	

ret



