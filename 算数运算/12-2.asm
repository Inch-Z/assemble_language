DSEG    SEGMENT 'DATA'
      ; add your data here!
      BUF DW 85          ;����������
      OUTPUT DW 3 DUP(0)  ;��Ž��
      CONT DW 100,10,1    ;ʮ���Ƶ�Ȩֵ
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

MOV SI,0
MOV AX,BUF

LABLE1:
CMP AX,CONT[SI]
JAE LABLE2 ;��AL>=CONT[SI]���򲻹�������ת��LABLE2
ADD SI,2     ;����Ļ�SI+1
CMP SI,6
JAE LABLE3 ;��SI>=3�������������Ѵ����꣬��ת��LABLE3
JMP LABLE1;��ת��LABLE1���ظ�����
LABLE2:
SUB AX,CONT[SI] ;ԭ��������ȥȨֵ       
INC OUTPUT[SI]  ;Ȩֵ�ϵ�����1
JMP LABLE1      ;��ת��LABLE1�������ظ�����

LABLE3:

PUSH OUTPUT[0]   ;��λ
PUSH OUTPUT[2]   ;ʮλ
PUSH OUTPUT[4]   ;��λ
PUSH 3           ;����ַ��ĸ���

CALL PROC1      ;�����ӳ��򣬽����ת��ΪACSII�벢���

    mov ax, 4c00h 
    int 21h    
   START   ENDP
CSEG    ENDS

PROC1 PROC
     MOV SI,8          ;��ʼֵΪ��λ
     MOV BP,SP
     MOV CX,[BP+2]     ;CXλ����ַ��ĸ���
     LABLEA:
     MOV DL,[BP+SI]    ;�������
     ADD DL,30H        ;������ת��ΪACSII��
     MOV AH,2
     INT 21H           ;�������
     SUB SI,2          ;ָ����һλ������
     LOOP LABLEA       ;������δȡ����ѭ�����������     
     
     RET               ;����������
PROC1 ENDP


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    

END    START    ; set entry point.
