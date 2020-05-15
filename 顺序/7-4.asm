DSEG    SEGMENT 'DATA'
      ; add your data here!
      x dw 1234H
      y dw 234H
      z dw 2345H
      w dw 4567H
      
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
      mov ax,w
      sbb ax,x
      cwd
      idiv y
      mov cl,5
      idiv cl
      sal ax,1
      mov z,ax 
      
      
      
      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
