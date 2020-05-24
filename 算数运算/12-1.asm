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
    INT 21H                ;输入数字和进制
    
    MOV SI,OFFSET STRING1
    CALL PROC1 
    MOV NUM,BX             ;数字转换为二进制    
    MOV SI,OFFSET STRING2
    CALL PROC1
    MOV P,BX               ;进制转化为二进制
    
    CALL PROC2             ;求最大权值
    CALL PROC3             ;求相应进制的数
     
    MOV DL,0AH         
    MOV AH,2
    INT 21H
    MOV DL,0DH
    MOV AH,2
    INT 21H                ;回车换行
    MOV DX,OFFSET INVERT
    MOV AH,9
    INT 21H                ;输出
START   ENDP
CSEG    ENDS ; set entry point.
PROC1 PROC        ;SI为STRING首地址，返回二进制数值到BX
    MOV BX,0      ;暂存清零    
    INC SI 
    MOV DI,SI     ;记录第一个数字之前的位置
    
    MOV AX,0      ;清空AX
    MOV AL,[SI]   
    ADD SI,AX     ;令SI=1+STRING[1]
    MOV CX,1      ;记录每个数字的权值
    
    LABLE11:  
    MOV AL,[SI]   
    AND AX,0FH  
    MUL CX        ;AL=[SI]*CX（即数字×权值）
    ADD BX,AX     ;加入暂存中
    DEC SI        ;取下一权值的数字
    MOV AX,CX
    MOV CX,10
    MUL CX
    MOV CX,AX     ;CX的权值每次都*10
    CMP SI,DI     ;是否所有数字都遍历完？
    JNE LABLE11   ;不是的话循环
        
    RET
PROC1 ENDP  

PROC2 PROC
     MOV AX,1       ;AX为最大权值
     MOV BX,P
     
     LABLE21:
     MUL BX         
     CMP NUM,AX     ;若此时仍然不是最大的权值则继续循环
     JAE LABLE21
     DIV BX         ;若此时是最大权值，则保存最大权值的结果
     MOV PM,AX
     
     RET
PROC2 ENDP 

PROC3 PROC
    MOV BX,NUM           ;BX为数字
    MOV AX,PM            ;AX为最大权值
    MOV CX,P             ;CX为进制
    MOV SI,OFFSET INVERT ;SI为INVERT首地址
    MOV [SI],0  
    
    LABLE31:
    CMP BX,AX            ;数字是否大于权值？
    JB LABLE32           ;若不是则跳转
    SUB BX,AX            ;若是则减去权值
    INC [SI]             ;相应权值加1
    JMP LABLE31          ;继续循环
    
    LABLE32:
    ADD [SI],30H         ;转换为ACSII码
    INC SI               ;计算下一位的权值  
    MOV [SI],0
    DIV CX               ;权值相应改变
    CMP AX,0             ;是否所有的位数都已经计算完？
    JNE LABLE31
    
    RET 
PROC3 ENDP
end start ; set entry point and stop the assembler.



