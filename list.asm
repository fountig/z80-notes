; implement a list
; this is atrocious, but it seems to work, except that length gets
; reported as '3' and not '4'. But I guess you could argue that we count from 0.
; 
; Although it uses BC, it can only store up to 255 values. 

org &9c40

list_length_addr equ &9c8c
list_start_addr equ &9c8d



ld a, &65
ld hl, list_length_addr
ld hl, list_start_addr
ld bc, (list_length_addr) ; 
ld b, &00 ; this becomes 00xx, because we only want the LSB. 
add hl, bc
ld (hl), a



ld a, &66
ld hl, list_length_addr
inc (hl)
ld hl, list_start_addr
ld bc, (list_length_addr) ; 
ld b, &00 ; this becomes 00xx
add hl, bc
ld (hl), a

ld a,&67
ld hl, list_length_addr
inc (hl)
ld hl, list_start_addr
ld bc, (list_length_addr)
ld b, &00
add hl, bc
ld (hl), a


ld a,&68
ld hl, list_length_addr
inc (hl)
ld hl, list_start_addr
ld bc, (list_length_addr)
ld b, &00
add hl, bc
ld (hl), a




ret
