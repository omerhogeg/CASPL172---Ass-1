section	.rodata
LC0:
	DB	"%s", 10, 0	; Format string

section .bss

nibble_conversion_table:
	resb 256
LC1:
	RESB	256

section .text
	align 16
	global my_func
	extern printf
; we take this program from the Class material and we make some change!!!
my_func:
	push	ebp
	mov	ebp, esp	; Entry code - set up ebp and esp
	pushad			; Save registers

	mov ecx, dword [ebp+8]	; Get argument (pointer to string)
;       Your code should be here...
	call setup_conversion_table
	
	mov esi,ecx
	mov edi,LC1
	
	.loop:
                mov eax, 0
                mov al, byte [esi]	; high nibble
                cmp al, 0		; bss is initialized to zeros
                je .done		; bad input
                mov ebx, 0
                mov bl, byte [esi + 1]			     ; low nibble
                mov al, byte [nibble_conversion_table + eax] ; value of high nibble
                mov bl, byte [nibble_conversion_table + ebx] ; value low nibble
                shl al, 4				     ; al *= 16
                add al, bl				     ; al += bl
                mov byte [edi], al	; add char to output string
                add esi, 2		; advance by two bytes in input
                inc edi			; advance by one  byte in output
                jmp .loop
                
          .done:
                push	LC1		; Call printf with 2 arguments: pointer to str
                push	LC0		; and pointer to format string.
                call	printf
                add 	esp,2*4; Clean up stack after call

                popad			; Restore registers
                mov	esp, ebp	; Function exit code
                pop	ebp
                ret
                

      
setup_conversion_table:
	mov byte [nibble_conversion_table + '1'], 1
	mov byte [nibble_conversion_table + '2'], 2
	mov byte [nibble_conversion_table + '3'], 3
	mov byte [nibble_conversion_table + '4'], 4
	mov byte [nibble_conversion_table + '5'], 5
	mov byte [nibble_conversion_table + '6'], 6
	mov byte [nibble_conversion_table + '7'], 7
	mov byte [nibble_conversion_table + '8'], 8
	mov byte [nibble_conversion_table + '9'], 9
	mov byte [nibble_conversion_table + 'a'], 10
	mov byte [nibble_conversion_table + 'b'], 11
	mov byte [nibble_conversion_table + 'c'], 12
	mov byte [nibble_conversion_table + 'd'], 13
	mov byte [nibble_conversion_table + 'e'], 14
	mov byte [nibble_conversion_table + 'f'], 15
	mov byte [nibble_conversion_table + 'A'], 10
	mov byte [nibble_conversion_table + 'B'], 11
	mov byte [nibble_conversion_table + 'C'], 12
	mov byte [nibble_conversion_table + 'D'], 13
	mov byte [nibble_conversion_table + 'E'], 14
	mov byte [nibble_conversion_table + 'F'], 15
	ret
	