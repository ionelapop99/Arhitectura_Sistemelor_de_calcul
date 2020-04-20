;1. Se da un sir de octeti in segmentul de date. Sa se afiseze elementele acestui sir la iesirea standard (ecran) in baza 2.
;
assume ds:data,cs:code
data segment
	 sir db 0aeh,82h,73h,0abh,99h,0,5dh;sirul de octeti din segmentul de date
	 ; sir 10000,10110,110000,1010000,10101011
	 d equ $-sir        ;nr octeti din sir
	 linieNoua db 10,13,'$'
data ends
code segment
start:

     mov ax,data
     mov ds,ax
	 mov si, 0 ;indexul pentru sir
	 
	 ;afisare elemente sir in binar 
	 repetaSir:
		mov cx, 8; nr de biti dintr-un byte
		mov bh,0
		
		mov bl, sir[si] ;bl =sir[si] un octet
		repeta:
			clc  ;clear carry flag
			shl bl,1
			;if CF=1 print 1, else print 0
			jc afis1
			afis0:
				mov ah,02h
				mov dl,'0'
				int 21h
			jmp final
			afis1:
				mov ah,02h
				mov dl,'1'
				int 21h
			final:
		loop repeta
		
		;afisare linie noua
		mov ah, 09h
		mov dx, offset linieNoua
		int 21h
		
		add si, 1
		cmp si, d
		

	jne repetaSir
     mov ax,4C00h
     int 21h
	 
code ends
end start