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
```

# BF

*Note*
The Data Pointer will probably be HL, since we need to be able to point it to a next cell, which is a 16-bit memory address.
We can also increment the byte at the data pointer, so since we can only do 255 (ASCII) the MSB will be &00.
Testing for it to be zero, will be tricky, since we need to artificially enforce memory boundaries, i.e. zero will not mean that HL is in address &0000, but in the ORG one. 
Incrementing the data pointer means ORG+1. We also need to make sure that the data pointer will not fall off the boundary (the ORG memory address). 

```
org &0080

ld hl, &0080 ; initialise data pointer
inc hl		; > Increment the data pointer by one (to point to the next cell to the right).
dec hl		; < Decrement the data pointer by one (to point to the next cell to the left).
inc (hl)	; + Increment the byte at the data pointer by one.
dec (hl)	; - Decrement the byte at the data pointer by one.

ld a,(hl)
call &bb5a	; . output the byte at the data pointer

call &bb09
ld hl, a	; , Accept one byte of input, storing its value in the byte at the data pointer.
 
; test

jp brack1
jp brack2

brack1:

ret

brack2:

	; commands

; test if data pointer is zero (if HL=&0080)

ret 
```

# sample loop1

```
ORG &0080
LD A,0 ; Accumulator is data pointer

; ++++++++++++++++++++++++++++++++++++++++++++++++++
; [.-]

PRINTCHAR EQU &BB5A

INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A

CP 0
JP NZ,loop1
RET


loop1:
	CALL PRINTCHAR
	
	DEC A

	CP 0
	JP NZ,loop1
	ret
```

# sample inner loop

```
ORG &0080
LD A,0 ; Accumulator is data pointer

; ++++++++++++++++++++++++++++++++++++++++++++++++++
; [.[-]]

PRINTCHAR EQU &BB5A

INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A
INC A

CP 0
JP NZ,loop1
RET


loop1:
	CALL PRINTCHAR
	CP 0
	JP NZ, loop2
	ret

loop2:

	DEC A
	CP 0
	JP NZ,loop2
	ret
```
# Draw a rectangle using the Amstrad Firmware

```
org &9c40
; call &bb4e
; mode 1, cursor at top left, no clear

call &bb6c ; CLS

; move absolute
ld hl, 200
ld de, 200
call &bbc0

ld hl, 200 ; x 
ld de, 400 ; y
call &bbf6

ld hl, 200 ; x 
ld de, 400 ; y
call &bbf6

ld hl, 100
ld de, 400
call &bbf6

ld hl, 100
ld de, 200
call &bbf6

ld hl, 200
ld de, 200
call &bbf6

ret
```
# get/set cursor location example
```
ORG &9C40

;  Firmware calls we need. 

txt_output   EQU &BB5A 
km_wait_char EQU &BB06
txt_cur_on   EQU &BB81
txt_cur_enable EQU &BB7B
txt_get_cursor EQU &BB78
txt_set_cursor EQU &BB75
txt_set_column EQU &BB6F

CALL txt_cur_enable
CALL txt_cur_on
CALL txt_get_cursor

LD A,'X'
CALL txt_output
LD A,'X'
CALL txt_output
LD A,'X'
CALL txt_output

CALL txt_get_cursor
DEC H
CALL txt_set_cursor
LD A,&10
CALL txt_output

NOP
NOP

loop: jp loop
```


