DSEG    SEGMENT 'DATA'
      ; add your data here!
      RESULT db 0
      A db 98h
      OPERAND db 43h,21h,09h
      COUNT db 03h
DSEG    ENDS



SSEG    SEGMENT STACK   'STACK'
      db   256  DUP(0)
SSEG    ENDS

CSEG    SEGMENT 'CODE'
   START   PROC    FAR
      ; set segment registers:
      MOV AX, DSEG
      MOV DS, AX
      MOV ES, AX

BIN_SUB MACRO RESULT,A,OPERAND,COUNT
    LOCAL LOP
    PUSH DX
    PUSH CX
    PUSH BX
    PUSH AX
    MOV CL,COUNT
    MOV CH,0
    MOV AL,A
    MOV BX,OFFSET OPERAND
    CLC
    
    LOP:
    SBB AL,[BX]
    INC BX
    LOOP LOP
    
    MOV RESULT,AL
    POP AX
    POP BX
    POP CX
    POP DX
ENDM

BIN_SUB RESULT,A,OPERAND,COUNT
      ; add your code here


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
