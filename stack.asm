; implement a FIFO stack

; init
; stack start 5555
; stack end 7777

org &4000


stack_bottom_addr equ &5555
stack_top_addr equ &7777
txt_output   EQU &BB5A 


call stack_init
ld ixh, &32
call stack_push
ld ixh, &33
call stack_push

call stack_display
call stack_pop
call stack_display


ret


; initialise stack
stack_init:
	ld hl, stack_bottom_addr
	ret

; display stack
stack_display:
	push hl
	ld hl, stack_bottom_addr
	print_s:
		ld a, (hl)
		inc hl
		call txt_output
		cp 0
		jp nz, print_s
		
	pop hl
	ret

	
; push a value to the stack
stack_push:

	push af 
	ld a, ixh
	ld (hl),a
	inc hl
	pop af
	ret

; pop a value from the stack
stack_pop:
	dec hl ; decrement the stack pointer
	push af ; store AF for later
	ld a,(hl) ; get the value from stack
	ld ixh, a ; store it to ixh for return
	ld (hl),&00
	pop af ; restore AF
	ret



