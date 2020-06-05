DSEG    SEGMENT 'DATA'
      ; add your data here!
X DB 56
Y DB 34
SUM DB 0
DSEG    ENDS

SSEG    SEGMENT STACK   'STACK'
      db   256  DUP(0)
SSEG    ENDS

CSEG    SEGMENT 'CODE'
FINSUM MACRO [X],[Y],SUM
    LOCAL LABEL1,END
    MOV AL,[X]
    CMP AL,[Y]
    JL LABEL1
    ADD AL,[Y]
    ADD AL,[Y]
    JMP END
LABEL1:
       SHL AL,1
       ADD AL,[Y]




END:MOV SUM,AL
ENDM
   START   PROC    FAR
      ; set segment registers:
      MOV AX, DSEG
      MOV DS, AX
      MOV ES, AX


      ; add your code here
      FINSUM X,Y,SUM


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
