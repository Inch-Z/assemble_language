DSEG    SEGMENT 'DATA'
      ; add your data here!
      buf1 dw 8654h
      buf2 dw 0
      buf3 dw 0
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
        mov ax,buf1
        test ax, 8000h
        mov buf2,ax
        mov buf3,ax
        jz end
        neg ax
        mov buf2,ax
        sub ax,1
        mov buf3,ax
      end:  
      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
