.text
.globl invert

invert:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi

    movl 8(%ebp), %ecx
    movl (%ecx), %edi
    movl 4(%ecx), %esi
    movl 8(%ecx), %ebx

    movl $0, %edx

vertical:
    cmpl %esi, %edx
    jge end

    movl (%ebx, %edx, 4), %eax
    movl $0, %ecx

horizontal:
    cmpl %edi, %ecx
    jge nextLine

    leal (%eax, %ecx, 4), %edx
    
    movb (%edx), %al
    movb $255, %ah
    subb %al, %ah
    movb %ah, (%edx)

    movb 1(%edx), %al
    movb $255, %ah
    subb %al, %ah
    movb %ah, 1(%edx)

    movb 2(%edx), %al
    movb $255, %ah
    subb %al, %ah
    movb %ah, 2(%edx)

    incl %ecx
    jmp horizontal

nextLine:
    incl %edx
    jmp vertical

end:
    popl %edi
    popl %esi
    popl %ebx
    leave 
    ret