DSEG    SEGMENT 'DATA'
      ; add your data here!
      a db 12H,34H
      b db 56H,78H
      
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
      mov dx,0
      mov al,a
      mov ah,a+1
      add al,b
      adc ah,b+1
      adc dx,0
      test dx,0001h
      jnz label
      mov a,al
      mov a+1,ah
      label:


      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
