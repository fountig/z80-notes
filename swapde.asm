; let's say that DE holds 1234h. we want to swap D and E so that DE holds 3412h.

ld de, &1234

; one way of doing it without altering anything is the following.
; it takes 45 cycles!
; From Mastering Machine Code on your Amstrad, pg. 37

push de
push de
inc sp
pop de
inc sp

;  This takes 12 cycles and A gets corrupted.

ld a,d
ld d,e
ld e,a

; You can also use PUSH/POP to restore A, and still the
; cycle count is 34..!

push af
ld a,d
ld d,e
ld e,a
pop af
