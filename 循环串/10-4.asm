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
ADD SI,E+1          ;SIΪɾ����ĵ�һ���ַ����±�
MOV DI,OFFSET STRING
ADD DI,S            ;DIΪɾ����ʼ���±�
CLD

MOV CX,CONT2  ;CXΪҪŲ�����ַ���
LOP1:
MOVSB
LOOP LOP1  

MOV AL,0
MOV CX,CONT3  ;CXΪҪ���������ΪNULL���ַ���
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
