org &4000

;; manually convert '32 35 35' to FF.

ld a, &32 	;; '2'
sub &30		;; 0x02

ld b, a

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
add b

add b
add b
add b
add b
add b
add b
add b
add b
add b
;;add b

ld (&5555),a

;; 
ld a, &35
sub &30

ld b,a

add b
add b
add b
add b
add b
add b
add b
add b
add b

ld (&5556),a

;;

ld a,&35
sub &30
ld (&5557),a

;; magic
ld a, &00
ld hl, &5555
add a,(hl)
ld hl, &5556
add a,(hl)
ld hl, &55557
add a,(hl)

ret
