;; is_number subroutine
;; Entry: HL points to memory address. Read until '0D' and check if each
;;        hex value corresponds to a digit in the ASCII table.
;; Exit:  HL will be corrupted, B will hold either the number of digits, or 0
;;	  if the memory bytes are not a number. 

;; '32 35 35 0D' 	--> '255'
;; '32 35 35 65 0D' 	-->  NaN


;; test, simulate main entry here
;; ----------------------------------------------------------------------------
org	&4000
ld 	hl,&5555

dec 	hl  ; decrement HL so proper offset starts with an increment inside loop.
ld 	b,0 ; reset B to hold number of digits.

;; ----------------------------------------------------------------------------
;; test, end simulated main entry here


get_next_byte:
	inc hl
	ld a,(hl)
	cp &0d
	ret z	
	cp &40	; check if there is an underflow.
	call c, number_found
	call nc, NaN
	;; if NaN was called, and we continue from here, we need to break,
	;; and not wait for '0D', since the memory sequence is illegal.
	ret nc 
	jp get_next_byte	

	number_found:
		inc b 
		ret
	NaN:
		ld b,0
		  ret


;; works! :-)
;; Tue Sep 19 00:18:21 EEST 2023
;; gif.
