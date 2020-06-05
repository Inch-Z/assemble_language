DSEG    SEGMENT 'DATA'
      ; add your data here!
DIVD DB 10011111B
SCALE DB 20
SIGN DB 0
RESULT DB 0
DSEG    ENDS

SSEG    SEGMENT STACK   'STACK'
      db   256  DUP(0)
SSEG    ENDS

CSEG    SEGMENT 'CODE'
CAMULATE MACRO D,S,SIG,RESU
    LOCAL LABEL1,END
    
    MOV BL,[S]
    MOV AL,[D]
    
    CMP SIG,1
    JE LABEL1
    XOR AH,AH
    DIV BL
    JMP END
    

LABEL1:
       cbw
       IDIV BL

END:MOV RESU,AL
ENDM
   START   PROC    FAR
      ; set segment registers:
      MOV AX, DSEG
      MOV DS, AX
      MOV ES, AX


      ; add your code here
    CAMULATE DIVD,SCALE,SIGN,RESULT


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
