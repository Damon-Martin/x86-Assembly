.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode: DWORD

.data ; data segment
    A DWORD 3,2,3,1,7,5,7,8,9,2
    B DWORD [10]
.code
main PROC ; main procedure
    lea edi, A ;Loads A memory adress to EDI [EDI is pointer to A]
    lea ecx, B ;Loads B memory adress to ECX [ECX is pointer to B]

    ;ESI Must be used instead of using i like the c code but functions the same as an iterator
    mov esi, 0 ;Start from 0 and when first loop it inc +1. This loops 10 times.
update:
    ;eax will be our SUM
    ;must folow ORDER OF OPERATIONS
    ;eax is the accumulator register
    ;calculating 5*i
    mov eax, 5
    mov ebx, esi ;moves current iteration to EBX
    mul ebx ;EAX = EBX * EAX

    ;calculating sum + & in (5i+7)
    add eax, 7

    ;divides from eax for 5i+7 / 3
    mov edx, 0
    mov ebx, 3 ;divisor the thing it will divide with
    div ebx
    ;result in eax and the remainder is in edx

    ;calculating sum * 2 for 2 ((5i+7)/3);
    mov ebx, 2 ;moves 2 to multiplier
    mul ebx ;EAX = eax * ebx

    ;now adding A[i] + sum for A[i] + 2 * ( (5*i+7) / 3);
    add eax, [edi + TYPE A * esi] 
    ;then store into B[i]
    mov [ecx + TYPE B * esi], eax
    ;to fix this 

    inc esi
    cmp esi, 10    ;if esi == 10 then EXIT loop
    jne update    ;jump to the label if condition IS NOT MET


    INVOKE ExitProcess, 0 ; call exit function

main ENDP ; exit main procedure
END main  ; stop assembling
