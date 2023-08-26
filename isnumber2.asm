;; subroutine to check if ASCII VALUE in A is a decimal integer number between 0 - 9.
;; Entry: A contains ASCII character. 
;; Exit: A is corrupted. Flags are affected. Carry flag is 1 if its not a number, 0 if it is.



isnumber:
	;; Reset Carry flag 
	scf
	ccf

	;; add &c6 to A. If its more than &39, then there will be a carry. 
	;; But this doesn't work for lower bounds, for example, if A = 20, then it won't wrap

	add &c6
	call nc, _lower_bound_check
	ret

	;; so if it doesn't wrap, we need to check the possibility of the ASCII code being 00 to 20. 
	;; We subtract 30 (our lowest possible accepted value). If it wraps, the carry is set to 1.
	_lower_bound_check:
		
		sub &c6 ;; restore A's value. 
		sub &30
		ret
