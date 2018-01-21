;-------------------------------------------------------------------------------
  .equ pr_stdout,0x00                     ;replace pr_stdout with 0x00
  .equ open,0x66                          ;replace file_open with 0x66
  .equ write,0x6b                         ;replace write with 0x69
  .equ read,0x6c                          ;replace read with 0x69
  .equ close,0x68                         ;replace close with 0x68
  .equ exit,0x11                          ;replace exit with 0x11
;-------------------------------------------------------------------------------
  ldr r0,=filename                        ;store the filename into r0
  mov r1,#0                               ;initialise r1 to 1(output mode)
  swi open                           ;open file
  bcs ERR
  ldr r1,=handle                      ;use r1 to initialise filehandle
  mov r0,#0
  swi read                           ;read from the file
  bcs READ_ERROR
  swi pr_stdout                           ;print onto stdout
  ldr r0,=handle
  ldr r0,[r0]
  swi close                          ;close file
  b EXIT
EXIT:
  swi exit                                ;HALT
ERR:
  ldr r0,=ferr_msg                        ;error message into r0
  swi pr_stdout                           ;print onto stdout
  b EXIT
READ_ERROR:
  ldr r0,=rerr_msg                        ;error message into r0
  swi pr_stdout                           ;print onto pr_stdout
  b EXIT
;-------------------------------------------------------------------------------
handle: .skip 4
filename: .asciz "stdin"
ferr_msg: .asciz "Error openning file\n"
rerr_msg: .asciz "Error reading file\n"
