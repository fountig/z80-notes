org &9c40

ld hl, &1234
ld bc, &5678

; copy hl to bc (Mastering Machine Code on your Amstrad)
; This takes 22 cycles. 
;
push bc 
pop hl

ld hl, &1234
ld bc, &5678
; Same but this takes only 14 cycles.

ld h, b  
ld l, c

ret
