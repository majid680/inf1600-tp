.data 

.text 
.globl isSameColor   

isSameColor:
    # prologue
    pushl  %ebp          
    movl   %esp, %ebp          

movl 8(%ebp), %eax # à verifier
movl 12(%ebp), %edx # à vérifier


compareBlue:
    movb (%eax), %al
    cmp (%edx), %al
    jne isDIfferetenColor
    

Equal:
    movl $1, %eax

isDifferentColor:
    movl $0, %eax
    jmp end



end:
    # epilogue
    leave 
    ret   
