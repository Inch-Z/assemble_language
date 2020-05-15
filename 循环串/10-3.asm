DSEG    SEGMENT 'DATA'
      ; add your data here!
    STRING1 DB 'DJSKLAJF$',20H DUP($)
    CONT1 EQU $-STRING1            ;STRING1的字符数
    STRING2 DB '1256',20H DUP($)
    CONT2 EQU $-STRING2                ;STRING2的字符数
    POS EQU 2
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


      ; add your code here
MOV SI,POS
MOV CX,CONT1-POS

LOP1:
    MOV AL,STRING1[SI]
    MOV STRING1[SI+CONT2+CONT1-POS],AL
    INC SI
LOOP LOP1        ;将STRING中POS位置以后的字符往后复制
    
    MOV SI,POS
    MOV DI,0
    MOV CX,CONT2

LOP2:
    MOV AL,STRING2[DI]
    MOV STRING1[SI],AL
    INC SI
    INC DI
LOOP LOP2 ;将STRING2的字符黏贴在STRING1中POS开始的位置

MOV CX,CONT1-POS

LOP3:
MOV AL,STRING2[si]
MOV STRING1[di+1],AL
INC si
INC di
CMP si,CONT1+CONT2
loop LOP3

LEA dx,STRING1
mov ah,09h
int 21h
 
      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
