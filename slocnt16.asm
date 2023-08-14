; counter16, counts from 0000 to FFFF. 
; DE=counter, HL=memory address. 
; 
; After spending a couple of unsuccesful hours, going into a different rabbit hole than using a 16-bit register and decrementing it,  I came across this:
; https://map.grauw.nl/articles/fast_loops.php. The example is using ld a,d followed by or e to 
; check whether the loop is finished, an ingenius way, since you can't use CP nn. It's also quite slow
; so slow in fact there is a discernible delay after you press call xxxx and ENTER, and receiving
; the Ready prompt back. The article goes into fast 16-bit loops too.

start_addr equ &9c80

org &9c40
  
ld de,&ffff
ld hl,&0000
Loop:
    inc hl 
    ld (start_addr), hl

    dec de
    ld a,d
    or e
    jp nz,Loop

ret
   
