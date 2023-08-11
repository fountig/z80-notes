; read an 8-bit integer
; e.g. if  user types '37' and presses [ENTER], then the memory block becomes:
; 
; &9C90 03
; &9C91 07
; 
; TODO: The target is to somehow compute that it is '37', and store it in the memory directly.


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


; initialise stuff
CALL txt_cur_enable;
CALL txt_cur_on ; enable the text cursor. 
LD BC, &9D00 ; Where our string will be stored.

; Clear memory block

LD A, 255
CALL clear_memory

; Begin!
CALL read_int

; Move the cursor one line down after [ENTER] 
; has been pressed, otherwise the string you typed will be 
; overwritten by the 'Ready' prompt.
CALL txt_get_cursor ; get cursor's current position. H contains row number, L contains line number
INC H		    ; increment L by one.
CALL txt_set_cursor ; set the cursor. 

RET

read_int:
	CALL km_wait_char  	; read a character from keyboard, store it to A
	CP &7F	   		; did we press delete?
	CALL Z, delete_int	; if yes then call the delete_char subroutine
	
	CP &10
	CALL NZ,store_int      ; store character to the memory address pointed by BC
				; only if the character is not a 'delete' character!
	ADD &30
	CALL txt_output         ; print the character value that is stored in A
	CP &0D                  ; test if x0D, the ASCII value of RETURN, is pressed.
	JP nz, read_int      ; if no, loop again
	RET		        ; if yes, exit. 

delete_int:
	CALL txt_get_cursor	; get cursor coords in HL
	DEC H			; Decrement H, i.e to move the cursor to the left.
	CALL txt_set_cursor	; Update cursor position.

	DEC BC			; decrement the BC pointer 
	LD A,0
	LD (BC),A		; clear the character byte at the memory address we currently are.
	LD A,&10		; load the 'delete' character in A, preparing for txt_output
	
	RET

store_int:
	SUB &30
	LD (BC), A 	   	; store character to the memory address pointed by HL
	INC BC 		   	; increment HL, so we can store the next character at the next memory	
	RET
clear_memory:
	PUSH AF
	CP A
	JP NZ, clear_memory
	LD A,0
	LD (BC), A
	POP AF
	DEC A 
	RET


