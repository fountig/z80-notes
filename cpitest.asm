; CPI test
; 
org &9c40

ld a,124 	; search for 124
ld bc,15 	; array length
ld hl,array 	; array address


; basically what cpi does is 
; cp (hl)
; inc hl
; dec bc

cpi


; so if we have an array in memory and want to search it linearly
; to find where a specific element exists, we can use CPI. 
; 
ld (found), bc


ret

array: 	db	0,1,23,11,56,43,23,56,128,9,1,2,4,124,1

found:  db 	0 


