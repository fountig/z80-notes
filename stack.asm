; implement a FIFO stack

; init
; stack start 5555
; stack end 7777

org &4000

stack_bottom_addr equ &5555
stack_top_addr equ &7777
txt_output   EQU &BB5A 

; delimit the stack's bottom.
LD A, &A6
LD (&5555), A
; delimit the stack's bottom.

ld hl, stack_bottom_addr
call stack_display

; display stack
stack_display:
	ld a, (hl)
	inc hl
	cp 0
	call txt_output
	jp nz, stack_display
	jp z, __exit
	
__exit:

	ret

	
; push a value to the stack


; pop a value from the stack
ret
