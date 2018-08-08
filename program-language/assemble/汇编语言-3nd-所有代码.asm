;进行不会溢出的除法运算
assume cs:code
code segment
start:
	
	;1000000/10(F4240H/0AH)
	;因为用到寄存器传参，所以先保存寄存器
	push ax;低16位
	push dx;高16位
	push cx;16位的除数
	;入参
	mov ax,4240h
	mov dx,0fh
	mov cx,0ah

	call divdw
	;从寄存器中取出函数返回的结果
	;mov ...,dx;取出商的高16位
	;mov ...,ax;取出商的低16位
	;mov ...,cx;取出余数
	
	;恢复寄存器
	pop cx
	pop dx
	pop ax
	
	;退出程序
	mov ax,4c00h
	int 21h

;ax=被除数的低16位
;dx=被除数的高16位
;cx=除数
;return: dx=结果的高16位, ax=结果的低16位,cx=余数
;公式：X/N=int(H/N)*65536+[rem(H/N)*65536+L]/N
divdw:
	
	ret
code ends
end start


;assume cs:code
;
;code segment
;start:
;	mov ax,1000h
;	mov dx,1
;	mov bx,1
;	div bx
;	
;	mov ax,4c00h
;	int 21h
;code ends
;
;end start



;assume cs:code,ds:data
;
;data segment
;	db 'word',0
;	db 'unix',0
;	db 'wind',0
;	db 'good',0
;data ends
;
;code segment
;start:
;	mov ax,data
;	mov ds,ax
;
;	mov si,0
;	mov cx,4
;	f:
;		call upper
;		add si,5
;	loop f
;	
;	mov ax,4c00h
;	int 21h
;	
;upper:
;	push cx
;	push si
;	
;	mov cx,0
;	s:
;		mov cl,[si]
;		jcxz done
;		and byte ptr [si],11011111b
;		inc si
;		jmp short s
;	done:
;	
;	pop si
;	pop cx
;	ret
;code ends
;end start


;assume cs:code,ds:data
;
;data segment
;	db 'conversation',0
;data ends
;
;code segment
;start:
;	mov ax,data
;	mov ds,ax
;	
;	mov ax,0
;	call upper
;
;	mov ax,4c00h
;	int 21h
;	
;;char *upper(char *src)
;upper:
;	push ax;用ax将src的首地址传入
;	push cx;因为要利用cx来判断是否为0
;	push bx;因为要从此来寻址
;	
;	mov bx,ax
;	mov cx,0
;	s:
;	mov cl,[bx]
;	jcxz done
;	and cl,11011111b;转换成大写
;	mov [bx],cl
;	inc bx
;	mov cl,2;为了能够再次循环	
;	loop s
;	
;	done:
;	pop bx
;	pop cx
;	pop ax
;	ret
;code ends
;end start


;assume cs:code,ds:data
;data segment
;	db 'conversation'
;	db '            '
;data ends
;
;code segment
;start:
;	mov ax,data
;	mov ds,ax
;	
;	mov si,0
;	mov di,12
;	mov cx,12
;	
;	call conv
;
;	mov ax,4c00h
;	int 21h
;;char *conv(const char*src,char *dst,size_t len)
;;src: si ,dst: di, len:cx
;conv:
;	push di; 因为这个地址要返回的，所以先保存起来
;	mov ax,0
;	s:
;		mov al,[si]
;		and al,11011111b
;		mov [di],al
;		
;		inc si
;		inc di
;	loop s
;	
;	pop ax; 通过ax将dst的首地址传出去
;	ret
;code ends
;end start



;assume cs:code
;
;code segment
;start:
;	mov ax,4;给子程序传递变量
;	call exp
;	;从ax中拿回返回值
;
;	mov ax,4c00h
;	int 21h
;	
;exp:; int exp(int n) 假设从eax传入n
;	push cx;因为子程序中要用到cx，所以要提前保存cx
;	mov dx,ax
;	mov cx,2
;	s:
;		mul dl
;	loop s
;	
;	pop cx
;	ret
;code ends
;end start


;assume cs:code
;data segment
;	dw 8 dup(0)
;data ends
;code segment
;start:
;	mov ax,data
;	mov ss,ax
;	mov sp,16
;	mov word ptr ss:[0],offset s
;	mov ss:[2],cs
;	call dword ptr ss:[0]
;	nop
;	s:mov ax,offset s
;	sub ax,ss:[0cH]
;	mov bx,cs
;	sub bx,ss:[0eh]
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start

;assume cs:code
;code segment
;start:
;	mov ax,6
;	call ax
;	inc ax
;	mov bp,sp
;	add ax,[bp]
;code ends
;end start

;assume cs:code
;
;code segment
;start:
;	mov ax,0
;	call far ptr s
;	inc ax
;	s:pop ax
;	add ax,ax
;	pop bx
;	add ax,bx
;	
;code ends
;end start


;assume cs:code
;code segment
;start:
;	mov ax,0
;	call s
;	inc ax
;	
;	mov ax,4c00h
;	int 21h
;	
;	s:pop ax
;	jmp ax
;code ends
;end start


;assume cs:code,ss:stack
;stack segment
;	db 16 dup(0)
;stack ends
;
;code segment
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,16
;	
;	mov ax,1000h
;	push ax
;	mov ax,50h
;	push ax
;	retf
;code ends
;end start

;assume cs:code,ss:stack
;stack segment
;	db 16 dup(0)
;stack ends
;
;code segment
;	mov ax,4c00h
;	int 21h
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,16
;	
;	push cs
;	mov ax,0
;	push ax
;	
;	retf
;code ends
;end start

;assume cs:code,ss:stack
;stack segment
;	dw 16 dup(0)
;stack ends
;code segment
;	mov ax,4c00h
;	int 21h
;	
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,32
;	
;	mov ax,0
;	push ax
;	ret
;code ends
;end start

;assume cs:code,ds:datasg
;datasg segment
;	db 'welcome to masm!'; 16bytes
;datasg ends
;
;code segment
;start:
;	mov ax,0b800h; 0b8000-0bffffh; 32kb
;	mov es,ax
;	mov ax,datasg
;	mov ds,ax
;	
;	;green
;	mov di,1984
;	mov cx,16
;	
;	mov bx,0
;	s:
;		mov dl,[bx]
;		mov es:[di],dl
;		mov byte ptr es:[di+1],0CAh
;
;		inc bx
;		add di,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start


;assume cs:code
;
;code segment
;	mov ax,4c00h
;	int 21h
;start:mov ax,0
;	s:nop
;	nop
;	
;	mov di,offset s
;	mov si,offset s2
;	mov ax,cs:[si]
;	mov cs:[di],ax
;	
;	s0:jmp short s
;	s1:mov ax,0
;	int 21h
;	mov ax,0
;	s2:jmp short s1
;	nop
;code ends
;
;end start

;assume cs:code
;code segment
;start:
;	jmp near ptr s
;	db 128 dup(0)
;	s:mov ax,0ffffh
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start


;assume cs:code
;
;code segment
;	mov ax,2000h
;	mov ds,ax
;	
;	s:mov cl,[bx]
;	mov ch,0; 这个ch必须每次都清零，因为下面是cx加1
;	inc cx
;	inc bx
;	loop s
;	
;	dec bx
;	mov dx,bx
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start


;assume cs:code
;code segment
;start:
;	mov ax,2000h
;	mov ds,ax
;	mov bx,0
;	mov ch,0
;	s:mov cl,[bx]
;	jcxz ok
;	inc bx
;	jmp short s
;	ok:
;	mov dx,bx
;	
;	mov ax,4c00h
;	int 21h
;code ends
;
;end start

;assume cs:code,ds:data
;data segment
;	dd 12345678h
;data ends
;code segment
;start:
;	mov ax,data
;	mov ds,ax
;	mov bx,0
;	mov [bx],bx
;	mov [bx+2],cs
;	;mov [bx],0      ;会报错，因为不知道大小
;	;mov [bx+2],code;应该会报错
;	jmp dword ptr ds:[0]
;code ends
;end start

;assume cs:codesg
;assume ds:datasg
;
;datasg segment
;	dw 0
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	mov bx,0
;	
;	jmp word ptr [bx+1]
;
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start

;assume cs:codesg
;
;codesg segment
;	db 16 dup(0)
;start:
;	mov byte ptr cs:[0],' ' ; 如果是立即数需要确定立即数的宽度，所以在操作内存时得用ptr的形式
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start


;assume cs:codesg1,cs:codesg2
;
;codesg1 segment
;;start      ;是否只能只有一个代码段？这样会报错
;	mov ax,codesg2
;	mov es,ax
;	;jmp far ptr [es]
;codesg1 ends
;
;codesg2 segment
;start:
;	mov cx,0
;	fuck:
;		inc ax
;	dw 256 dup(0)
;codesg2 ends
;end start


;assume cs:codesg
;
;codesg segment
;start:
;	mov ax,0
;	dw 32768 dup(0)  ;超过了64k，汇编器会报警告，说64 limit，链接器会报错
;	inc ax
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg
;assume ds:datasg
;
;datasg segment
;	msg: db 'welcome to here' ; 这样的写法汇编器会报错，难道是只有代码段可以标号？ 这个后面学习再看
;	fuck: db 'long long ago'  ;
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start




;assume cs:codesg
;
;codesg segment
;	msg: db 'welcome to here'
;	fuck: db 'long long ago'
;start:
;	mov ax,offset msg
;	mov bx,offset fuck
;	
;	mov ax,offset start
;	mov cs:[bx], ax
;	jmp word ptr cs:[bx]
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg
;codesg segment
;start:
;	mov ax,0
;	mov bx,0
;	jmp far ptr s
;	db 256 dup(0)
;	s:add ax,1
;	inc ax
;codesg ends
;end start


;assume cs:.init,cs:.text
;.init segment
;start:
;	mov ax,1
;	jmp far ptr s; 为什么这个地方会报错？
;	inc ax
;.init ends
;.text segment
;	s:mov ax,0
;	inc ax
;.text ends
;end start


;assume cs:code
;code segment
;start:
;	;s:inc ax
;	s:add ax,1
;	;jmp near ptr s0
;	jmp s0
;	mov bx,3
;	s0:inc bx
;	jmp s
;	nop
;code ends
;end start

;assume cs:code
;code segment
;start:
;	mov ax,0
;	mov bx,0
;	jmp s
;	add ax,1
;	add ax,2
;	s:inc ax
;code ends
;end start

;assume cs:code,ds:data
;
;data segment
;data ends
;
;code segment
;	start:
;		mov ax,0
;		jmp short s
;		add ax,1
;		s:inc ax
;code ends
;end start


;assume cs:code,ds:data,ds:table,ss:stack
;
;stack segment
;	dw 16 dup (0) ; 32个字节
;stack ends
;
;data segment
;	db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
;	db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
;	db '1993','1994','1995'
;	
;	dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
;	dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
;	
;	dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
;	dw 11542,14430,15257,17800
;data ends
;
;table segment
;	db 21 dup ('year summ ne ?? ')
;table ends
;code segment
;start:
;	mov ax,data
;	mov ds,ax     ;ds ---> data
;	mov ax,table
;	mov es,ax     ;ds ---> table
;	mov ax,stack
;	mov ss,ax
;	mov sp,32
;	
;	;填充年份
;	mov cx,21
;	mov si,0
;	mov di,0
;	s0:
;		push cx   ;保留上一级的cx
;		mov bx,0
;		mov cx,4
;		s1:
;			mov dl,ds:[si+bx]
;			mov es:[di+bx],dl
;			inc bx
;		loop s1
;		
;		mov al,' '
;		mov es:[di+bx],al; 填充空格
;		pop cx    ;恢复上一级的cx
;		add di,10h
;		add si,4
;	loop s0
;	
;	;填充收入
;	mov cx,21
;	mov si,84
;	mov di,5
;	y0:
;		mov ax,ds:[si]
;		mov es:[di],ax
;		mov ax,ds:[si+2]
;		mov es:[di+2],ax
;		mov al,' '
;		mov es:[di+4],al; 填充空格
;		
;		add di,10h
;		add si,4
;	loop y0
;	
;	;填充雇员数
;	mov cx,21
;	mov si,168
;	mov di,0ah
;	z0:
;		mov ax,ds:[si]
;		mov es:[di],ax
;		
;		mov al, ' '
;		mov es:[di+2],al;填充空格
;		add di,10h
;		add si,2
;	loop z0
;	
;	;填充人均收入
;	mov cx,21
;	mov di,0
;	
;	q0:
;		mov ax,es:[di+5] ;被除数低字
;		mov dx,es:[di+7] ;被除数高字
;		
;		div word ptr es:[di+0ah]
;		mov es:[di+0dh],ax ;商
;		
;		mov al,' ';填充空格
;		mov es:[di+0fh],al
;		
;		add di,10h
;	loop q0
;	
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start



;assume cs:codesg,ds:datasg
;
;datasg segment
;	db 'DEC'
;	db 'Ken Oslen'
;	dw 137
;	dw 40
;	db 'PDP'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov word ptr ds:[0ch],38
;	add word ptr ds:[0eh],70
;	mov si,0
;	mov byte ptr ds:[10h],'V'
;	inc si
;	mov byte ptr ds:[10h+si],'A'
;	inc si
;	mov byte ptr ds:[10h+si],'X'
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg,ds:datasg,ss:stacksg
;
;stacksg segment
;	dw 0,0,0,0,0,0,0,0
;stacksg ends
;
;datasg segment
;	db '1. display      '
;	db '2. brows        '
;	db '3. replace      '
;	db '4. modify       '
;datasg ends
;
;codesg segment
;start:
;	mov ax,stacksg
;	mov ss,ax
;	mov sp,10h
;	mov ax,datasg
;	mov ds,ax
;	
;	mov cx,4
;	mov si,0
;	s0:
;		push cx
;		mov cx,4
;		mov bx,0
;		s1:
;			mov al,3[si+bx]
;			and al,0dfh
;			mov 3[si+bx],al
;			inc bx
;		loop s1
;		
;		pop cx
;		add si,16
;	loop s0
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg,ds:datasg,ss:stacksg
;
;datasg segment
;	db 'ibm     '
;	db 'dec     '
;	db 'dos     '
;	db 'vax     '
;datasg ends
;stacksg segment
;	dw 0,0,0,0,0,0,0,0
;stacksg ends
;codesg segment
;start:
;	;set ds
;	mov ax,datasg
;	mov ds,ax
;	;set ss
;	mov ax,stacksg
;	mov ss,ax
;	mov sp,10h
;	
;	mov cx,4
;	mov si,0
;	s0:
;		push cx
;		mov bx,0
;		mov cx,3
;		s1:
;			mov al,[si+bx]
;			and al,0dfh
;			mov [si+bx],al
;			
;			inc bx
;		loop s1
;		
;		add si,8
;		pop cx
;	loop s0
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start

;assume cs:codesg,ds:datasg
;datasg segment
;	db 'ibm     '
;	db 'dec     '
;	db 'dos     '
;	db 'vax     '
;	db 0; 用来暂存上级循环cx的值
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov cx,4
;	mov si,0
;	s0:
;		mov ds:[20h],cx
;		mov bx,0
;		mov cx,3
;		s1:
;			mov al,[si+bx]
;			and al,0dfh
;			mov [si+bx],al
;			inc bx
;		loop s1
;		
;		add si,8
;		mov cx,ds:[20h]
;	loop s0
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start



;assume cs:codesg,ds:datasg
;datasg segment
;	db 'ibm     '
;	db 'dec     '
;	db 'dos     '
;	db 'vax     '
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov cx,4
;	mov si,0
;	s0:; 时间复杂度为O(n*n)
;		mov bx,0
;		mov dx,cx; 暂存上级的cx
;		mov cx,3 ; 内部循环
;		s1:
;			mov al,[si+bx]
;			and al,0dfh
;			mov [si+bx],al
;			inc bx
;		loop s1
;		mov cx,dx; 恢复上一级的cx
;		add si,8
;	loop s0
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg,ds:datasg
;datasg segment
;	db '1. file         '
;	db '2. edit         '
;	db '3. search       '
;	db '4. view         '
;	db '5. options      '
;	db '6. help         '
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov cx,6
;	mov si,0
;	
;	s:mov al,3[si]
;	and al,0dfh
;	mov 3[si],al
;	add si,16
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start


;assume cs:codesg,ds:datasg
;datasg segment
;	db 'welcome to masm!'
;	db '................'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	mov si,0
;	mov cx,8
;	
;	s:mov ax,0[si]
;	mov 16[si],ax
;	add si,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;end start


;assume cs:codesg,ds:datasg
;datasg segment
;	db 'welcome to masm!'
;	db '................'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov si,0
;	mov di,16
;	
;	mov cx,8
;	mov bx,0
;	
;	s:mov ax,[si+bx] ;mov ax,[bx][si]
;	mov [di+bx],ax
;	add bx,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start


;assume cs:codesg,ds:datasg
;
;datasg segment
;	db 'welcome to masm!'
;	db '................'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov si,0
;	mov di,10h
;	mov cx,16; mov cx,8
;	
;	s:
;	mov al,[si]
;	mov [di],al
;	inc si  ; add si,2
;	inc di  ; add di,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start


;assume cs:codesg,ds:datasg
;datasg segment
;	db 'BaSiC'
;	db 'MinIx'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	
;	mov bx,0
;	mov cx,5
;	
;	s:
;	mov al,[bx]
;	and al,11011111b
;	mov [bx],al
;	
;	mov al,[bx].5; mov al,[bx+5] mov al,[5+bx] mov al, 5[bx]
;	or al,00100000b
;	mov [bx].5,al
;	inc bx
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;codesg ends
;
;end start


;assume cs:codesg,ds:datasg
;
;datasg segment
;	db 'BaSiC'
;	db 'iNfOrMaTiOn'
;datasg ends
;
;codesg segment
;start:
;	mov ax,datasg
;	mov ds,ax
;	mov bx,0
;	
;	mov cx,5
;	s1:
;	mov al,ds:[bx]
;	and al,0dfh
;	mov ds:[bx],al
;	inc bx
;	loop s1
;	
;	mov cx,11
;	s2:
;	mov al,ds:[bx]
;	or al,20h
;	mov ds:[bx],al
;	inc bx
;	loop s2
;	
;	mov ax,4c00h
;	int 21h
;	
;codesg ends
;end start



;assume cs:code,ds:data
;data segment 
;	db 'unIx'
;	db 'foRK'
;data ends
;
;code segment
;start:
;	mov al,'a'
;	mov bl,'b'
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start

;assume cs:code
;
;a segment
;	dw 1,2,3,4,5,6,7,8,9,0ah,0bh,0ch,0dh,0eh,0fh,0ffh
;a ends
;
;b segment 
;	dw 0,0,0,0,0,0,0,0
;b ends
;
;code segment
;start:
;	mov ax,b
;	mov ss,ax
;	mov sp,10h
;	
;	mov ax,a
;	mov ds,ax
;	mov bx,0
;	mov cx,8
;	s:
;	push ds:[bx]
;	add bx,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start




;assume cs:code
;
;a segment
;	db 1,2,3,4,5,6,7,8
;a ends
;b segment
;	db 1,2,3,4,5,6,7,8
;b ends
;c1 segment
;	db 0,0,0,0,0,0,0
;c1 ends
;
;code segment
;start:
;	mov cx,8
;	mov bx,0
;	s:
;	mov ax,a
;	mov ds,ax
;	mov dl,ds:[bx]
;	mov ax,b
;	mov ds,ax
;	mov al,ds:[bx]
;	add dl,al
;	mov ax,c1
;	mov ds,ax
;	mov ds:[bx],dl
;	inc bx
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start


;assume cs:code,ds:data,ss:stack
;code segment
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,16
;	
;	mov ax,data
;	mov ds,ax
;	
;	push ds:[0]
;	push ds:[2]
;	pop ds:[2]
;	pop ds:[0]
;	
;	mov ax,4c00h
;	int 21h
;code ends
;
;data segment 
;	dw 0123h,0456h
;data ends
;
;stack segment
;	dw 0,0
;stack ends
;
;end 

;assume cs:code,ds:data,ss:stack
;
;stack segment
;	dw 0,0
;stack ends
;data segment
;	dw 0123h,0456h
;data ends
;code segment
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,16
;	mov ax,data
;	mov ds,ax
;	
;	push ds:[0]
;	push ds:[2]
;	pop ds:[2]
;	pop ds:[0]
;	mov ax,4c00h
;	int 21h
;code ends
;end

;assume cs:code,ds:data,ss:stack
;
;data segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;data ends
;
;stack segment
;	dw 0,0,0,0,0,0,0,0
;stack ends
;
;code segment
;start:
;	mov ax,stack
;	mov ss,ax
;	mov sp,16
;	
;	mov ax,data
;	mov ds,ax
;	
;	push ds:[0]
;	push ds:[2]
;	pop ds:[2]
;	pop ds:[0]
;	
;	mov ax,4c00h
;	int 21h
;code ends
;end start

;assume cs:code
;assume ds:data
;assume ss:stack
;
;data segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;data ends
;
;stack segment
;	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
;stack ends
;
;code segment
;start:
;	mov ax,data
;	mov ds,ax
;	
;	mov ax,stack
;	mov ss,ax
;	mov sp,20h
;	
;	mov cx,8
;	mov bx,0
;	s:
;	push [bx]
;	add bx,2
;	loop s
;	
;	mov cx,8
;	mov bx,0
;	s0:
;	pop [bx]
;	add bx,2
;	loop s0
;	
;	mov ax,4c00h
;	int 21h
;code ends
;
;end start

;assume cs:.text
;.text segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;	dw 0,0,0,0,0,0,0,0,0,0
;start:
;	mov ax,cs
;	mov ss,ax
;	mov sp,24h
;	
;	mov ax,0
;	mov ds,ax
;	
;	mov cx,8
;	mov bx,0
;	
;	s:push ds:[bx]
;	pop cs:[bx]
;	add bx,2
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;.text ends
;end start


;assume cs:.text
;.text segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;	dw 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
;start:
;	mov ax,cs
;	mov ss,ax
;	mov sp,30h
;	
;	mov bx,0
;	mov cx,8
;	s:push cs:[bx]
;	add bx,2
;	loop s
;	
;	mov cx,8
;	mov bx,0
;	s1:pop cs:[bx]
;	add bx,2
;	loop s1
;	
;	mov ax,4c00h
;	int 21h
;.text ends
;end start

;assume cs:.text
;.text segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h 
;start:
;	mov ax,2000h
;	mov ss,ax
;	mov sp,10
;	
;	mov cx,8
;	mov bx,0
;	s1:
;	push cs:[bx]
;	add bx,2
;	loop s1
;	
;	mov cx,8
;	mov bx,0
;	s2:
;	pop cs:[bx]
;	add bx,2
;	loop s2
;	
;	mov ax,4c00h
;	int 21h
;.text ends
;end start


;assume cs:.text
;.text segment
;	dw 0123h,0456h,0789h,0abch,0defh,0fedh,0cbah,0987h
;	start:
;	mov ax,cs
;	mov ss,ax
;	xor sp,0
;	
;	mov cx,4
;	mov bx,10h
;	s:
;	sub bx,2
;	mov dx,cs:[bx]
;	pop cs:[bx]
;	mov di,	
;	mov cs:[di-2],dx
;	loop s
;	
;	mov ax,4c00h
;	int 21h
;.text ends
;
;end start