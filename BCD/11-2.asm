DSEG    SEGMENT 'DATA'
      ; add your data here!
      BUF DB 50H
      DB 0H
      DB 40H DUP('$')
      
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


MOV DX,SEG BUF    
MOV DS,DX
MOV DX,OFFSET BUF
MOV AH,0AH
INT 21H

MOV SI,OFFSET BUF
MOV DI,OFFSET BUF
       
MOV DH,0
MOV DL,BUF[1]
DEC DX        ;�Ƚϴ���=�ַ���-1
LABLE_A:                  
        MOV SI,OFFSET BUF 
        ADD SI,2          ;SI=��������ַ
        MOV DI,OFFSET BUF
        ADD DI,3          ;DI=��������ַ+1
        CLD        
        MOV CX,DX         ;DX=�Ƚϴ���           
        LABLE_B:CMPSB     ;BUF[SI]��BUF[SI+1]�ȴ�С,SI++,DI++
                JBE LABLE_C 
                MOV AL,BUF[SI-1]                              
                XCHG AL,BUF[DI-1]
                MOV BUF[SI-1],AL   ;�����򽻻�  
        LABLE_C:          
        LOOP LABLE_B               ;ѭ���Ƚ�  
        
        DEC DX
        CMP DX,0                   
        JNE LABLE_A                ;δ�Ƚ�����ѭ���Ƚ�
mov dl,0dh
mov ah,2
int 21h
mov dl,0ah
mov ah,2
int 21h
  
MOV AH, 09H      
mov DX, offset BUF
ADD DX, 2
INT 21H        

      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
