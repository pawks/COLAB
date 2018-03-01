.equ malloc,0x12
.equ dealloc,0x13
.equ halt,0x11
.equ pr_stdout,0x02
.equ file_open,0x66
.equ file_write,0x69
.equ file_close,0x68
.equ int_write,0x6b
.global _start
;-------------------------------------------------------------------------------
allocate:
  stmdb sp!,{r0-r1,lr}
  mov r0,#400
  swi malloc
  bcs error
  ldr r1,=address
  str r0,[r1]
  ldmia sp!,{r0-r1,pc}
initialise:
  stmdb sp!,{r0-r2,lr}
  mov r2,#1
  ldr r1,=address
  ldr r0,[r1]
  iloop:
    str r2,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne iloop
  ldmia sp!,{r0-r2,pc}
incrementp:
  stmdb sp!,{r0-r2,lr}
  mov r2,#1
  ldr r1,=address
  ldr r0,[r1]
  iploop:
    ldr r1,[r0]
    add r1,r1,#1
    str r1,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne iploop
  ldmia sp!,{r0-r2,pc}
copy:
  stmdb sp!,{r0-r3,lr}
  mov r2,#1
  mov r0,#400
  swi malloc
  bcs error
  ldr r1,=caddress
  str r0,[r1]
  ldr r1,=address
  ldr r1,[r1]
  cploop:
    ldr r3,[r1],#4
    str r3,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne cploop
  ldmia sp!,{r0-r3,pc}
addback:
  stmdb sp!,{r0-r4,lr}
  mov r2,#1
  ldr r1,=caddress
  ldr r1,[r1]
  ldr r0,=address
  ldr r0,[r0]
  adloop:
    ldr r4,[r1],#4
    ldr r3,[r0]
    add r3,r3,r4
    str r3,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne adloop
  ldmia sp!,{r0-r4,pc}
multiply:
  stmdb sp!,{r0-r2,lr}
  mov r2,#1
  ldr r0,=address
  ldr r0,[r0]
  mloop:
    ldr r1,[r0]
    add r1,r1,r1,lsl #2
    str r1,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne mloop
  ldmia sp!,{r0-r2,pc}
divide:
  stmdb sp!,{r0-r2,lr}
  mov r2,#1
  ldr r0,=address
  ldr r0,[r0]
  dloop:
    ldr r1,[r0]
    mov r1,r1,lsr #2
    str r1,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne dloop
  ldmia sp!,{r0-r2,pc}
add:
  stmdb sp!,{r0-r3,lr}
  mov r2,#1
  mov r3,#1
  mov r3,r3,lsl #14
  ldr r1,=address
  ldr r0,[r1]
  aloop:
    ldr r1,[r0]
    add r1,r1,r3
    str r1,[r0],#4
    add r2,r2,#1
    cmp r2,#101
    bne aloop
  ldmia sp!,{r0-r3,pc}
open:
  stmdb sp!,{r0-r1,lr}
  ldr r0,=filename
  mov r1,#1
  swi 0x66
  bcs file_error
  ldr r1,=filehandle
  str r0,[r1]
  ldmia sp!,{r0-r1,pc}
filewrite:
  stmdb sp!,{r0-r3,lr}
  ldr r0,=filehandle
  ldr r0,[r0]
  mov r3,#1
  ldr r2,=address
  ldr r2,[r2]
  wloop:
    ldr r1,[r2],#4
    swi int_write
    ldr r1,=newline
    swi file_write
    add r3,r3,#1
    cmp r3,#101
    bne wloop
  ldmia sp!,{r0-r3,pc}
_start:
  bl open
  bl allocate
  bl initialise
  bl incrementp
  bl copy
  bl addback
  bl multiply
  bl divide
  bl add
  mov r0,#0
  adds r0,r0,r0
  bl filewrite
  bl exit
exit:
  ldr r0,=filehandle
  ldr r0,[r0]
  swi file_close
  swi dealloc
  swi halt
error:
  ldr r0,=merr_msg
  swi pr_stdout
  b exit
file_error:
  ldr r0,=ferr_msg
  swi pr_stdout
  b exit
;-------------------------------------------------------------------------------
merr_msg: .asciz "Memory allocation failure."
address: .word 0
caddress: .word 0
filename: .asciz "file.txt"
filehandle: .word 0
ferr_msg: .asciz "File open error."
newline: .asciz "\n"
