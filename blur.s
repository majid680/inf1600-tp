.data 
dx:
    .word  -1                        
dy:
    .word  -1                        

.text 
.globl blur                      

blur:
    pushl %ebp
    movl %esp, %ebp
    subl $32, %esp           # on réserve un peu de place pour nos variables
    pushl %ebx
    pushl %esi
    pushl %edi
    
    movl 8(%ebp), %ebx           #  on va écrire le résultat sur ebx
    movl 12(%ebp), %esi          # imgCopy -> copie pour lire les voisins sans toucher img
    movl (%ebx), %eax            # récupérer largeur
    movl %eax, -12(%ebp)
    movl 4(%ebx), %eax           # récupérer hauteur
    movl %eax, -8(%ebp)
    
    # récupérer les tableaux de pixels
    movl 8(%ebx), %ebx           # img->pixels
    movl 8(%esi), %eax           # imgCopy->pixels
    movl %eax, -4(%ebp)

    movl $1, %edi                # on commence à la ligne 1 (bordure exclue)
loopY:
    movl -8(%ebp), %eax
    decl %eax                    # hauteur - 1
    cmpl %eax, %edi
    jge end                       # si on a fini les lignes, on sort

    movl $1, %esi                 # on commence à la colonne 1
loopX:
    movl -12(%ebp), %eax
    decl %eax                     # largeur - 1
    cmpl %eax, %esi
    jge next_y                    # si fini colonnes, on passe à la ligne suivante

    # remettre à zéro les compteurs et sommes
    movl $0, -28(%ebp)           # nombre de pixels qu'on va utiliser
    movl $0, -24(%ebp)           # somme des rouges
    movl $0, -20(%ebp)           # somme des verts
    movl $0, -16(%ebp)           # somme des bleus

    movl $-1, %ecx               # dy = -1
neighborY:
    cmpl $1, %ecx
    jg neighborYEnd
    
    movl $-1, %edx               # dx = -1
neighborX:
    cmpl $1, %edx
    jg neighborXEnd
    
    # calculer coordonnée du voisin
    movl %esi, %eax
    addl %edx, %eax              # x + dx
    movl %edi, %ebx
    addl %ecx, %ebx              # y + dy

    # vérifier que le voisin est bien dans l'image
    pushl %edx
    pushl %ecx
    cmpl $0, %eax
    jl nextNeighborPop
    movl -12(%ebp), %ecx
    cmpl %ecx, %eax
    jge nextNeighborPop
    cmpl $0, %ebx
    jl nextNeighborPop
    movl -8(%ebp), %ecx
    cmpl %ecx, %ebx
    jge next

    # récupérer le pixel dans imgCopy
    movl -4(%ebp), %ecx
    movl (%ecx,%ebx,4), %ecx     # ligne y
    leal (%ecx,%eax,4), %ecx     # pixel x

    # ajouter ses couleurs aux sommes
    movzbl 2(%ecx), %eax         # rouge
    addl %eax, -24(%ebp)
    movzbl 1(%ecx), %eax         # vert
    addl %eax, -20(%ebp)
    movzbl (%ecx), %eax          # bleu
    addl %eax, -16(%ebp)
    
    incl -28(%ebp)               # on compte ce pixel

nextNeighborPop:
    popl %ecx
    popl %edx
    incl %edx
    jmp neighborX

neighborXEnd:
    incl %ecx
    jmp neighborY

neighborYEnd:
    # si on a des voisins
    movl -28(%ebp), %eax
    cmpl $0, %eax
    je nextPixel
    
    # moyenne pour chaque couleur
    movl -24(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %cl                # rouge moyen
    
    movl -20(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %ch                # vert moyen
    
    movl -16(%ebp), %eax
    movl $0 ,%edx
    divl -28(%ebp)
    movb %al, %dl                # bleu moyen

    # mettre le pixel moyen dans img
    movl 8(%ebp), %ebx
    movl 8(%ebx), %ebx
    movl (%ebx,%edi,4), %ebx
    leal (%ebx,%esi,4), %ebx
    movb %cl, 2(%ebx)
    movb %ch, 1(%ebx)
    movb %dl, (%ebx)

nextPixel:
    incl %esi
    jmp loopX

next_y:
    incl %edi
    jmp loopY

end:
    popl %edi
    popl %esi
    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret
