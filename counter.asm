; Counts from 0 to 100 000 000 000 and then prints the result,
; which will obviously be 100 000 000 000

section .data

	newline db 10
	
	sys_write equ 4
	stdout equ 1
	sys_exit equ 1
	ascii_norm equ 48

section .bss

	numbuf resb 10

section .text
global _start

_start:
	xor rcx, rcx		; clear ECX

	.loop:

	inc rcx			; increment ECX
	mov rax, 0x174876E800	; move decimal 100 000 000 000 into EAX
	cmp rcx, rax		; compare ECX with decimal 100 000 000 000

	jne .loop		; repeat loop until equal
	
	call conv	
	
	mov rdx, rcx		; length of our string
	mov rcx, rax		; our string pointer
	mov rax, sys_write	; set mode to writing
	mov rbx, stdout		; set target to stdout
	int 0x80		; call kernel
	
	call new_line		; print a new line character
	
	mov rax, sys_exit	; sys_exit
	mov rbx, 0		; return 0
	int 0x80		; call kernel

conv:
	enter 4, 0		; reserve 4 bytes in the stack
	lea r8, [numbuf+10]
	mov rcx, 10
	mov [rbp-4], dword 0

	.divloop:
	
	xor rdx, rdx		; clear EDX
	idiv rcx		; divide ECX
	add rdx, ascii_norm	; add decimal 48 to EDX (x+48 is the ASCII representation of x)
	dec r8			; decrement stack pointer
	mov byte [r8], dl
	inc dword [rbp-4]
	
	cmp rax, 0		; compare EAX to 0
	jnz .divloop		; repeat if not 0
	
	mov rax, r8
	mov rcx, [rbp-4]
	
	leave			; restore stack
	ret

new_line:			; writes a new line to the screen
	mov rax, sys_write
	mov rbx, stdout
	mov rcx, newline
	mov rdx, 1
	int 0x80
	
	ret
