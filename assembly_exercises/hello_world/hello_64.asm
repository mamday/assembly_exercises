;From https://stackoverflow.com/questions/4252227/error-when-trying-to-run-asm-file-on-nasm-on-ubuntu/
; Compile: nasm -f elf64 hello_64.asm
; Link: ld -s -o hello_64 hello_64.o

section .data
  hello:     db 'Hello world!',10    ; 'Hello world!' plus a linefeed character
  helloLen:  equ $-hello             ; Length of the 'Hello world!' string
                                     ; (I'll explain soon)

section .text
  global _start

_start:
  mov eax,4            ; The system call for write (sys_write)
  mov ebx,1            ; File descriptor 1 - standard output
  mov ecx,hello        ; Put the offset of hello in ecx
  mov edx,helloLen     ; helloLen is a constant, so we don't need to say
                       ;  mov edx,[helloLen] to get it's actual value
  int 80h              ; Call the kernel

  mov eax,1            ; The system call for exit (sys_exit)
  mov ebx,0            ; Exit with return code of 0 (no error)
  int 80h
