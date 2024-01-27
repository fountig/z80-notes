; msve print
; This is an annotated version of Massive Print from Gifford & Vincent's Mastering Machine Code on your Amstrad, which incidentally doesn't work properly.

org &9c40

;&BB93 TXT GET PEN
;Action Gets the foreground PEN for the current stream
;Entry No entry conditions
;Exit A contains the PEN number, the flags are corrupt, and all other registers are preserved
getpen	equ &bb93

;BB90 TXT SET PEN
;Action Sets the foreground PEN for the current stream
;Entry A contams the PEN number to use
;Exit AF and HL are corrupt, and all other registers are preserved
setpen  equ &bb90

;&BBA5 TXT GET MATRIX
;Action Gets the address of a character matrix
;Entry A contains the character whose matrix is to be found
;Exit If it is a user-defined matrix, then Carry is true; if it is in the lower ROM then Carry is false; in either
;event, HL contains the address of the matrix, A and other flags are corrupt, and others are preserved
;Notes
;The character matrix is stored in 8 bytes; the first byte is for the top row of the character, and the last
;byte refers to the bottom row of the character; bit 7 of a byte refers to the leftmost pixel of a line, and bit
;0 refers to the rightmost pixel in Mode 2.
matrix  equ &bba5


;&BB75 TXT SET CURSOR
;Action Sets the cursor's vertical and horizontal position
;Entry H contains the logical column number and L contains the logical line number
;Exit AF and HL are corrupt, and all the others are preserved
cursor	equ &bb75

; prints the character in A register
txtout	equ &bb5a


; Lower ROM enable/disable, no idea why they are here or how they work. 
romena	equ &b906
romdis	equ &b909

call getpen
push af
call romena
ld a,(ix+4)
call matrix
ex de, hl
ld l,(ix+6)
ld h,(ix+8)
ld b,8
nxtrow:
	push bc; SP=BC
	ld c,128 
	ld b,2
again:
	push bc ; SP=BC+BC
	push hl ; SP=BC+BC+HL
	call cursor 
	bit 0,b
	jr z,col2
	ld a,(ix+0)
	jr setcol
col2:
	ld a,(ix+2)
setcol:
	call setpen
	pop hl
	ld b,8
nxtcol:
	ld a,(de)
	and c
	jr z,space
	ld a,143
	jr _print
space:
	ld a,32
_print:
	call txtout
	call txtout
	srl c
	djnz nxtcol
	inc l
	pop bc
	djnz again
	inc de
	pop bc
	djnz nxtrow
	call romdis
	pop af
	call setpen
	ret
end
