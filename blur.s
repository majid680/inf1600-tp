.text
.globl blur

blur:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp           # espace pour variables locales
    pushl %ebx
    pushl %esi
    pushl %edi
    
    movl 8(%ebp), %ebx           # img (où on écrit le résultat)
    movl 12(%ebp), %esi          # imgCopy (copie pour lire les voisins)
    movl (%ebx), %eax            # largeur
    movl %eax, -12(%ebp)
    movl 4(%ebx), %eax           # hauteur
    movl %eax, -8(%ebp)
    
    # récupérer le tableau de pixels
    movl 8(%ebx), %ebx           # img->pixels
    movl 8(%esi), %eax           # imgCopy->pixels
    movl %eax, -4(%ebp)

    # commencer à la ligne 1 (ignorer la bordure)
    movl $1, %edi
y_loop:
    movl -8(%ebp), %eax
    decl %eax                    # hauteur - 1
    cmpl %eax, %edi
    jge end
    
    movl $1, %esi                 # commencer à la colonne 1
x_loop:
    movl -12(%ebp), %eax
    decl %eax                     # largeur - 1
    cmpl %eax, %esi
    jge next_y

    # remettre à zéro les compteurs et sommes
    movl $0, -28(%ebp)           # nombre de pixels qu'on va utiliser
    movl $0, -24(%ebp)           # somme des rouges
    movl $0, -20(%ebp)           # somme des verts
    movl $0, -16(%ebp)           # somme des bleus

    # boucle sur les voisins y (-1 à 1)
    movl $-1, %ecx
neighbor_y:
    cmpl $1, %ecx
    jg neighbor_y_end
    
    # boucle sur les voisins x (-1 à 1)
    movl $-1, %edx
neighbor_x:
    cmpl $1, %edx
    jg neighbor_x_end
    
    # calculer la position du voisin
    movl %esi, %eax
    addl %edx, %eax              # x + dx
    movl %edi, %ebx
    addl %ecx, %ebx              # y + dy

    # vérifier que le voisin est dans l'image
    pushl %edx
    pushl %ecx
    cmpl $0, %eax
    jl next_neighbor_pop
    movl -12(%ebp), %ecx
    cmpl %ecx, %eax
    jge next_neighbor_pop
    cmpl $0, %ebx
    jl next_neighbor_pop
    movl -8(%ebp), %ecx
    cmpl %ecx, %ebx
    jge next_neighbor_pop

    # récupérer le pixel dans imgCopy
    movl -4(%ebp), %ecx
    movl (%ecx,%ebx,4), %ecx     # ligne y
    leal (%ecx,%eax,4), %ecx     # pixel x

    # ajouter les couleurs à la somme
    movzbl 2(%ecx), %eax         # rouge
    addl %eax, -24(%ebp)
    movzbl 1(%ecx), %eax         # vert
    addl %eax, -20(%ebp)
    movzbl (%ecx), %eax          # bleu
    addl %eax, -16(%ebp)
    
    incl -28(%ebp)               

next_neighbor_pop:
    popl %ecx
    popl %edx
    incl %edx
    jmp neighbor_x

neighbor_x_end:
    incl %ecx
    jmp neighbor_y

neighbor_y_end:
    # vérifier qu'on a au moins un voisin
    movl -28(%ebp), %eax
    cmpl $0, %eax
    je next_pixel
    
    # moyenne  pour rouge
    movl -24(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %cl
    
    # moyenne vert
    movl -20(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %ch
    
    # moyenne bleu
    movl -16(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %dl
    
    # mettre les moyennes dans img
    movl 8(%ebp), %ebx
    movl 8(%ebx), %ebx
    movl (%ebx,%edi,4), %ebx
    leal (%ebx,%esi,4), %ebx
    movb %cl, 2(%ebx)
    movb %ch, 1(%ebx)
    movb %dl, (%ebx)

next_pixel:
    incl %esi
    jmp x_loop

next_y:
    incl %edi
    jmp y_loop

end:
    popl %edi
    popl %esi
    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret
