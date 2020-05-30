.model small
.stack 100h
.data
 
message_input     db "Enter the string: $"
message_result    db "Your string after sorting: $"
message_error     db "!!!-> ERROR <-!!! $"
message_try_again db "Try again: $"
result            db "      |---> RESULT <---| $"
message_source    db "Your string: $"
endline           db 10, 13, '$'  ;0Dh, 0Ah
;����� �� 200 + 3((1)������������ ������ | (2)����� ������ | ��������� ������ | (3)'$'...) �������� 
size equ 203
buffer db size dup('$')

.code 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
output macro str ;����� ������
    mov ah,9
    lea dx,str
    int 21h
endm

input macro str ;���� ������
    mov ah,0Ah
    lea dx,str
    int 21h
endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:         
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov buffer, size
    
    output message_input   
    
    input buffer 
    cmp buffer[3], '$'
    je error_end 
    jmp check_simbols 

str_out:
    mov ax, 3
    int 10h  
    
    output message_source   
    mov ah, 9
    mov dx, offset buffer + 2
    int 21h  
    
    output endline
    output endline
    jmp main_loop   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
main_loop:         
    mov ah, 9
    mov dx, offset buffer + 2
    int 21h 
    output endline
    ;�������� ��������(0)
    xor si, si
    xor di, di
    xor ax, ax
    xor dx, dx    
    mov si, offset buffer + 2  ;ds:si - ������ ������
   
first_word:         
    cmp byte ptr[si], ' ' 
    jne check_compare        ;���� ������ �� ������
    inc si
    cmp byte ptr[si], 13
    je the_end               ;���� ����� ������ - ����� �� ���������                     
    jmp first_word
     
loop_per_line:
    inc si
    cmp byte ptr[si], ' '
    je check_whitespace      ;���� ������
    cmp byte ptr[si], 13     ;�������� �� ���� ������
    jne loop_per_line        
    cmp ax, 0                
    jne main_loop
    jmp the_end              ;���� ����� ������ - ����� �� ��������� 
       
check_compare:
    cmp dx, 0
    jne compare              ;���� ���� ��� ����� - ��������
    push si                  ;��������� ����� ������� ����� � ����
    mov dx, 1 
    jmp loop_per_line
    
check_whitespace:
    cmp byte ptr[si+1], ' '
    je loop_per_line         ;���� ��������� �������� ���� ������
    inc si                   ;����� ������� �����
    jmp check_compare
    
compare:
    pop di                   ;������� ����� ������� �����    
    push si                  ;�������� ����� ������� ����� 
    push di                  ;�������� ����� ������� �����
    mov cx, si
    sub cx, di
    repe cmpsb               ;��������, ���� ������� �����   
    dec si
    dec di
    xor bx, bx
    mov bl,byte ptr[di] 
    cmp bl, byte ptr[si] 
    jg change                ;��������, ���� ������ ����� > �������
    pop di                   ;����� ��������� ������ ����� � �����
    pop si
    push si 
    
    jmp loop_per_line
    
change:
    inc al
    pop di
    pop si
    
    xor cx, cx
    xor bx, bx
    mov dx, si               ;������ �����  
loop1:                       ;���� ������ ������� �����
    dec si
    inc cx
    cmp byte ptr [si-1], ' '
    je loop1
    
loop2:
    dec si
    mov bl, byte ptr [si] 
    push bx                  ;����� ������ ����� � ���� (� �����)

    inc ah                   ;����� ������� �����
    cmp si, di
    jne loop2
    
    mov si, dx               ;dx = ������ ������ ������� �����
    
loop3:                       ;������ ����� ������ �������
    cmp byte ptr [si], 13
    je loop4
    mov bl, byte ptr [si]
    xchg byte ptr [di], bl   
    
    inc si
    inc di
    cmp  byte ptr [si], ' '
    jne loop3
    
loop4:
    mov byte ptr[di], ' '
    inc di
    loop loop4
    
    mov si, di
    mov dx, si
    dec si
loop5:                       ;������ ����� ������ ������� �� �����
    inc si
    cmp byte ptr[si], 13
    je main_loop
    
    pop bx
    mov byte ptr[si], bl
    
    dec ah
    cmp ah, 0
    je loop6
    
    jmp loop5
    
loop6:
    push dx
    mov dx, 1
    xor cx, cx
    jmp loop_per_line     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
check_simbols:
    mov dx,2
A1: 
    mov si,dx 
    cmp buffer+[si+1], '$' 
    je str_out
    mov al,buffer+[si]
    cmp al,20h
    je A3 
    cmp al,41h
    js error_end
    cmp al,5Ah
    js A3
    cmp al,61h
    js error_end
    cmp al, 7Bh
    js A3
    jns error_end
A3:
    add dx,1 
    jmp A1 
                   
error_end: ;������ ��������� �� ����� ������  
    mov ax, 3
    int 10h 
    
    mov bl,2
    div bl
    mov cx,20h
    sub cx,ax
    mov ah,02h
    mov bh,00h
    mov dl,cl
    mov dh, 10
    int 10h
    mov ah,9
    mov dx, offset message_error
    int 21h
    jmp exit  
           
the_end:
    output endline
    output endline   
    output endline
    output result  
    output endline
    output endline
    output message_result 
    
    mov ah, 9
    mov dx, offset buffer + 2
    int 21h
exit:    
    mov ah, 4Ch
    int 21h 
end start