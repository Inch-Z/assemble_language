DSEG    SEGMENT 'DATA'
      ; add your data here!
      BUF DW 85          ;二进制数字
      OUTPUT DW 3 DUP(0)  ;存放结果
      CONT DW 100,10,1    ;十进制的权值
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
JAE LABLE2 ;若AL>=CONT[SI]，则不够减，跳转至LABLE2
ADD SI,2     ;否则的话SI+1
CMP SI,6
JAE LABLE3 ;若SI>=3，则所有数都已处理完，跳转至LABLE3
JMP LABLE1;跳转回LABLE1，重复操作
LABLE2:
SUB AX,CONT[SI] ;原来的数减去权值       
INC OUTPUT[SI]  ;权值上的数加1
JMP LABLE1      ;跳转回LABLE1，进行重复操作

LABLE3:

PUSH OUTPUT[0]   ;百位
PUSH OUTPUT[2]   ;十位
PUSH OUTPUT[4]   ;个位
PUSH 3           ;输出字符的个数

CALL PROC1      ;调用子程序，将结果转换为ACSII码并输出

    mov ax, 4c00h 
    int 21h    
   START   ENDP
CSEG    ENDS

PROC1 PROC
     MOV SI,8          ;初始值为百位
     MOV BP,SP
     MOV CX,[BP+2]     ;CX位输出字符的个数
     LABLEA:
     MOV DL,[BP+SI]    ;存放数字
     ADD DL,30H        ;将数字转换为ACSII码
     MOV AH,2
     INT 21H           ;输出数字
     SUB SI,2          ;指向下一位的数字
     LOOP LABLEA       ;若数字未取完则循环，否则结束     
     
     RET               ;返回主程序
PROC1 ENDP


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    

END    START    ; set entry point.
