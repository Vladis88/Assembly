.model small
.stack 100h
.data

calc_menu		        db	10,13,10,13,"***CALCULATOR***$"
operation_menu   	    db	10,13,"Select an Operation$"
addition_menu	        db	10,13,"[A] Addition $"
subtraction_menu	    db	10,13,"[S] Subtraction$"
multiplication_menu	    db	10,13,"[M] Multiplication$"
division_menu	        db	10,13,"[D] Division$"
op_menu		            db	"********************",10,13,"Your Operation : $"
op_ans		            db	6 dup("$")
erorrInput              db  10,13,"Incorrect input!!!$"
endLine		            db	13,10,"$"  
num1_msg	            db	"Input First Number: $"
input_num1	            db	10 dup("$")
num2_msg	            db	"Input Second Number: $" 
input_num2	            db	10 dup("$")
continue	            db	10,13,"Would you like to continue?[y/n] : "
cont_ans	            db	10 dup("$") 
exit_msg                db  10,13,10,13,"   ------------",10,13,"    GOOD BYE :)",10,13,"   ------------",10,13,'$'
result_msg              db  10,13,"Result = $"
.code       

;;;;;;;;;;;;;;;;;;; ����� ;;;;;;;;;;;;;;;;;;;;;;
printstr proc
	mov ah, 09h
	int 21h
	ret
printstr endp

;;;;;;;;;;;;;;;;;;; ����� ������ ����� ;;;;;;;;;;;;;;;;;;;;;;
OutInt proc 
;��������� �� ����
   test    ax, ax
   jns     oi1
;���� ���� �����, ������� ����� � ������ ����� �����.
   mov cx,ax
   mov ah, 02h
   mov dl, '-'
   int 21h
   mov ax, cx
   neg ax
;���������� ���� ����� ������� � CX.
oi1:  
    xor cx, cx
    mov bx, 10 ;��������� ��. 10 ��� ������������
oi2:
    xor dx,dx
    div bx ;����� ����� �� ��������� ��.� ������� ���������� �����, ������� ��� �����
    push dx  ;�������� � � �����
    inc cx
;�������� ���������� AX
    test ax, ax ;����� �� �� �� �����, �.�. AX = 0?
    jnz oi2
;�����
    mov ah, 02h
oi3:      
    pop dx  ;��������� ��������� �����, ��������� � � ������ � �������
    add dl, '0';� ������� ��������� '0'-30
    int 21h
    loop oi3 ;�������� ����� ������� ���, ������� ���� ���������  
    ret
OutInt endp  

;;;;;;;;;;;;;;;;;; ���� ;;;;;;;;;;;;;;;;;;;;;;;;;
input proc
    mov ah,0Ah
    int 21h 
    ret
input endp    

;;;;;;;;;;;;;;;;;; �������������� � ����� ����� � ���������� ��� � ������� AX ;;;;;;;;;;;;;;;;;;;;;;
inInt proc  
    xor di,di
    cmp byte ptr [si],"-" 
    jnz i1 
    mov di,1 ;������������ ����, ���� ����, ��� ����� �����.
    inc si   
i1:
    xor ax,ax
    mov bx,10 
i2:
    xor cx,cx
    mov cl,[si] ;����� ������
    cmp cl,0dh ;��������� �� ��������� �� �� (��� ������ �� ���������)
    jz endin

;���� �� ���������, �� ��������� ��� �� ������������    
    cmp cl,'0' ;���� ����� < 0
    jb er
    cmp cl,'9' ;���� ����� > 9
    ja er
 
    sub cl,'0' ;������ �� ������� �����
    mul bx     ;�������� �� 10
    add ax,cx  ;���������� � ���������
    inc si     ;��������� � ���������� �������
    jmp i2     
er:
    mov dx, offset erorrInput
    mov ah,09
    int 21h
    jmp i3
endin:
    cmp di,1 ;������, ��� ����� ������� ���� �������������
    jnz i3
    neg ax  ;������ ����� ������������� 
i3: 
    ret   
inInt endp 

;;;;;;;;;;;;;;;;;;;; ������ ��������� ;;;;;;;;;;;;;;;;;;;;;;;;	
start: 
    mov ax, @data
    mov ds, ax
    mov es, ax 
    ;���� ������
    lea dx, calc_menu
    call printstr
    lea dx, operation_menu
    call printstr
    lea dx, addition_menu
    call printstr 
    lea dx, subtraction_menu
    call printstr 
    lea dx, multiplication_menu
    call printstr
    lea dx, division_menu
    call printstr  
    lea dx, endLine
	call printstr	
	lea dx, op_menu
	call printstr 
    mov dx, offset op_ans
    call input  
	cmp op_ans+2, 'A'
	je addit 
	cmp op_ans+2, 'S'
	je subtract 
	cmp op_ans+2, 'M'
	je multip 
	cmp op_ans+2, 'D'
	je divis  
	jmp erorrChoice
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
addit:   
    ;���� ������� �����
    lea dx, endLine
    call printstr
    lea dx, num1_msg
    call printstr
    mov dx, offset input_num1
    call input    
    ;������� ������ � �����
    mov si,offset input_num1+2  
    call inInt 
    push ax
    ;���� ������� �����
    lea dx, endLine
    call printstr
    lea dx, num2_msg
    call printstr 
    mov dx, offset input_num2
    call input 
    lea dx, result_msg
    call printstr 
    ;������� ������ � ����� � ��������
    mov si,offset input_num2+2  
    call inInt
    xor bx,bx
    pop bx
    add ax,bx
    call OutInt
    jmp choiceExit	  	 
subtract:  
    ;���� ������� ����� 
    lea dx, endLine
    call printstr
    lea dx, num1_msg
    call printstr
    mov dx, offset input_num1
    call input   
    ;������� ������ � �����
    mov si,offset input_num1+2  
    call inInt
    push ax
    ;���� ������� �����
    lea dx, endLine
    call printstr
    lea dx, num2_msg
    call printstr 
    mov dx, offset input_num2
    call input 
    lea dx, result_msg
    call printstr 
    ;������� ������ � ����� � ��������
    mov si,offset input_num2+2  
    call inInt
    xor bx,bx
    pop bx
    sub bx,ax 
    mov ax,bx
    call OutInt
    jmp choiceExit
    
multip:
    ;���� ������� �����
    lea dx, endLine
    call printstr
    lea dx, num1_msg
    call printstr
    mov dx, offset input_num1
    call input  
    ;������� ������ � �����
    mov si,offset input_num1+2  
    call inInt
    push ax
    ;���� ������� ����� 
    lea dx, endLine
    call printstr
    lea dx, num2_msg
    call printstr 
    mov dx, offset input_num2
    call input 
    lea dx, result_msg
    call printstr 
    ;������� ������ � ����� � ��������
    mov si,offset input_num2+2  
    call inInt
    xor bx,bx
    pop bx
    imul bx 
    call OutInt
    jmp choiceExit
      
divis:
    ;���� ������� ����� 
    lea dx, endLine
    call printstr
    lea dx, num1_msg
    call printstr
    mov dx, offset input_num1
    call input  
    ;������� ������ � �����
    mov si,offset input_num1+2  
    call inInt
    push ax
    ;���� ������� ����� 
    lea dx, endLine
    call printstr
    lea dx, num2_msg
    call printstr 
    mov dx, offset input_num2
    call input 
    lea dx, result_msg
    call printstr  
    ;������� ������ � ����� � ��������
    mov si,offset input_num2+2  
    call inInt
    xor di,di
    xor bx,bx 
    mov bx,ax
    test bx,bx ;���� ������ ����� �����.
    jns L1
    mov di,1   ;������ di=1 
    neg bx     ;� ����� ������ �����.
L1:
    pop ax  
    test ax,ax ;��������� ������ ����� �� �����, ���� ��� �����.
    jns L2
    add di,1   ;�� ��������� � di+1 (di=2)
    neg ax     ;������ ����� �����.
L2: 
    push bx 
    idiv bx    ;��������� ������� ������������� �����
    push dx 
    cmp di,2   ;���� ������� ��� �����. �����
    jns L3     ;�����, ��������� �� �����
    cmp di,1   ;���� ���� ���� �� ��� �����., � ������ �����., �� ��������� ����� ������� ����� ���� '-'
    js L3      ;�����, ��������� �� �����
    mov cx, ax 
    mov ah, 02h
    mov dl, '-'
    int 21h
    mov ax, cx
L3:
    call OutInt  
    mov ah, 02h
    mov dl, '.'
    int 21h 
    pop ax 
    pop bx
    xor cx,cx
    mov cx,10
    mul cx
    div bx     
    mov dx,ax
    mov ah, 02h 
    add dx,'0'
    int 21h
    jmp choiceExit
    
erorrChoice:
    lea dx, erorrInput
    call printstr 
    jmp choiceExit 
       
choiceExit:
    lea dx,continue
    call printstr
    mov dx, offset cont_ans 
    call input
    cmp cont_ans+2, 'y'
    je start 
    cmp cont_ans+2, 'n'
    je exit
    jne erorrChoice 
    
exit:    
    lea dx, exit_msg
    call printstr
    mov ah, 4ch
    int 21h
end start