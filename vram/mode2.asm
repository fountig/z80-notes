org &9c40
;; set mode 2

ld a, 2  
call &bc0e

;; draw

ld hl, &c000
ld (hl), &ff

ld hl, &c002
ld (hl), &ff

ld hl, &c004
ld (hl), &ff

ld hl, &c006
ld (hl), &ff

ld hl, &c008
ld (hl), &ff

ld hl, &c00a
ld (hl), &ff


noret: 
jp noret
