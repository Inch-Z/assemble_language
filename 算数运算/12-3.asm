DSEG    SEGMENT 'DATA'
      ; add your data her
string db 'enter strings, enter n',0dh,0ah,'$'
err db 'Errors!!!','$'
string1 db 20
        db 0
        db 20 dup('$')
        

string2 db 10
        db 0
        db 10 dup('$')

string3 db 20 dup('$')
DSEG    ENDS

SSEG    SEGMENT STACK   'STACK'
      db   256  DUP(0)
SSEG    ENDS

CSEG    SEGMENT 'CODE'
spac macro
      mov ah,02h
      mov dl,0dh
      int 21h
      mov ah,02h
      mov dl,0ah
      int 21h     ;;»»ÐÐ
endm

dispmsg macro message
    lea dx,message
    mov ah,09h
    int 21h  ;;ÏÔÊ¾×Ö·û´®
endm

scanf macro string
      mov ah,0ah
      mov dx,seg string
      mov ds,dx
      mov dx,offset string
      int 21h  ;;ÊäÈë×Ö·û´®
endm

   START   PROC    FAR
      ; set segment registers:
      MOV AX, DSEG
      MOV DS, AX
      MOV ES, AX
      ; add your code here
      dispmsg string
      scanf string1
      spac  ;»»ÐÐ
      scanf string2
      spac  ;»»ÐÐ
      mov ax,ds
      mov es,ax
      mov ah,1
      int 21h
      sub al,30h
      call insert

      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
   
insert proc
      mov di,offset string3
      mov si,offset string1
      inc si
      xor cx,cx
      mov cl,[si] 
      cmp cl,al
      jl er
      inc si
      xor ah,ah
      sub cx,ax
      add si,ax
      mov bx,cx
      cld
      rep movsb
      
      mov di,offset string1
      mov si,offset string2
      add di,2
      inc si
      xor ah,ah
      add di,ax
      xor cx,cx
      mov cl,[si]
      inc si
      rep movsb
      
      mov si,offset string3
      mov cx,bx
      rep movsb
      spac
     
      dispmsg string1+2
      jmp end
      
er:  spac
     dispmsg err
    
end:
ret
insert endp
CSEG    ENDS
END    START    ; set entry point.
