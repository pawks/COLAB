;-------------------------------------------------------------------------------
  .equ pr_stdout,0x00                     ;replace pr_stdout with 0x00
  .equ open,0x66                          ;replace file_open with 0x66
  .equ write,0x6b                         ;replace write with 0x69
  .equ read,0x6c                          ;replace read with 0x69
  .equ close,0x68                         ;replace close with 0x68
  .equ exit,0x11                          ;replace exit with 0x11
;-------------------------------------------------------------------------------
  Read:
  mov r0,#0
  swi read
  bcs Read
  mov r1,r0
  mov r0,#1
  swi write
;-------------------------------------------------------------------------------
var: .skip 3
