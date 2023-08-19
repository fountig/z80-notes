; hash function

org &4000

;ld hl, &017f
;ld bc, &ff

ld hl, &3e8
ld bc, &19

sbc hl, bc ; do the first division outside of loop, so we can begin the loop with 'pop hl'
	   ; otherwise if we have only push within the loop, the stack gets filled with 
           ; all the previous computations, and 'ret' jumps to a random address.
push hl    

compute_modulo:
	pop hl
	sbc hl, bc
	push hl
	jp nc, compute_modulo
	

pop hl ; we want the one before the carry bit was flipped.
ret
