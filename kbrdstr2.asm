; Read a string from the keyboard and store it character by character in a memory block,
; beginning at &9C90. Terminates if user presses ENTER.
; Heavily commented, cause I'm a noob.
;
; e.g. if  user types 'Hello' and presses [ENTER], then the memory block becomes:
; 
; &9C90 48 H
; &9C91 65 e
; &9C92 6C l
; &9C93 6C l
; &9C94 6F o
; &9C95 0D ?

ORG &9C40

;  Firmware calls we need. 

txt_output   EQU &BB5A 
km_wait_char EQU &BB06
txt_cur_on   EQU &BB81
txt_cur_enable EQU &BB7B
txt_get_cursor EQU &BB78
txt_set_cursor EQU &BB75
txt_set_column EQU &BB6F


; clear memory block, yes this can be done with cpdir or something, don't care for now.
LD A,0
LD (&9D00),A
LD (&9D01),A
LD (&9D02),A
LD (&9D03),A
LD (&9D04),A
LD (&9D05),A
LD (&9D06),A
LD (&9D07),A
LD (&9D08),A
LD (&9D09),A
LD (&9D0A),A
LD (&9D0B),A
LD (&9D0C),A
LD (&9D0D),A
LD (&9D0E),A
LD (&9D0F),A
LD (&9D10),A
LD (&9D11),A
LD (&9D12),A
LD (&9D13),A
LD (&9D14),A
LD (&9D15),A

; initialise stuff

CALL txt_cur_enable;
CALL txt_cur_on ; enable the text cursor. 
LD BC, &9D00 ; Where our string will be stored.
CALL read_string

; Move the cursor one line down after [ENTER] 
; has been pressed, otherwise the string you typed will be 
; overwritten by the 'Ready' prompt.


CALL txt_get_cursor ; get cursor's current position. H contains row number, L contains line number
INC H		    ; increment L by one.
CALL txt_set_cursor ; set the cursor. 

RET

read_string:
	CALL km_wait_char  	; read a character from keyboard, store it to A
	CP &7F	   		; did we press delete?
	CALL Z, delete_char	; if yes then call the delete_char subroutine
	
	CP &10
	CALL NZ,store_char      ; store character to the memory address pointed by BC
				; only if the character is not a 'delete' character!

	CALL txt_output         ; print the character value that is stored in A
	CP &0D                  ; test if x0D, the ASCII value of RETURN, is pressed.
	JP nz, read_string      ; if no, loop again
	RET		        ; if yes, exit. 

delete_char:
	CALL txt_get_cursor	; get cursor coords in HL
	DEC H			; Decrement H, i.e to move the cursor to the left.
	CALL txt_set_cursor	; Update cursor position.

	DEC BC			; decrement the BC pointer 
	LD A,0
	LD (BC),A		; clear the character byte at the memory address we currently are.
	LD A,&10		; load the 'delete' character in A, preparing for txt_output
	
	RET

store_char:

	LD (BC), A 	   	; store character to the memory address pointed by HL
	INC BC 		   	; increment HL, so we can store the next character at the next memory	
	RET
