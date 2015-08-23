; Basic 'print "Hello world!" program'

section .text

	global _start

_start:

    mov     edx, len                            ;message length
    mov     ecx, msg                            ;message to write
    mov     ebx, 1                              ;stdout
    mov     eax, 4                              ;system write
    int     0x80                                ;call kernel

    mov     eax, 1                              ;system exit
    int     0x80                                ;call kernel

section .data

msg     db  'Hello world!', 0xa
len     equ $ - msg
