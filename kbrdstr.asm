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
