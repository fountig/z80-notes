ORG &9C40

WRITEC EQU &BB5A
READC EQU &BB06

LD HL, &9C90 ; Where our string will be stored.
JP read_string

RET

read_string:

	CALL READC ; x0D is 'RETURN'
	LD (HL), A
	INC HL
	CALL WRITEC
	CP &0D ; was RETURN pressed? 

	JP nz, read_string ; if yes, exit the loop.
	RET



