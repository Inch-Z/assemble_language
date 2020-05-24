DSEG    SEGMENT 'DATA'
      ; add your data here!
      notice1 db 'Please input two strings', 0dh,0ah,'$'
      notice2 db 'print the number from right',0dh,0ah,'$'
      buf1 db 26
           db 0
           db 25 dup(0),'$'
      buf2 db 26
           db 0
           db 25 dup(0),'$'
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
        mov dx,seg notice1
        mov ds,dx
        mov dx,offset notice1
        mov ah,9
        int 21h                 ;提示1
        mov dx,seg notice2
        mov ds,dx
        mov dx,offset notice2
        mov ah,9
        int 21h                 ;提示2
        mov dx,offset buf1
        mov ah,0ah
        int 21h                 ;input1
        mov dx,offset buf2
        mov ah,0ah
        int 21h                 ;input2
        
        mov dx,0
        mov al,buf1+1
        mov bl,buf2+1
        sub al,bl
        mov dl,al 
        
        mov al,buf1+1
        mov ah,0
        mov si,ax
        add si,2
        mov di,26
B_1:    mov al,buf1[si]
        mov buf1[di],al
        dec si
        dec di
        cmp si,1
        ja B_1
D_1:    mov buf1[si],' '
        dec di
        cmp si,1
        ja D_1
        
        mov al,buf2+1
        mov ah,0
        mov si,ax
        add si,2
        mov di,26
        sub di,dx
B_2:    mov al,buf2[si]
        mov buf2[di],al
        dec si
        dec di
        cmp si,1
        ja B_2
D_2:    mov buf2[si],' '
        dec di
        cmp si,1
        ja D_2
        

        mov dl,0dh
        mov ah,2
        int 21h
        mov dl,0ah
        mov ah,2
        int 21h
        
        mov dx,offset buf1
        add dx,2
        mov ah,9
        int 21h
        
        mov dl,0dh
        mov ah,2
        int 21h
        mov dl,0ah
        mov ah,2
        int 21h

        
        mov dx,offset buf2
        add dx,2
        mov ah,9
        int 21h
        
      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
