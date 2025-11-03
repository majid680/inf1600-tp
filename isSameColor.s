.data

.text
.globl isSameColor

isSameColor:
    # prologue
    pushl %ebp
    movl %esp, %ebp
    movl 8(%ebp), %eax     # pointeur couleur1
    movl 12(%ebp), %edx    # pointeur couleur2

    # comparer le bleu de chacun
    movb (%eax), %al
    cmpb (%edx), %al
    jne isDifferentColor

    # comparer le vert de chacun
    movb 1(%eax), %al
    cmpb 1(%edx), %al
    jne isDifferentColor

    # comparer le rouge de chacun
    movb 2(%eax), %al
    cmpb 2(%edx), %al
    jne isDifferentColor

    
    movl $1, %eax
    jmp end

isDifferentColor:
    movl $0, %eax
    jmp end

end:
    leave
    ret
