Amstrad Z80 machine code notes
==============================


```
ORG &9c40

LD IX,&9C70
LD BC,&FFFE

LD (IX+0), B
LD (IX+1), C
RET	
```

3. How to add 2 16-bit numbers together?
```
ORG &9c40

LD IX,&9C70
LD HL,0
LD BC, 1
LD DE, 2

ADD HL,BC
ADD HL,DE

LD (IX+0),H
LD (IX+1),L
RET
```

or skip BC and just use two registers storing the value to HL.

```
LD Hl,1
LD DE,2
```
# Do a 'for loop' from 0 to 10. We increment a memory address with a value of 0, ten times.
```
org &9c40

ld a,10
ld b,0
ld hl,&9ca0

loop:

	cp b
	jp z,loop_exit

	inc (hl)
	inc b
	jp loop	
loop_exit:
  ret
```
# do a for loop, printing 0123456789 to the screen.
```
org &9c40

ld a,47        ; 47 is one character before '0'. 
ld hl,&9ca0    ; we load HL with the address to put '47' 
ld (hl),a      ; we load the address pointed at HL with 47


ld a,10        ; loop 10 times
ld b,0


loop:

	cp b
	jp z,loop_exit

	inc (hl)
	ld a,(hl)
	call &bb5a

	ld a,10
	inc b
	jp loop	
loop_exit:
	ret
```

# Print '=' if two integers are equal, '<' if A is less than compared, '>' if greater
```
org #9c40

PrintChar equ #bb5a

ld a,10
sub 100

jp Z, equal
jp NC, greaterthan
jp C, lessthan
ret


lessthan: 
	ld a,'<'
	call PrintChar
	ret

greaterthan:
	ld a,'>'
	call PrintChar
	ret

equal:
	ld a,'='
	call PrintChar
	ret
 ```

# Store 8-bit and 16-bit values to memory addresses.
```
org #9c40

; store an 8-bit value to a memory address
ld a,254
ld (#9c60), a

; store a 16-bit value to a memory address.
; This will get stored backwards, 'aa' in 9c70 and 'ff' in 9c71.

ld hl, #ffaa
ld (#9c70), hl

; store a 16-bit value from memory to a 16-bit register. This will also store the values
; in 9c70 and 9c71.

ld bc, (#9c70)

ret
```

