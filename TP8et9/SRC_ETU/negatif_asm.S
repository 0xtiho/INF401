                                                                                      
@  Importation des,constantes symboliques WIDTH, HEIGHT, BYTES, BYTES_PER_LINE        
#include "image_bits_include.h"                                                       
										      
                                                                                      
                 .text                                                                
                                                                                      
@ r0 : parametre octet                                                                
                                                                                      
#ifndef C_NEG_OCTET                                                                   
                 .global neg_octet                                                    
                                                                                      
neg_octet:
    mvn r0,r0
    bx lr                                                                           
                                                                                      
#endif // C_NEG_OCTET                                                                 
                                                                                      
#ifndef C_NEG_IMAGE                                                               
                 .global neg_image                                                    
@ r0 : parametre reçu image                                                           
                                                                                      
                                                                                      
neg_image:                                                                            
                                                                                      
        push {lr}
        mov r2,r0
        ldr r3,adr_bytes
        add r3,r2,r3                                                           
pour:
    cmp r2,r3
    bge fin_pour
    ldrb r0, [r2]
    bl neg_octet
    strb r0,[r2]
    add r2,r2,#1
    b pour
fin_pour:
    pop {lr}
    mov pc,lr
adr_bytes:	.word BYTES                                                           
#endif // C_NEG_IMAGE                                                                 
