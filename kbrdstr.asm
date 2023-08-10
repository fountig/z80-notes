ORG &9C40

txt_output   EQU &BB5A 
km_wait_char EQU &BB06

LD HL, &9C90 ; Where our string will be stored.
JP read_string

RET

read_string:

	CALL km_wait_char 
	LD (HL), A
	INC HL
	CALL txt_output
	CP &0D ; test if x0D, the ASCII value of RETURN, is pressed.

	JP nz, read_string ; if no, loop again
	RET		   ; if yes, exit. 




