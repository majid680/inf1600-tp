.data
.text
.globl isSameColor
isSameColor:
    pushl %ebp
    movl %esp, %ebp
    
    movl 8(%ebp), %eax
    movl 12(%ebp), %edx
    
    andl $0x00FFFFFF, %eax     # Garde seulement les 3 premiers bytes 
    andl $0x00FFFFFF, %edx
    
    cmpl %edx, %eax
    jne notSameColor
    
    movl $1, %eax
    jmp end
    
notSameColor:
    movl $0, %eax
    
end:
    leave
    ret