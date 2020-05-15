DSEG    SEGMENT 'DATA'
      ; add your data here!
      BUF db 00h,99h,01h
      Max db 0
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
    mov al,buf;buf->al
    mov cx,2;loop 2
    mov si,1;1->si
lop:cmp al,buf[si]
    jae positive
    mov al,buf[si]
positive:inc si;si++
    loop lop;loop
    mov Max,al

      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
