; Read a string from the keyboard and store it character by character in a memory block,
; beginning at &9C90. Terminates if user presses ENTER.
; Heavily commented, cause I'm a noob :-).
;
; e.g. if  user types 'Hello' and presses [ENTER], then the memory block becomes:
; 
; &9C90 48 H
; &9C91 65 e
; &9C92 6C l
; &9C93 6C l
; &9C94 6F o
; &9C95 0D ↵


ORG &9C40

txt_output   EQU &BB5A 
km_wait_char EQU &BB06
txt_cur_on   EQU &BB81

CALL txt_cur_on ; enable the text cursor. 
LD HL, &9C90 ; Where our string will be stored.

JP read_string
RET

read_string:

	CALL km_wait_char  ; read a character from keyboard, store it to A
	LD (HL), A 	   ; store character to the memory address pointed by HL
	INC HL 		   ; increment HL, so we can store the next character at the next memory address.
	CALL txt_output    ; print the character value that is stored in A
	CP &0D             ; test if x0D, the ASCII value of RETURN, is pressed.

	JP nz, read_string ; if no, loop again
	RET		   ; if yes, exit. 
