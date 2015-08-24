BITS 64

jmp _start
nop

_start:
	mov rax, 0x7C0		; Setup 4k stack space after this bootloader
	add rax, 288		; (4096+515) / 16 bytes per paragraph
	cli			; Disable Interrupts
	mov ss, rax
	mov rsp, 4096
	sti			; Enable Interrupts

	mov rax, 0x7C0		; Set data segment to the load point of
	mov ds, rax		; our application

	call run_stuff
	jmp $

;------------------------------------------------------------------------------------------------------

v_message	db 'Hello world! This seems to work o.O', 0xD, 0xA, 0x0

run_stuff:
	call print_helloworld
	ret

print_helloworld:
	mov si, v_message
	call print_string
	ret

print_string:
	push rax
	mov ah, 0xE
	
.repeat:
	lodsb
	cmp al, 0x0
	je .done
	int 0x10
	jmp .repeat
	
.done:
	pop rax
	ret

;------------------------------------------------------------------------------------------------------

times 510-($-$$) db 0
dw 0xAA55
