.data 

.text 
.globl invert                

invert:
    # prologue
    pushl  %ebp                  
    movl   %esp, %ebp            

    # epilogue
    leave 
    ret   
