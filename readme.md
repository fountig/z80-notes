Amstrad Z80 machine code notes
==============================


1. You can't load a value from a register to a memory address directly using LD.
You can do the opposite, load a register from a memory address.

2. You cant do LD (HL),BC. So how to store a 16-bit register to a memory address?
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
