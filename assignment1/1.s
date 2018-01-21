;-------------------------------------------------------------------------------
  .equ pr_stdout,0x00                     ;replace pr_stdout with 0x00
  .equ file_open,0x66                     ;replace file_open with 0x66
  .equ file_write,0x69                    ;replace file_write with 0x69
  .equ file_close,0x68                    ;replace file_close with 0x68
  .equ exit,0x11                          ;replace exit with 0x11
;-------------------------------------------------------------------------------
  ldr r0,=filename                        ;store the filename into r0
  mov r1,#1                               ;initialise r1 to 1(output mode)
  swi file_open                           ;open file
  bcs ERR
  ldr r1,=filehandle                      ;use r1 to initialise filehandle
  str r0,[r1]                             ;store the file handle
  ldr r1,=text                            ;r1=address of a null terminated string
  swi file_write                          ;write to the file
  ldr r0,=filehandle
  ldr r0,[r0]
  swi file_close                          ;close file
  swi exit                                ;HALT
ERR:
  ldr r0,=err_msg                         ;error message into r0
  swi pr_stdout                           ;print onto stdout
;-------------------------------------------------------------------------------
filehandle: .skip 4
filename: .asciz "file.txt"
err_msg: .asciz "Error openning file\n"
text: .asciz "This is the first line.\nThis is the second line.\n"
