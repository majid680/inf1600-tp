.data 
dx:
    .word  -1                        
dy:
    .word  -1                        

.text 
.globl blur                      

blur:
    # prologue
    pushl  %ebp                      
    movl   %esp, %ebp                

    # epilogue
    leave 
    ret   
