;; https://en.wikipedia.org/wiki/Brainfuck
org &4000

IP defw 0,0,0,0 ;; store IP address
DP defw 0,0,0,0 ;; store DP address


ld hl, &8000
ld (IP), hl
ld hl, &7000
ld (DP), hl 
main:

;; REPL


ret

;;Increment the data pointer by one (to point to the next cell to the right). 
;;
inc_DP:

	ld hl, (DP)
	inc hl
	ld (DP), hl
	ret

;;Decrement the data pointer by one (to point to the next cell to the left). 
;;
dec_DP:
	ld hl,(DP)
	dec hl
	ld (DP), hl
	ret

;;Increment the byte at the data pointer by one.
;;
inc_DP_byte:
	ld hl, (DP)
	inc (hl)
	ret

;;Decrement the byte at the data pointer by one.
;;
dec_DP_byte:
	ld hl, (DP)
	dec (hl)
	ret

;;Output the byte at the data pointer. 
;;
out_DP_byte:
	ld a,(DP)
	call &bb5a
	ret
;; Accept one byte of input, storing its value in the byte at the data pointer.
in_DP_byte:
;; TBD

