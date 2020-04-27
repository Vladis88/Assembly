.model small 
.stack 100h
.data 
    platform        db 0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0DBh,11h,0FEh,11h ;���������(������, ����)
    platformRight   dw ?         ;��� ������������ ������ � ����� ������ ���������,
    platformLeft    dw ?         ;����� � ���������� ���������� �� ���������
    line_title      db 0DBh,01h  ;������, ����
    line            dw 0005h     ;������ �� ������� ������� (5)
    ball            db 02h,0Eh   ;������, ����  
    size_platform   dw 001Ah     ;26->13*2                
    size_line       dw 00A0h     ;������ ������� � �������(160)                  
    platformLoc     dw 0F50h     ;��������� ������� ���������     
    ballLoc         dw 0FA0h     ;��������� ������� ������
    repeat          dw 8F00h     ;���������� � ����� (��������)
    endLine         dw 0FA0h     ;������ �������
    byteDivider     db 0002h     ;����� ��� ����, ����� ������, ����� ������ � ������ ��������� ������� ��� ���
    curX            dw 005Ah     ;��������� ������� (x) ������
    curY            dw 0017h     ;��������� ������� (y) ������
    vectorX         dw -2h       ;������ ������������ ������ �� X
    vectorY         dw -1h       ;������ ������������ ������ �� Y
    points          dw 0000h     ;���-�� ��������� �����                           
    max_coints      dw 01F4h     ;������������ ���-�� ����� (500)                
    points_str      db 10 dup(?) ;��� �������� � ������ ���-�� �����           
    LEN             dw 0         ;������ ������ � score                 
    score           db ' ',0Fh,'s',0Fh,'c',0Fh,'o',0Fh,'r',0Fh,'e',0Fh,':',0Fh,' ',0Fh ,' ',0h,' ',07h  ,' ',07h
    size_score      dw 0x0015h 

;��� ������ �� ����� ���������� � �������� ����
           ;��������� �����
    rules  db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'C',0Fh,'l',0Fh,'i',0Fh,'c',0Fh,'k',0Fh,' ',0Fh
           db 'o',0Fh,'n',0Fh,' ',0Fh,'t',0Fh,'h',0Fh,'e',0Fh,' ',0Fh,'a',0Fh,'r',0Fh,'r',0Fh,'o',0Fh,'w',0Fh
           db ' ',0Fh,'(',0Fh,'<',0Fh,'-',0Fh,')',0Fh,' ',0Fh,'t',0Fh,'o',0Fh,' ',0Fh,'t',0Fh,'u',0Fh,'r',0Fh
           db 'n',0Fh,' ',0Fh,'l',0Fh,'e',0Fh,'f',0Fh,'t',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh 
           ;��������� ������ 
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'C',0Fh,'l',0Fh,'i',0Fh,'c',0Fh,'k',0Fh,' ',0Fh
           db 'o',0Fh,'n',0Fh,' ',0Fh,'t',0Fh,'h',0Fh,'e',0Fh,' ',0Fh,'a',0Fh,'r',0Fh,'r',0Fh,'o',0Fh,'w',0Fh
           db ' ',0Fh,'(',0Fh,'-',0Fh,'>',0Fh,')',0Fh,' ',0Fh,'t',0Fh,'o',0Fh,' ',0Fh,'t',0Fh,'u',0Fh,'r',0Fh
           db 'n',0Fh,' ',0Fh,'r',0Fh,'i',0Fh,'g',0Fh,'h',0Fh,'t',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh  
           ;����� ����   
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh
           db ' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,' ',0Fh,'T',0Fh,'o',0Fh,' ',0Fh,'s',0Fh,'t',0Fh,'a',0Fh
           db 'r',0Fh,'t',0Fh,' ',0Fh,'t',0Fh,'h',0Fh,'e',0Fh,' ',0Fh,'g',0Fh,'a',0Fh,'m',0Fh,'e',0Fh,' ',0Fh 
           db 'p',0Fh,'r',0Fh,'e',0Fh,'s',0Fh,'s',0Fh,' ',0Fh,'a',0Fh,'n',0Fh,'y',0Fh,' ',0Fh,'k',0Fh,'e',0Fh
           db 'y',0Fh,'!',0Fh,'!',0Fh,'!',0Fh
           
    size_rules dw 01A8h   ;424 ��������
    
    game_over   db 'G',0Fh,'A',0Fh,'M',0Fh,'E',0Fh,' ',0h,'O',0Fh,'V',0Fh,'E',0Fh,'R',0Fh
    winner      db 'W',0Fh,'I',0Fh,'N',0Fh 
    flag        db 0
    curSpeed    dw 8F00h  ;��������         
    
    SPA     equ 20h       ;��� �������                
    PL      equ 0FEh      ;������ ������ (� ����������� � ���� �����������)            
   
    LEFT    equ 4B00h     ;����������� ��� "<-"
    RIGHT   equ 4D00h     ;����������� ��� "->"  
    ENTER   equ 1C0Dh     ;����������� ��� "Enter"  
    
.code 
 start:   
    main1: 
    call begin         ;������
    call cursorHide    ;�������� ������
    call clearScreen   ;������� �����
    call drawRules     ;����� ������� ����
    call drawTitle     ;������ ������� �������
    call drawScore     ;������ ������� ����
    call points_show   ;������ ����� ��������� �����
    call drawPlatform  ;������ ���������
    call drawBall      ;������ ���
    call drawBreaks    ;������ ���������
    call go            ;�������� ����� ������� ��� ������ 
 main:                 ;������� ���� ����
    mov cx,[repeat]           
  cycle:  
    call movePlatform  ;��������� ����. ���������
    dec cx             ;��������� ������� �� ����
    cmp cx, 0          ;���� �� 0, ���� ������ �� ����
    jne cycle                 
    call moveBall      ;����� ���������� �      
    call drawBall      ;������ �����
    jmp main           ;� ���� ����� � main
     
    begin:
        mov ax,@data
        mov ds, ax
        mov ah,00    ;��������� �����������                      
        mov al,03    ;���������� ����� 3 (16 ������) � �������� ������ 
        int 10h      ;���������� bios
        
        push 0B800h              ;���������� ������ ����������� � ����
        pop es                   ;��������������� ����� ������ � es
        mov ax, [platformLoc]    ;���������� ������� ��������� � ax              
        mov [platformLeft], ax   ;�� ax ���������� ������(����� �������) ���������           
        mov [platformRight], ax  ;-||- � �����(������ �������) ���������, �� ��� �� ��������
        mov ax, [size_platform]  ;���������� � ax ������ ���������          
        add [platformRight],ax   ; � ��������� ���� ������ � �����(������ �������) ��������, ������ ��� ��������!          
        ret
     go:
        mov ah, 00h     ;������� ������(�������) ������� �������          
        int 16h   
     cursorHide:                  
        mov ah,1        ;�-� ��������� ������� �������         
        mov cx, 2000h   ;������ ������ ����������(������� ������ - 0607h)           
        int 10h 
        ret
     drawScore:
        mov di, 00h           ;������� 0 � di
        lea si, score         ;������� �����
        mov cx, [size_score]  ;������� ������ � cx(15)
        rep movsb             ;���������� � ������ �� ������ es:di ���� �� ������ � ������� ds:si (���� cx ������ ������ 0)
        ret
     drawTitle:                 
        xor ax, ax         ;�������� ax
        mov ax, 0001h      ;������� � ax 1
        mul [size_line]    ;�������� 1 �� ax �������� �������� size_line (160)       
        mov di, ax         ;������� ��� �������� � di(160), ��� �������� ����������
        add ax, size_line  ;����������� ax �� size_line (�.�. ax = 320), ��� ����, ����� �������� ������ � ����
     cycle_:                 
        cmp di, ax                 ;���������, ���� �� ��� ����������,   
        je return                  ;�� �������  
        mov si, offset line_title  ;������� ����� ����� ������ ��� ��������� ������� ������ �� ������
        mov cx, 2                  ;����� ������� � cx 2 ��� ����, ����� ����������� ������ ��� �����
        rep movsb                  ;���������� � ������ �� ������ es:di ���� �� ������ � ������� ds:si (���� cx ������ ������ 0)
        jmp cycle_                 ;��������� �����
     clearScreen:               
        mov ah,6       ;������� ��������� ����(�����)
        mov al,0       ;�� ���� ������           
        mov bh,7       ;���� ��������� ��� ���������� ������            
        xor cx,cx      ;�������� ���������� ������ �������� ����(ch=0,cl=0)           
        mov dl,79      ;������������� �������� ������� ������� ����        
        mov dh,24      ;(24,79)
        int 10h
        ret
     drawBreaks:
        ;�������� ������� ������ ���� �������� ��������             
        mov ax, [line]       ;�������� ����� � �������� ���� ��������  
        mul [size_line]        
        mov bx, ax           ;800     
        add ax, [size_line]  ;��������� ����� �����(960 - 3C0h), ����� ����� ��������� � bx  
        mov cx, 0032h        ;���-�� ���������� (50)     
     loopl:         
        call drawBlock      ;������ ������  
        call drawSpace      ;������ ������    
        dec cx              ;��������� �������   
        cmp cx, 0           ;���� ������� �� ����� 0, ������ ������� � �������
        je return           ;���� ��������� - �������   
        cmp bx, ax          ;���� �� ���������� ��� �����   
        jge new_line        ;��������� �� �����
        jmp loopl           ;����� ������������ �� ����� �����
     new_line:                   
        add ax, [size_line] ;��������� ������ ��������� ������   
        add [line],1        ;�������� ������� ����� �� 1 ����    
        push ax             ;��������� �������� ax (1120 - 460h)
        mov ax, [line]      ;�������� � ax 6 - ��������� ������
        div [byteDivider]   ;����� �� 2, ����� ��������� ����� �� ������ ������ �� ������ ��� ���
        cmp ah, 1           ;���� � ������� 1, �� �� �����, 
        je step             ;��������� � step   
        add bx, 8           ;����� ������ ������ � ������� ���������  
        pop ax              ;��������������� ax
        jmp loopl           ;��������� �� ��������� ����� �����    
     step:
        pop ax              ;�������������� ax
        mov bx, ax          ;������� ��� � bx
        sub bx, [size_line] ;� bx ��������� ����� ����� ��� ����������� ��������� � ax     
        jmp loopl           ;�������� �������� ��������� �����
     drawBlock:               ;���� �� 1 ��������  
        push cx               ;���������� ���-�� ����������
        mov cx, 0004h         ;���-�� ������ � ���������   
     drawBlock2:              ;������ �������� � 4-� �����������        
        mov es:[bx], PL       ;�������� ������, ������� ����� ����� ��������
        mov es:[bx+1], 021h   ;�������� ���� ���������(������-������) � ���� ���������������� �������� (�����)  
        add bx, 2             ;��������� 2(�.�. �� ������� ��� ��������), ����� ����� �������� � ax   
        dec cx                ;��������� �������
        cmp cx, 0             ;���������, ������� ��������� �����������    
        jne drawBlock2        ;������ ������, ���� �� ������
        pop cx                ;��������������� ���-�� ����������    
        ret
     drawSpace:             ;������������ 1 ��������         
        push cx             ;���������� ���-�� ����������
        mov cx, 0004h       ;������ ���������� ����� ��, ��� ���������� ���������
     drawSpace2:
        mov es:[bx], SPA    ;��������� ��������    
        mov es:[bx+1], 0h   ;�������� ���� (������)
        add bx, 2           ;��������� 2(�.�. �� ������� ��� ��������), ����� ����� �������� � ax
        dec cx              ;��������� ������� �� �������� �����
        cmp cx, 0           ;��������� ������� �� �������� �����
        jne drawSpace2      ;��������� ������, ���� �� ������ ����������
        pop cx              ;��������������� ���-�� ����������
        ret  
     drawPlatform:                  
        mov di, [platformLoc]      ;������� ���������
        mov cx, [size_platform]    ;������ ���������
        mov si, offset platform    ;����� ���������
        cld
        rep movsb                  ;������ ���������
        ret  
     movePlatform:              ;��������� ���� ����� ����������� ���������
        mov ah, 01h           
        int 16h                 ;���� �� ������ ����� �������, �� 
        jnz checkKey            ;��������� � checkKey � ������������ ����. ���������
        ret
     checkKey:                  ;��������� � ������ ������ � �����
        mov ah, 00h             ;������� ������(�������) ������� �������
        int 16h 
        cmp ax, RIGHT           ;���� ������ ������� '->', �� 
        je  go_right            ;��������� �� ��������� ����������� ��������� ������ 
        cmp ax, LEFT            ;���� ������ ������� '<-', ��
        je  go_left             ;��������� �� ��������� ����������� ��������� �����
        ret
     go_right:                         ;������� ������   
        mov bx, [platformLoc]          ;�������� ������ ���������(����� �������) � bx
        add bx, [size_platform]        ;��������� � bx ������ ��������� � �������� ������ ������� ���������  
        cmp bx, [endLine]              ;���� �� ������� ������ ������� ����, �� �� ������ �������, 
        jge movePlatform               ;� ���� �� �������� ������������ ���������
        mov es:[bx],PL                 ;��������� ������� ������, ������� ����� ����� ��������
        mov es:[bx+1], 011h            ;����������� ������� � ��������� ������� � ����� ����
        mov bx, [platformLoc]          ;�������� ����� ������� ���������
        mov es:[bx],SPA                ;������� �����, ������� ��� ��� �� ����
        mov es:[bx+1],0h               ;� ����������� ������ ������
        add [platformLoc],2            ;������ ������� ���������
        add [platformRight], 2         ;��������� � ������ ������� ��������� 2
        add [platformLeft], 2          ;� � ����� ������� 
        jmp movePlatform               ;��������� �� �������� ����. ���������
     go_left:                       ;������� �����    
        cmp [platformLoc], 0F00h    ;���� �� ������� ����� ������� ����, �� �� ������ �������,    
        jle movePlatform            ;� ���� �� �������� ������������ ��������� 
        sub [platformLoc], 2        ;������ ������� ���������
        sub [platformRight], 2      ;�������� �� ������ ������� 2
        sub [platformLeft], 2       ;� �� �����    
        mov bx, [platformLoc]       ;�������� ����� ������� ���������
        add bx, [size_platform]     ;��������� � bx ������ ��������� � �������� ������ ������� ���������    
        mov es:[bx],SPA             ;������� �����, ������� ��� ��� �� ����
        mov es:[bx+1],0h            ;� ����������� ������ ������
        mov bx, [platformLoc]       ;�������� ����� ������� ���������     
        mov es:[bx],PL              ;��������� ������� �����, ������� ����� ����� ��������
        mov es:[bx+1], 011h         ;����������� ������� � ��������� ������� � ����� ����
        jmp movePlatform            ;��������� �� �������� ����. ���������
     drawBall:
        xor bx, bx               ;�������� bx
        mov bx, [ballLoc]        ;������� ������� ������ � bx
        xor ax, ax               ;�������� ax
        mov ax, [curY]           ;������� ���������� Y � ax
        mul [size_line]          ;ax �������� �� ������
        add ax, [curX]           ;� ��������� ������� X - �������� ��������� ������ � ������ ���������
        mov [ballLoc], ax        ;� ������� ��� � ����� "ballLoc"
        cmp ax, bx               ;���������� � bx
        je return             
        mov di, ax               ;������� ���� ������� � di
        mov si, offset ball      ;������ ����� �������� ��� ��������� ������ � si
        mov cx, 2                ;���������� ���� ��� ���� - ��� ����� � ����
        cld                      ;������� ����� �����������
        rep movsb                ;������
        mov es:[bx], SPA         ;���� ����� �������, ����� ����� ����� ��������
        mov es:[bx+1], 0h        ;�������/������� ���������� �������
        ret     
        
     ;�������� ����������� ������ Y
     changeVectorY:          
        neg [vectorY]            
        jmp checkBorderX  
     ;�������� ����������� ����� X
     changeVectorX: 
        neg [vectorX]
        jmp next  
        
     moveBall:     
     ;��������� ������� Y             
     checkBorderY:             
        cmp [curY], 2  ;������� �������         
        je changeVectorY  
     ;��������� ������� Y
     checkBorderX:              
        xor dx, dx               
        mov dx, [size_line]     ;������� � dx ������ ����������
        sub dx, [vectorX]        
        cmp [curX], dx          ;��������� ������� ��������� X
        jge  changeVectorX      ;���� �� ����� ������ ������
        cmp [curX], 0           ;��������� ������� ��������� X
        jle  changeVectorX      ;���� �� ����� ����� ������
     next:                       
        xor ax, ax  
        mov ax, [curY]          ;������� ������� ��������� Y
        add ax, [vectorY]       ;������ ��������� Y
        mov [curY], ax          ;������ �������
        xor bx, bx
        mov bx, [curX]          ;������� ������� ��������� X 
        add bx, [vectorX]       ;������ ��������� X
        cmp bx, 0               ;��������� ��������� X
        jl back1
      next1:  
        mov [curX], bx          ;������ ������� ��������� X
        mul [size_line]          
        add ax, bx              
        mov di, ax
        push di
        mov ax, es:[di]         ;���������� � �����������
        
     ;�������� �� ��������� � ������ � �� ���������
     next2:  
        pop di
        mov ax, es:[di]
        cmp al, PL        ;���� ����� � ������
        je back_move      ;��������� �� �������� ��������� � ������ � �������� �����
        cmp [curY], 0019h      ;��������� �� ����� �� �� �� ������ ������� �����(�.�. ���������)    
        je gameOver
        cmp al, 0FEh           ;�������� ������� �������
        jne check_go_awake      
        ret  
     back1:                   
        neg [vectorX]            ;������ �����������
        add bx, [vectorX]      
        add bx, [vectorX]      
        jmp next1   
     back_move: 
        call checkBrick       
        neg [vectorY]            ;������ ����������� ������� X        
        neg [vectorX]            ;������ ����������� ������� Y
        mov ax, [curY]           ;���������� � ax ������� ��������� Y
        add ax, [vectorY]        ;��������� ������ Y 
        mov [curY], ax           ;���������� � ������� ���������
        mov ax, [curX]           ;���� ����� � �������� X
        add ax, [vectorX]        ;-||-
        mov [curX], ax           ;-||-
        neg [vectorX]            ;������ ����������� ������� X
        call checkChangeVector  
        ret 
               
     ;�������� �� ��������� ����������� �������� ������, ��� ��������� �� ���������
     checkChangeVector:           
        mov dx, [platformLeft]       
        sub dx, [size_line] 
        cmp dx, [ballLoc]       
        je decVectorX               ;���� ��������� �����(����� �����)
        add dx, 2                
        cmp dx, [ballLoc]
        je decVectorX               ;���� ��������� �����(���� ��� ������ �� �����)
        add dx, 2
        cmp dx, [ballLoc]       
        je decVectorX               ;���� ��������� �����(��� ���� ������ �� �����)
        
        mov dx, [platformRight] 
        sub dx, [size_line]     
        cmp dx, [ballLoc]
        je incVectorX                ;���� ��������� ������(����� �����)
        sub dx, 2
        cmp dx, [ballLoc]
        je incVectorX                ;���� ��������� ������(���� ��� ����� �� �����)
        sub dx, 2
        cmp dx, [ballLoc]
        je incVectorX                ;���� ��������� ������(��� ���� ����� �� �����)
        ret
     decVectorX:  ;��������� X
        sub [vectorX], 2
        ret
     incVectorX:  ;����������� Y
        add [vectorX], 2
        ret 
     
     ;�������� ��������� � ������                                                  
     checkBrick:                
        cmp [curY],0018h       ;���� ����� �� ������, 
        je return              ;�������
        ;cmp [curY],0001h      ;����� ������ ����
        ;je return
        mov ax, [curY]         ;������� ��������� Y
        mul [size_line]        ;�������� ���� ������
        mov bx, ax             ;���������� ���
        add bx, [curX]         ;������� ��������� X
     loop1:                 ;��������� ������ �� ������ � ������          
        sub bx, 2           ;�������� �� bx 2      
        cmp bx, ax
        jl go1
        cmp es:[bx], SPA    ;��������� �� ������
        jne loop1           ;���� �� ����� �������� ���� ������
     go1:                       
        add bx, 2           ;��������� � bx 2, �.�. �� ������� � loop1 �� 2   
        call drawSpace
        add [points],10     ;��������� �� ������ ������ �������� �� 10-��       
        call points_show    ;������ ���-�� ����� � score: ___ 
        
     return:
        ret  
            
     gameOver:            ;����� ����. ������� ����� � ������� ��������� � ���������
        call clearScreen         
        mov ax,000Ah
        mul [size_line]
        add ax,0048h
        mov di, ax
        mov si, offset game_over
        mov cx, 0012h
        rep movsb 
        push ax
       
        call sleep                 
        jmp reload       ;����������� ��� ��������� ����...            
     sleep:
        mov cx,20        ;����� �������� � ��������.(������� �����)
        mov dx,0         ;����� �������� � ��������.(������� �����)  
        mov ah,86h       ;������� ��������       
        int 15h          ;��������       
        
     cycle_read:        ;�������� ������� ������� � ������
        mov ah,1              
        int 16h
        jnz read
        ret   
     read:              ;������ ������� � ���������
        xor ah,ah               
        int 16h 
        jmp cycle_read 
          
     check_go_awake: 
        mov bx, [ballLoc]     ;�������� ������� ������� ������     
        add bx, [vectorX]     ;��������� vectorX(�������� ������ �� Ox)   
        mov ax, es:[bx]       ;������� � �����������  
        cmp al, 0FEh          ;���������, ��� �����
        jne return            ;�������, ���� �� ������������� �� ���������
        mov ax, [curY]        ;� ������ ���������� X � Y  
        mul [size_line]
        mov dx, ax
        add ax, [curX]           
        sub ax, [vectorX]
        mov bx, ax
        mov ax, es:[bx]         
        cmp al, 0FEh
        jne return  
              
     ;��������� �������������� �������� ��� ��������� � ������(����� ��� �������, 
     ;���� �� � ������� �������, �.�. ���� �� ������ �� ���� ������� ��� ���������, 
     ;� ������� �������� �����)
     loop3:                  
        sub bx, 2
        cmp bx, dx
        je go2
        cmp es:[bx],0FEh
        je loop3
        add bx, 2
     go2:                        
        call drawSpace
        mov bx, [ballLoc]          
        add bx, [vectorX]        
     loop4:                        
        sub bx,2                  
        cmp es:[bx],0FEh
        je loop4
     next3:
        add bx,2                    
        call drawSpace
        neg [vectorY]             
        neg [vectorX]
        mov ax, [curY]
        add ax, [vectorY]
        mov [curY], ax
        mov ax, [curX]
        add ax, [vectorX]
        mov [curX], ax              
        add [points],20
        call points_show 
            
points_show:                         
    push bx                 ;���������� bx
    mov ax, [max_coints]    ;������� ������������ ���-�� ����� � ax
    cmp [points], ax        ;��������� �� ������� �� �� ��� ������������ ���-�� �����
    je win                  ;���� ��, �� �� ��������, ����� - ������ ��������� ���-�� �����
    lea bx, points          
    lea di, points_str      ;���������� ����� ����� ������(� ������� �� ����� ���������� ���-�� ��������� �����) � di
    call pointsTOstr        ;������� �����(���-�� ��������� �����) � ������              
    
    mov cx, LEN             ;������� � cx ���-�� ��� ������� ����� ��������
    mov di, 10h             ;������� 
    lea si, points_str      ;�������� ����� ����� ������ � ������
    cld                     ;������� ������ �����������
    rep movsb               ;������ ���-�� ��������� �����           
    pop bx                  ;��������������� bx
    ret 
;��������� ������� ����� � ������         
pointsTOstr PROC   
;���������� ��������                        
    push ax
    push bx
    push cx
    push di    
;��������� � ������
    mov ax, [bx]
    mov bx, 10
    xor cx, cx       
division:
    xor dx, dx
    div bx          ;����� �� 10(10-� �������),
    push dx         ;���������� �������
    inc cx          ;����������� ���-�� ��������, ������� � ����� �����
    cmp ax, 0       ;���� �� 0
    jne division    
    
    mov LEN, cx    ;n-������� ������� � ������ ������ (���-�� ��������)
    add LEN, cx    ;������ ������
save_in_str:
    pop dx
    add dl, '0'         ;��������� � ������
    mov [di], dl        ;��������� � ����� points_str
    inc di              ;����������� di
    mov [di], 0Fh       ;������������
    inc di              ;����������� di
    loop save_in_str    ;���������, ���� di != 0
       
    ;��������������� �������� � �������
    pop di 
    pop cx
    pop bx
    pop ax
    ret
endp 

drawRules proc
    mov di, 00h            ;������� 0 � di
    lea si, rules          ;������� � si ��������� ����� ������ ������
    mov cx, [size_rules]   ;� cx ������� ������ 
    rep movsb              ;���������� � ������ �� ������ es:di ���� �� ������ � ������� ds:si (���� cx ������ ������ 0)
    
    mov ah, 1              ;��� ����� � ����������
    int 21h 
    call clearScreen    
ret
endp

reload:     ;���������� ��� ���������� ����
    ;�� ������� enter �������� ���� �����
    mov ah, 00h
    int 16h
    mov bx, ENTER
    cmp ax, bx 
    jne endProgram    ;���� ������ �� enter �������
    ;������������� ��������, ����� ������ ���� ������
    mov [points], 0
    mov [platformLoc],0F50h
    mov [ballLoc],0FA0h
    mov [curX],005Ah
    mov [curY],0017h
    mov [vectorX],-2h
    mov [vectorY],-1h  
    mov [line], 5 
    mov [repeat],8F00h
    mov [flag], 0 
    ;� �������� �� �� �������, ��� � � ������, ��. ����
    call begin
    call clearScreen 
    call drawTitle 
    call drawScore
    call points_show 
    call drawPlatform 
    call drawBall
    call drawBreaks
    call go 
    jmp main  ;��������� �� ������� ���� ����  
    
endProgram:  ;���������� ���� � ��������
    call clearScreen
    mov ax, 4C00h
    int 21h
win:        ;����� ����. ����� ��������� � ������!
        call clearScreen
        mov ax,000Ah
        mul [size_line]
        add ax,0048h
        mov di, ax
        mov si, offset winner
        mov cx,000Eh
        rep movsb 
        push ax
        call sleep
        jmp reload