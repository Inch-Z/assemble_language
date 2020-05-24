DSEG    SEGMENT 'DATA'
      ; add your data here!
      STRING db '3_/a3Mu#'
      NUM db 50h dup(0)
      Bchar db 50h dup(0)
      Lchar db 50h dup(0)
      OTHER db 20h dip(0)
      
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
    mov si,0
    mov di,0
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
head: cmp string[si],'#'
    jz end
N_L:cmp string[si],57
    ja B_L
    cmp string[si],48
    jb B_L
    mov di,ax
    mov al,string[si]
    mov num[di],al
    mov ax,di
    inc ax
    jmp exit
B_L:cmp string[si],90
    ja L_L
    cmp string[si],65
    jb L_L
    mov di,bx
    mov bl,string[si]
    mov Bchar[di],bl
    mov bx,di
    inc bx
    jmp exit
L_L:cmp string[si],122
    ja O_L
    cmp string[si],97
    jb O_L
    mov di,cx
    mov cl,string[si]
    mov Lchar[di],cl
    mov cx,di
    inc cx
    jmp exit
O_L:mov di,dx
    mov dl,string[si]
    mov Other[di],dl
    mov dx,di
    inc dx
    jmp exit    
exit:inc si
    jmp head
end:
      MOV AX, 4C00h ; exit to operating system.
      INT 21h    
   START   ENDP
CSEG    ENDS
END    START    ; set entry point.
