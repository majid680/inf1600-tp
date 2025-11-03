.text
.globl invert

# void invert(Image *img)
invert:
    pushl %ebp
    movl %esp, %ebp
    pushl %ebx
    pushl %esi
    pushl %edi

    movl 8(%ebp), %ebx       # %ebx = stocke le double pointeurs image (tableau de pixel)
    movl 4(%ebp), %esi       # stocke l'hauteur
    movl 0(%ebp), %edi       # stocke la largeur

    movl $0, %edx         # y = 0
vertical:
    cmpl %esi, %edx          # condition d'arret y >= hauteur
    jge end

    # récupérer ligne y
    movl (%ebx,%edx,4), %edi   #

    movl $0, %ecx      # x = 0
horizontal:
    cmpl %edi, %ecx          # condition d'arret x >= largeur
    jge nextRow

    # adresse pixel = ligne + x*4
    movl %ecx, %eax
    imull $4, %eax
    movl %edi, %ebx
    addl %eax, %ebx          # ebx = &pixels[y][x]

    # charger B, G, R
    movzbl 0(%ebx), %al   # bleu
    movzbl 1(%ebx), %dl   # vert
    movzbl 2(%ebx), %cl   # rouge
             
    movb $255, %ah 
    subb %al, %ah   # 255 - couleur
    movb %ah, 0(%ebx)  # stocke le resultat dans la premiere 8bits du ebx

    movb $255, %ah
    subb %dl, %ah
    movb %ah, 1(%ebx)

    movb $255, %ah
    subb %cl, %ah
    movb %ah, 2(%ebx)
    # alpha reste inchangé

    incl %ecx   # passer à la prochaine colonne
    jmp horizontal

nextRow:
    incl %edx    # passer à la ligne suivante
    jmp vertical

end:
    popl %edi
    popl %esi
    popl %ebx
    leave
    ret
