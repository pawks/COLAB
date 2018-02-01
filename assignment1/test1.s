loop:
mov r0,#0
ldr r1,=0x2000
mov r2,#20
swi 0x6a
cmp r0,#0
beq loop
mov r0,#1
swi 0x69
swi 0x11
test: .skip 20
.align
