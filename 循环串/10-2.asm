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
MOV DI,AX              ;DI=*左边的空格长度
MOV AX,LENGTH          ;AX=三角形底边长
MOV SI,1               ;SI=*长度

LABLE_A:MOV CX,DI      ;第i行空格数
        CMP CX,0
        JBE LABLE_1
        LOOP_1:MOV DL,' '
               MOV AH,2
               INT 21H     ;打印空格
        LOOP LOOP_1        ;循环打印空格
        LABLE_1:MOV CX,SI  ;第i行*数     
        LOOP_2:MOV DL,'*'
               MOV AH,2
               INT 21H     ;打印*
        LOOP LOOP_2        ;循环打印*
        ADC SI,2           ;*个数+2
        DEC DI             ;空格个数-1
        MOV DL,0AH         
        MOV AH,2
        INT 21H
        MOV DL,0DH
        MOV AH,2
        INT 21H            ;回车换行
        CMP SI,LENGTH      
JBE LABLE_A                ;打印下一行



      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
