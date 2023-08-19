; hash function

org &4000

;ld hl, &017f
;ld bc, &ff

;ld hl, &3e8
;ld bc, &19

key1 defb 'SWAP',0
HASH_ADDR equ &8888
ld a,0
ld de, key1
ld hl, &0000

; compute the ascii sum of consecutive memory addresses i.e. defb
ascii_sum:
	  ld a, (de) ; store char for loop control (if a=255 exit)
	  ld (&5555), a  ; move char to temp addr
	  ld bc, (&5555) ; move temp addr char to bc so we can add. 

	  add hl, bc ; sum will be in HL
	  inc de
	  cp 0 
	  jp nz,ascii_sum

; HL should be 013B


; compute the hash by doing ascii_sum MOD 255 (255 will be the length of the hashtable)
ld hl, &1fe
ld bc, &ff
;sbc hl, bc 

compute_modulo:
	sbc hl, bc
	push hl
	jp nc, compute_modulo
	jp c, store_hash
	

; this should be 3C from the example.

store_hash:
	pop hl ; we want the one before the carry bit was flipped.
	ld (HASH_ADDR), hl

ret
