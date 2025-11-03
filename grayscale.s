.text
.globl grayscale

# void grayscale(Image *img)
grayscale:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi

    movl 8(%ebp), %ebx       # %ebx =  stocke le double pointeurs image (tableau de pixel)
    movl 4(%ebp), %esi       # stocke l'hauteur 
    movl 0(%ebp), %edi       # stocke la largeur

    movl $0, %edx         # y = 0
vertical:
    cmpl %esi, %edx          #  condtion d'arret y >= hauteur 
    jge fin

    # récupérer ligne y qu'on est en ce moment (ca modifie apres chaque changement de ligne)
    movl (%ebx,%edx,4), %edi   #

    movl $0, %ecx      # x = 0
horizontal:
    cmpl %edi, %ecx          # condition d'arret ( pour changer une ligne)x >= largeur 
    jge nextRow

    # adresse pixel = ligne + ecx*4
    movl %ecx, %eax
    imull $4, %eax
    movl %edi, %ebx
    addl %eax, %ebx          # ebx = &pixels[y][x]

    # charger B, G, R
    movzbl 0(%ebx), %al   # bleu
    movzbl 1(%ebx), %dl   # vert
    movzbl 2(%ebx), %cl   # rouge

    # moyenne = (B+G+R)/3
    addl %dl, %eax
    addl %cl, %eax
    movl $3, %edx
    divl %edx               # %eax = moyenne

    # stocker gris pour  les trois B,G,R
    movb %al, 0(%ebx)
    movb %al, 1(%ebx)
    movb %al, 2(%ebx)
    # alpha reste inchangé

    incl %ecx   # on passe a la prochaine case a coté
    jmp horizontal

nextRow:
    incl %edx    # incerement le numero de la ligne
    jmp vertical  

fin:
    popl %edi
    popl %esi
    popl %ebx
    leave
    ret
