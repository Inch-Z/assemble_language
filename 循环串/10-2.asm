DSEG    SEGMENT 'DATA'
      ; add your data here!
      LENGTH DW 15
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
MOV AX,LENGTH          
MOV CX,2
DIV CX                 
MOV DI,AX              ;DI=*��ߵĿո񳤶�
MOV AX,LENGTH          ;AX=�����εױ߳�
MOV SI,1               ;SI=*����

LABLE_A:MOV CX,DI      ;��i�пո���
        CMP CX,0
        JBE LABLE_1
        LOOP_1:MOV DL,' '
               MOV AH,2
               INT 21H     ;��ӡ�ո�
        LOOP LOOP_1        ;ѭ����ӡ�ո�
        LABLE_1:MOV CX,SI  ;��i��*��     
        LOOP_2:MOV DL,'*'
               MOV AH,2
               INT 21H     ;��ӡ*
        LOOP LOOP_2        ;ѭ����ӡ*
        ADC SI,2           ;*����+2
        DEC DI             ;�ո����-1
        MOV DL,0AH         
        MOV AH,2
        INT 21H
        MOV DL,0DH
        MOV AH,2
        INT 21H            ;�س�����
        CMP SI,LENGTH      
JBE LABLE_A                ;��ӡ��һ��



      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
