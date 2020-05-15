DSEG    SEGMENT 'DATA'
      ; add your data here!
    BCD1 DB 1H,1H,20H DUP(0) 
    CONT1 EQU $-BCD1-20H
    BCD2 DB 99H,98H,20H DUP(0)
    CONT2 EQU $-BCD2-20H  
    BCD3 DB 20H DUP(0)
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
    MOV CX,CONT1
    CMP CX,CONT2
    JAE CONT
    MOV CX,CONT2   
    CONT:
    INC CX         ;CX为要相加的字符数(取两者的最大值+1）
    MOV SI,0       ;SI为BCD1、BCD2、BCD3的起始地址
    CLC            ;标志寄存器清零
    
    LOP:
    MOV AL,BCD1[SI]
    ADC AL,BCD2[SI] ;AL=BCD1[SI]+BCD2[SI]
    DAA             ;BCD码矫正
    MOV BCD3[SI],AL ;结果放在BCD3[SI]中
    INC SI          ;SI指向下一个字符
    LOOP LOP   


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
