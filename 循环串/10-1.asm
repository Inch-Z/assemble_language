DSEG    SEGMENT 'DATA'
      ; add your data here!
      BUF DW ?
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
MOV AX,0         ;AX=N*(N+1)
MOV BX,0         ;BX=N
MOV CX,1         ;CX=N+1
MOV DX,0         ;DX=1¡¤2+2¡¤3+3¡¤4+4¡¤5+¡­¡­+N£¨N+1£©+¡­¡­

LABLE:INC BX     ;BX++
      INC CX     ;CX++
      MOV AX,BX  
      MUL CX     ;AX=BX*CX
      ADD DX,AX  ;DX+=AX
      CMP AX,200 ;N*(N+1)>200?
      JB LABLE
MOV BUF,DX


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
