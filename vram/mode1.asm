org &9c40
;; set mode 1

ld a, 1  
call &bc0e

;; draw pixel0 

ld hl, &c000
ld (hl), &88 ; pixel0, 10001000 = red

ld hl, &c002
ld (hl), &80 ; pixel0, 10000000 = yellow 

ld hl, &c004
ld (hl), &8 ; pixel0, 00001000 = blue


noret: 
jp noret
