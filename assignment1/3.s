;-------------------------------------------------------------------------------
  .equ pr_stdout,0x69                     ;replace pr_stdout with 0x00
  .equ file_open,0x66                     ;replace file_open with 0x66
  .equ file_write,0x69                    ;replace file_write with 0x69
  .equ file_read,0x6a                     ;replace file_read with 0x69
  .equ file_close,0x68                    ;replace file_close with 0x68
  .equ exit,0x11                          ;replace exit with 0x11
  .equ pr_ch,0x00
  .global _start
;-------------------------------------------------------------------------------
Open:
  ldr r0,=filename                        ;store the filename into r0
  mov r1,#0                               ;initialise r1 to 1(output mode)
  swi file_open                           ;open file
  bcs ERR
  ldr r1,=filehandle                      ;use r1 to initialise filehandle
  str r0,[r1]                             ;store the file handle
  mov pc,lr
Read:
  ldr r0,=filehandle
  ldr r0,[r0]
  ldr r1,=text
  mov r2,#512
  swi file_read
  cmp r0,#0
  beq Close
  bl Print
  b Read
Close:
  ldr r0,=filehandle
  ldr r0,[r0]
  swi file_close
  b Exit
_start:
  bl Open
  bl Read
Exit:
  swi exit
ERR:
  ldr r0,=ferr_msg                        ;error message into r0
  swi pr_stdout                           ;print onto stdout
  b Exit
Print:
  ldrb r0,[r1],#1
  cmp r0,#',
  beq Skip
  swi pr_ch
  cmp r0,#0
  bne Print
  mov pc,lr
Skip:
  mov r0,#'\n
  swi pr_ch
  bal Print



;-------------------------------------------------------------------------------
filehandle: .skip 4
filename: .asciz "input.txt"
ferr_msg: .asciz "Error openning file\n"
rerr_msg: .asciz "Error reading file\n"
text: .skip 512
