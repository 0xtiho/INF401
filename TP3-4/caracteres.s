    .data
cc: @ ne pas modifier cette partie
    .byte 0x42
    .byte 0x4f
    .byte 0x4e
    .byte 0x4a
    .byte 0x4f
    .byte 0x55
    .byte 0x52
    .byte 0x00     @ code de fin de chaine
    @ la suite pourra etr emofifiee
    .word 12
    .word 0x11223344
    au_revoir_str: .asciz "au revoir..."

    .text
    .global main
main:

@ impression de la chaine de caractere d'adresse cc
     ldr r1, ptr_cc
     bl EcrChaine

@ impression de la chaine "au revoir..."
    ldr r1, ptr_2cc
    bl EcrChaine
@ A COMPLETER

@ modification de la chaine d'adresse cc
    ldr r2, ptr_cc
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1 
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
    add r2, r2, #1
    ldrb r1, [r2]
    add r1, r1, #32
    strb r1, [r2]
@ A COMPLETER

@ impression de la chaine cc modifiee
     ldr r1, ptr_cc
     bl EcrChaine

fin: B exit  @ terminaison immédiate du processus (plus tard on saura faire mieux)

ptr_cc: .word cc
ptr_2cc: .word au_revoir_str
