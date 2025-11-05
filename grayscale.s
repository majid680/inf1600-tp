.text                                                                   
.globl grayscale
grayscale:
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
    
    pushl %ebx              # Sauvegarder pointeur de base
    movl (%ebx,%edx,4), %eax  # Charger pointeur de ligne
    movl $0,%ecx         # x = 0
    
horizontal:
    cmpl %edi, %ecx
    jge nextLine
    
    pushl %eax              # il faut sauvegarder les registres car ils seront utiliser temporairement
    pushl %ecx              
    pushl %edx              
    
  
    leal (%eax,%ecx,4), %edx   # cherche l'addresse
    
    # Charger B, G, R
    movzbl (%edx), %eax     # B
    movzbl 1(%edx), %ebx    # G
    movzbl 2(%edx), %ecx    # R
    
    # Calcule
    addl %ebx, %eax         
    addl %ecx, %eax         
    
    # Diviser par 3
    pushl %edx              # Sauvegarder adresse du pixel
    movl $3, %ebx
    movl $0,%edx       
    divl %ebx               
    
    
    movl %eax, %ebx         
    popl %edx               # Reavoir l'adresse du pixel
    
    # Écrire la valeur grise pour chacune des couleurs
    movb %bl, (%edx)        
    movb %bl, 1(%edx)       
    movb %bl, 2(%edx)       
    
    popl %edx               # Reavoir y
    popl %ecx               # Reavoir x
    popl %eax               # Reavoir le pointeur de ligne
    
    incl %ecx               
    jmp horizontal
    
nextLine:
    popl %ebx               # Reavoir pointeur de base
    incl %edx               
    jmp vertical
    
end:
    popl %edi
    popl %esi
    popl %ebx
    leave
    ret