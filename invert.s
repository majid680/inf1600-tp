.text
.globl invert
invert:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi
    
    movl 8(%ebp), %eax
    movl (%eax), %edi       # largeur
    movl 4(%eax), %esi      # hauteur
    movl 8(%eax), %ebx      # pointeur vers tableau de lignes
    
    movl $0, %edx           # y = 0
    
vertical:
    cmpl %esi, %edx
    jge end
    
    pushl %ebx              
    movl (%ebx,%edx,4), %eax  
    movl $0,%ecx        # x = 0
    
horizontal:
    cmpl %edi, %ecx
    jge nextLine
    
    pushl %eax              # Sauvegarder pointeur de ligne
    pushl %ecx              # Sauvegarder x
    pushl %edx              # Sauvegarder y
    
    # Calculer adresse du pixel
    leal (%eax,%ecx,4), %edx
    
    
    movzbl (%edx), %eax
    movl $255, %ebx
    subl %eax, %ebx
    movb %bl, (%edx)
    
    # Inverser G
    movzbl 1(%edx), %eax
    movl $255, %ebx
    subl %eax, %ebx
    movb %bl, 1(%edx)
    
    # Inverser R
    movzbl 2(%edx), %eax
    movl $255, %ebx
    subl %eax, %ebx
    movb %bl, 2(%edx)
    
    popl %edx               # Restaurer y
    popl %ecx               # Restaurer x
    popl %eax               # Restaurer pointeur de ligne
    
    incl %ecx               # x++
    jmp horizontal
    
nextLine:
    popl %ebx               # Restaurer pointeur de base
    incl %edx               # y++
    jmp vertical
    
end:
    popl %edi
    popl %esi
    popl %ebx
    leave
    ret