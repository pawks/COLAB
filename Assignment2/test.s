mov r0,#4
swi 0x12
ldr r1,=address
str r0,[r1]
ldr r2,[r0]
add r2,r2,#1
str r2,[r0]
mov r0,#1
mov r1,r2
swi 0x6b
swi 0x13
swi 0x11

address: .word 0
.align
