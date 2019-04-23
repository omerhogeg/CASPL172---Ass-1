
section .data
             msg: db "%d",10,0
             format: db "x or k, or both are off range" , 10,0
            

section .text
	align 16
	global calc_div
	extern check,printf

calc_div:
	push	ebp
	mov	ebp, esp	; Entry code - setx up ebp and esp
	pushad			; Save registers

	mov ecx, dword [ebp+8]	; first argument
	mov edx, dword [ebp+12] ; second argument
	push edx
	push ecx
	call check	
	mov ebx,1
	cmp eax,0
	je print_end_of_func
	jne our_div
	
	print_end_of_func:
                        push dword format
                        call printf
                        mov esp, ebp; Function exit code
                        pop ebp
                        ret
                        
                        
        our_div:
                mov eax,0
                cmp edx,0
                je get_zero_in_second_arg
                jne lets_start_to_div
                
                
                
        get_zero_in_second_arg:
                                mov eax,ecx
                                jmp done
                                
                                
                                
        lets_start_to_div:
                            sub edx,1
                            shl ebx,1
                            cmp edx,0
                            je check_for_div
                            jne our_div

                            
          check_for_div:
                cmp ecx,ebx
                jl done
                jge now_we_div
                
          now_we_div:
                    inc eax
                    sub ecx,ebx
                    cmp ecx,0
                    jg now_we_div
                    je done
                    sub eax,1
                    jmp done

                
        done:
            push eax
            push msg
            call printf
            add esp,8
            
            

                mov esp, ebp; Function exit code
                pop ebp
                ret
            
           
        