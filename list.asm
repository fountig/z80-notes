; implement a simple list capable for storing up to 255 bytes. 
; byte at &9c8c is the length, rest of bytes are the values.

org &9c40

list_length_addr equ &9c8c
list_start_addr equ &9c8d


; store item at list_start_addr

ld a, &65

ld hl, list_start_addr 
ld (hl), a 

; increment by one the value pointed at list_length_addr
ld hl, list_length_addr ;
inc (hl)

ld a, &66
; calculate where we will store it. 
ld hl, list_start_addr
ld bc, (list_length_addr)
ld b, &00 ; this becomes 00xx
add hl, bc
; store
ld (hl), a
ld hl, list_length_addr
inc (hl)


ld a, &67
; calculate where we will store it. 
ld hl, list_start_addr
ld bc, (list_length_addr)
ld b, &00 ; this becomes 00xx
add hl, bc
; store
ld (hl), a
ld hl, list_length_addr
inc (hl)



ret
