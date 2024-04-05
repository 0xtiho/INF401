                                                                                        
@  Importation des,constantes symboliques WIDTH, HEIGHT, BYTES, BYTES_PER_LINE          
#include "image_bits_include.h"                                                         
                                                                                        
                 .global symetrie_octet                                                 
                 .global permuter_cols                                                  
                 .global symetrie_axe_v                                                 
                 .global permuter_ligne                                                 
                 .global symetrie_axe_h                                                 
                 .global symetrie_axe_h                                                 
                 .global permuter_lignes                                                
                 .global symetrie_axe_v                                                 
                                                                                        
                 .text                                                                  
                                                                                        
@ r0 : parametre reçu adresse                                                           
@ r1 : variable locale octet                                                            
                                                                                        
#ifndef C_SYMETRIE_OCTET                                                                
#ifndef SYMTAB                                                                          
                                                                                        
@  Version avec opérations bit à bit                                                    
                                                                                        
symetrie_octet:
   ldrb r1, [r0]
   mov r3, r1
   and r1, r1, #0xF0
   mov r1, r1, lsr #4
   and r2, r3, #0x0F
   mov r2, r2, lsl #4
   orr r1, r1, r2   
   mov r3, r1
   and r1, r1, #0xCC
   mov r1, r1, lsr #2
   and r2, r3, #0x33
   mov r2, r2, lsl #2
   orr r1, r1, r2   
   mov r3, r1
   and r1, r1, #0xAA
   mov r1, r1, lsr #1
   and r2, r3, #0x55
   mov r2, r2, lsl #1
   orr r1, r1, r2   
   strb r1, [r0]   
   bx lr                                                                        
                                                                                        
#else  // SYMTAB                                                                        
                                                                                        
@ Version tabulée                                                                       
symetrie_octet:                                                                         
#endif  // SYMTAB                                                                       
#endif  // C_SYMETRIE_OCTET                                                             
@ r0 : parametre tab                                                                    
@ r1 : parametre col                                                                    
                                                                                        
#ifndef C_PERMUTER_COLS                                                                 
                                                                                        
permuter_cols: 
   ldr r2, adr_bytes_per_line
   sub r2, r2, #1
   sub r2, r2, r1
   add r5, r2, r0
   ldrb r3, [r5]
  
   add r4, r1, r0
   ldrb r6, [r4]


   strb r6, [r2]
   strb r3, [r4]


   bx lr
                                                                          
#endif // C_PERMUTER_COLS                                                               
                                                                                        
@ r0 : paramètre image                                                                  
                                                                                        
#ifndef C_SYMETRIE_AXE_V                                                                
symetrie_axe_v:
	push {lr}

	mov r8, r0

	ldr r5, adr_bytes
	ldr r6, adr_bytes_per_line
	ldr r7, adr_height

init_for1:
	mov r1, #0
debut_for1:
	cmp r1, r5
	bge fin_for1
	add r0, r8, r1
	bl symetrie_octet
	add r1, r1, #1
	b debut_for1
fin_for1:
init_for2 :
	mov r2, #0
	mov r3, #0
	mov r9, r6, lsr #1
debut_for2 :
	cmp r2, r7
	bge fin_for2
	mov r0, r2
	mov r0, r6
	bl mult
	mov r4, r0
	add r4, r4, r8
debut_for3 :
	cmp r3, r9
	bge fin_for3
	mov r0, r4
	mov r1, r3
	bl permuter_cols
	add r3, r3, #1
	b debut_for3
fin_for3 :
	add r2, r2, #1
	b debut_for2
fin_for2 :
pop {lr}

bx lr
                                                                         
                                                                                        
#endif // C_SYMETRIE_AXE_V                                                              
@ r0 : tab                                                                              
@ r1 : li                                                                               
                                                                                        
#ifndef C_PERMUTER_LIGNES                                                               
permuter_lignes:
	push {r0, r1, r2, r3, r4, r5, r6}
	ldr r2, adr_height
	mov r6, r0
	ldr r4, adr_bytes
	mov r0, r1
	mov r1, r4
	bl mult
	mov r3, r0
	add r3, r3, r6
	ldrb r5, [r3]
	sub r2, r2, #1
	sub r2, r2, r1
	add r2, r2, r6
	strb r5, [r2]
	strb r3, [r4]
    pop {r0, r1, r2, r3, r4, r5, r6}
	bx lr                                                                        
                                                                                        
#endif // C_PERMUTER_LIGNES                                                             
                                                                                        
@ r0 : paramètre image                                                                  
                                                                                        
#ifndef  C_SYMETRIE_AXE_H                                                               
symetrie_axe_h:   
	push {lr}
	ldr r6, adr_height
	mov r6, r6, lsr #1
	ldr r5, adr_bytes_per_line
	mov r2, #0
	mov r3, #0
debut_for4 :
	cmp r2, r6
	bge fin_for1
debut_for5 :
	cmp r3, r5
	bge fin_for2
	add r1, r4, r3
	bl permuter_lignes
	add r3, r3, #1
	b debut_for2
fin_for5 :
	add r2, r2, #1
	b debut_for1
fin_for4 :

pop {lr}
bx lr
                                                                       
                                                                                        
#endif   // C_SYMETRIE_AXE_H  

adr_tableau : .word tabsym_octet
adr_bytes: .word BYTES
adr_height : .word HEIGHT
adr_bytes_per_line : .word BYTES_PER_LINE

