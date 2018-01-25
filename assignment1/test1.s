ldr r0,=filename
mov r1,#0
swi 0x66
ldr r1,=filehandle
str r0,[r1]
ldr r1,=text
mov r2,#1
swi 0x6a
ldr r0,=text
swi 0x00
ldr r0,=filehandle
ldr r0,[r0]
swi 0x68
swi 0x11
filehandle: .skip 4
text: .skip 1
filename: .asciz "input.txt"
