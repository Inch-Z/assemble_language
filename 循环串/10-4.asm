DSEG    SEGMENT 'DATA'
      ; add your data here!
    STRING DB 'THIS IS MY PROGRAM','$'
    CONT1 EQU $-STRING
    S EQU 0
    E EQU 3
    CONT2 EQU CONT1-E-1
    CONT3 EQU E-S+1
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
MOV SI,OFFSET STRING
ADD SI,E+1          ;SI为删除后的第一个字符的下标
MOV DI,OFFSET STRING
ADD DI,S            ;DI为删除开始的下标
CLD

MOV CX,CONT2  ;CX为要挪动的字符数
LOP1:
MOVSB
LOOP LOP1  

MOV AL,0
MOV CX,CONT3  ;CX为要在最后设置为NULL的字符数
LOP2:
STOSB
LOOP LOP2
LEA DX, STRING
MOV AH,09H
INT 21H

      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
