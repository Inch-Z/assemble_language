DSEG    SEGMENT 'DATA'
      ; add your data here!
    STRING1 DB 5
            DB 0
            DB 5 DUP(0)
    STRING2 DB 3
            DB 0
            DB 3 DUP(0)
    NUM DW 0
    P DW 0
    PM DW 0
    INVERT DB 20H DUP('$')
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

                                          
    MOV DX, OFFSET STRING1
    MOV AH, 0AH
    INT 21H
    MOV DX, OFFSET STRING2
    MOV AH, 0AH
    INT 21H                ;�������ֺͽ���
    
    MOV SI,OFFSET STRING1
    CALL PROC1 
    MOV NUM,BX             ;����ת��Ϊ������    
    MOV SI,OFFSET STRING2
    CALL PROC1
    MOV P,BX               ;����ת��Ϊ������
    
    CALL PROC2             ;�����Ȩֵ
    CALL PROC3             ;����Ӧ���Ƶ���
     
    MOV DL,0AH         
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H                ;�س�����
    MOV DX,OFFSET INVERT
    MOV AH,9
    INT 21H                ;���
START   ENDP
CSEG    ENDS ; set entry point.
PROC1 PROC        ;SIΪSTRING�׵�ַ�����ض�������ֵ��BX
    MOV BX,0      ;�ݴ�����    
    INC SI 
    MOV DI,SI     ;��¼��һ������֮ǰ��λ��
    
    MOV AX,0      ;���AX
    MOV AL,[SI]   
    ADD SI,AX     ;��SI=1+STRING[1]
    MOV CX,1      ;��¼ÿ�����ֵ�Ȩֵ
    
    LABLE11:  
    MOV AL,[SI]   
    AND AX,0FH  
    MUL CX        ;AL=[SI]*CX�������֡�Ȩֵ��
    ADD BX,AX     ;�����ݴ���
    DEC SI        ;ȡ��һȨֵ������
    MOV AX,CX
    MOV CX,10
    MUL CX
    MOV CX,AX     ;CX��Ȩֵÿ�ζ�*10
    CMP SI,DI     ;�Ƿ��������ֶ������ꣿ
    JNE LABLE11   ;���ǵĻ�ѭ��
        
    RET
PROC1 ENDP  

PROC2 PROC
     MOV AX,1       ;AXΪ���Ȩֵ
     MOV BX,P
     
     LABLE21:
     MUL BX         
     CMP NUM,AX     ;����ʱ��Ȼ��������Ȩֵ�����ѭ��
     JAE LABLE21
     DIV BX         ;����ʱ�����Ȩֵ���򱣴����Ȩֵ�Ľ��
     MOV PM,AX
     
     RET
PROC2 ENDP 

PROC3 PROC
    MOV BX,NUM           ;BXΪ����
    MOV AX,PM            ;AXΪ���Ȩֵ
    MOV CX,P             ;CXΪ����
    MOV SI,OFFSET INVERT ;SIΪINVERT�׵�ַ
    MOV [SI],0  
    
    LABLE31:
    CMP BX,AX            ;�����Ƿ����Ȩֵ��
    JB LABLE32           ;����������ת
    SUB BX,AX            ;�������ȥȨֵ
    INC [SI]             ;��ӦȨֵ��1
    JMP LABLE31          ;����ѭ��
    
    LABLE32:
    ADD [SI],30H         ;ת��ΪACSII��
    INC SI               ;������һλ��Ȩֵ  
    MOV [SI],0
    DIV CX               ;Ȩֵ��Ӧ�ı�
    CMP AX,0             ;�Ƿ����е�λ�����Ѿ������ꣿ
    JNE LABLE31
    
    RET 
PROC3 ENDP
end start ; set entry point and stop the assembler.



