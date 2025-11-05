.text
.globl grayscale

grayscale:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi

    movl 8(%ebp), %eax
    movl (%eax), %edi
    movl 4(%eax), %esi
    movl 8(%eax), %ebx

    movl $0, %edx

vertical:
    cmpl %esi, %edx
    jge end

    movl (%ebx,%edx,4), %eax
    xorl %ecx, %ecx

horizontal:
    cmpl %edi, %ecx
    jge nextLine

    pushl %eax
    pushl %ebx
    pushl %ecx
    pushl %edx

    leal (%eax,%ecx,4), %edx

    movzbl (%edx), %eax
    movzbl 1(%edx), %ebx
    movzbl 2(%edx), %ecx

    addl %ebx, %eax
    addl %ecx, %eax
    movl $3, %ebx
    movl $0, 
    divl %ebx

    popl %edx
    popl %ecx
    popl %ebx
    popl %eax

    pushl %eax
    pushl %edx
    leal (%eax,%ecx,4), %edx

    movb %al, (%edx)
    movb %al, 1(%edx)
    movb %al, 2(%edx)

    popl %edx
    popl %eax

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