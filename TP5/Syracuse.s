 .data
entier:  .word 15
   .text
   .global main
main:
   ldr r0, adr_entier

tq: cmp r0, #1  @arreter la boucle si la valeur de r0 egale a 1
   beq fintq

   tst r0, #1   @tester si la valeur de r0 est pair
   bne impair
   lsr r0, r0, #1   @decaler a droite d'une valeur
   b tq     @repeter la boucle

impair:
   mov r1, r0  
   lsl r0, r0, #1   @decaler a gauche de une position
   add r0, r1, r0   @ajouter la valeur de r0 et r1 dans r0
   add r0, r0, #1   @ajouter 1 a r0
   b tq

fintq:
fin:
    mov r1,r0
    bx lr

adr_entier: .word entier
