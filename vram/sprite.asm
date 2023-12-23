org &9c40
;; set mode 1

ld a, 1  
call &bc0e

;; draw

ld hl, &c000
ld (hl), &00 ;

ld hl, &c001
ld (hl), &00

ld hl, &c800
ld (hl), &10 ;

ld hl, &c801
ld (hl), &80 

ld hl, &d000
ld (hl), &21

ld hl, &d001
ld (hl), &48

ld hl, &d800
ld (hl), &53

ld hl, &d801
ld (hl), &ac

ld hl, &e000
ld (hl), &53

ld hl, &e001
ld (hl), &ac

ld hl, &e800
ld (hl), &21

ld hl, &e801
ld (hl), &48

ld hl, &f000
ld (hl), &10

ld hl, &f001
ld (hl), &80

ld hl, &f800
ld (hl), &00

ld hl, &f801
ld (hl), &00


noret: 
jp noret
