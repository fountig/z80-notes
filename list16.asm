; implement a simple list capable for storing up to 65535 bytes. 
; byte at &9c8c is the length (two bytes), rest of bytes are the values.

org &9c40

list_length_addr equ &9c8c
list_start_addr equ &9c8e

; set BC to 0x0000 so to use it as a length counter

ld bc, &0000

; store item at list_start_addr

ld a, &65

ld hl, list_start_addr 
ld (hl), a 


; increment by one the value pointed at list_length_addr. We need to store the value at the second byte
; and not the first at the start, and change the code so we count in hex, not in dec.

ld hl, list_length_addr ;
inc (hl)


ld a, &66
; calculate where we will store it. 
ld hl, list_start_addr
ld bc, (list_length_addr)
;ld b, &00 ; this becomes 00xx
add hl, bc
; store
ld (hl), a
ld hl, list_length_addr
inc (hl)


ld a, &67
; calculate where we will store it. 
ld hl, list_start_addr
ld bc, (list_length_addr)
;ld b, &00 ; this becomes 00xx
add hl, bc
; store
ld (hl), a
ld hl, list_length_addr
inc (hl)



ret
