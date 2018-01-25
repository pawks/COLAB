;-------------------------------------------------------------------------------
  .equ pr_stdout,0x69                     ;replace pr_stdout with 0x00
  .equ file_open,0x66                     ;replace file_open with 0x66
  .equ file_write,0x69                    ;replace file_write with 0x69
  .equ file_read,0x6a                     ;replace file_read with 0x69
  .equ file_close,0x68                    ;replace file_close with 0x68
  .equ exit,0x11                          ;replace exit with 0x11
;  .global _start
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
  ldr r1,=text                            ;r1=address of the destination
  mov r2,#512
  swi file_read                           ;read from the file
  bcs Eofreached
  b Read
Close:
  ldr r0,=filehandle
  ldr r0,[r0]
  swi file_close                          ;close file
  mov pc,lr
_start:
  bl Open
  bl Read
  bl Close
  b EXIT
EXIT:
  swi exit                                ;HALT
ERR:
  ldr r0,=ferr_msg                        ;error message into r0
  swi pr_stdout                           ;print onto stdout
  swi pr_stdout                           ;print onto stdout
  b EXIT
Eofreached:
  mov r0,#1
  ldr r1,=text                            ;the contents of the file into r1
  swi pr_stdout                           ;print onto stdout
  mov pc,lr
;-------------------------------------------------------------------------------
filehandle: .skip 4
filename: .asciz "file.txt"
ferr_msg: .asciz "Error openning file\n"
rerr_msg: .asciz "Error reading file\n"
text: .skip 512
