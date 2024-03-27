@ Programme tabmult : Affiche les tables de multiplication de de 1 a 10
N_MAX= 10
L_MAX = 11
   .data
barre :  .byte '|'
         .byte 0
espace : .byte ' '
         .byte 0
tirets : .asciz "---"

debutTab:    .skip N_MAX*N_MAX*4   @ adresse du debut du tableau

a:      .word 0
b:      .word 0


   .text
   .global main
main: push {lr}
    @ i need to start with the first digit 
    ldr r0,ptr_debutTab
    @ here we start the loop to fill all other numbers
    mov r6, #0 @ Compteur unique pour parcourir le tableau à une dimension
TheLoop:
    cmp r6, #N_MAX*N_MAX @ Vérifier si le compteur a atteint la taille totale du tableau
    bge EndLoop

    @ Calculer les indices de ligne (a) et de colonne (b)
    mov r2, r6             @ L'indice de ligne (a) est le compteur lui-même
    mov r3, #N_MAX
    sdiv r2, r2, r3        @ Calculer a = r6 / N_MAX
    mov r4, r6             @ L'indice de colonne (b) est le compteur lui-même
    mov r5, #N_MAX
    umull r4, r5, r2, r5   @ r4 = b * N_MAX, r5 = reste de la division

    @ Calculer la valeur de la cellule dans le tableau
    add r1, r2, #1         @ r1 = a + 1 (indice de ligne + 1)
    add r1, r1, r5         @ r1 = (a + 1) + reste

    @ Stocker la valeur dans la cellule correspondante du tableau
    lsl r5, r2, #2         @ Calculer le décalage (r2 * 4)
    add r5, r5, r4, lsl #2 @ Ajouter l'indice de colonne * 4 au décalage
    add r5, r0, r5         @ Ajouter le décalage à l'adresse de base
    str r1, [r5]           @ Stocker la valeur dans le tableau

    @ Incrémenter le compteur
    add r6, r6, #1

    b TheLoop
EndLoop:
    ldr r2, ptr_debutTab

    mov r0, #0  @indice i
    tq1 :
        CMP r0, #N_MAX
        BEQ fintq1 @R0 R1 R5
        mov R3,#0
BTiret: CMP R3,#14
        BEQ FinBTiret
        LDR r1, adr_tirets
        BL EcrChn
        add r3,r3,#1
        b BTiret
FinBTiret:
        BL AlaLigne
        mov r5, #0  @indice j
        tq2 : 
            
            CMP r5, #N_MAX
            BEQ fintq2
            
            
            LDR r1, adr_barre
            BL EcrChn
            ldr r1,[r2]
            CMP r1,#10
            BLT OChiffre @IF
            BGE TChiffre @ IF dans l'ancien IF
OChiffre: 
            BL EcrNdecim32 
            LDR r1, adr_espace
            BL EcrChn
            LDR r1, adr_espace
            BL EcrChn
            
b FinTrChiffre
FinOChiffre:

TChiffre:   CMP R1,#100
            BEQ TrChiffre
            BL EcrNdecim32 
            LDR r1, adr_espace
            BL EcrChn
            B FinTrChiffre
FinTChiffre:
TrChiffre:
            BL EcrNdecim32 
FinTrChiffre:


            ADD r5, r5, #1 @incrementation de l'indice j
            add r2,r2,#4
            B tq2
        fintq2:
        LDR r1, adr_barre
        BL EcrChn
        BL AlaLigne
        ADD r0, r0, #1 @incrementation de l'indice i

        B tq1

    fintq1:
fin: pop {lr}
     bx lr

ptr_debutTab : .word debutTab
adr_barre :    .word barre
adr_espace :   .word espace
adr_tirets :   .word tirets
