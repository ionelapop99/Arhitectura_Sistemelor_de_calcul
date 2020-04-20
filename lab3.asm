;4. Se dă un sir de cuvinte. Să se construiască doua siruri de octeti, s1 si s2, astfel: pentru fiecare cuvânt,
;- dacă numărul de biti 1 din octetul high al cuvântului este mai mare decât numărul de biti 1 din octetul low, 
;atunci s1 va contine octetul high, iar s2 octetul low al cuvântului
;- dacă numărul de biti 1 din cei doi octeti ai cuvântului sunt egali, atunci s1 va contine numărul de biti 1 din octet,
; iar s2 valoarea 0
;- altfel, s1 va contine octetul low, iar s2 octetul high al cuvântului.

assume ds:data,cs:code
data segment
     s dw 0a5b1h, 77efh, 34a0h, 0e0fh   ;sirul initial de cuvinte
	 ; 00000001 00000001,00000011(3) 00001000(8),00000100 00001000
     d equ $-s        ;nr octeti din s
	 d12 equ d/2	;dimensiune sir(nr cuvinte)
	 s1 db d12 dup(?) ;SIRURI REZULTATE
	 s2 db d12 dup(?)
data ends
code segment
start:

     mov ax,data
     mov ds,ax
	 mov si, 0 ;indexul pentru sir
	 mov bl, 0 ; registru pt incrementare low
	 mov bh, 0; registru pt incrementare hight
	 mov di,0; indexul pt s1 si s2
	 
	 mov cx,d12  ; repeta se executa de cx ori
	 repeta: ;parcurgerea sirului
		mov ax, s[si] ;ax =sir[si] un cuvant
		;ah partea hight; al partea low
		mov dh,ah ;copie pt ah pt ca il vom distruge la numarare
		mov dl,al;copie pt al pt ca il vom distruge la numarare
		
		;----------Numaram bitii cu valoarea unu din partea low--------------
		unuLow: ;shiftam fiecare cuvant pe rand pana e gol
			shl al, 1
			jc incrementareLow
			jmp nextLow
			incrementareLow:
				inc bl
			nextLow:
				cmp al, 0
		jne unuLow
		
		;----------Numaram bitii cu valoarea unu din partea hight--------------
		unuHight: ;shiftam fiecare cuvant pe rand pana e gol
			shl ah, 1
			jc incrementareHight
			jmp nextHight
			incrementareHight:
				inc bh
			nextHight:
				cmp ah, 0
		jne unuHight
		;------------Sfarsit---------------------------
		
		;comparam numarul de biti 1 din partea hight(ah) cu nr de biti 1 din partea low(al)
		cmp bh,bl;comaram numarul de 1 din partea high si low memorate in bh respectiv bl
		
		jb smaller;<
		je equal;=
		ja bigger;>
		
		bigger:
			mov s1[di],dh
			mov s2[di],dl
			jmp final
		equal:
			mov s1[di],bh
			mov s2[di],0
			jmp final
		smaller:
			mov s1[di],dl
			mov s2[di],dh
			jmp final
		final:
			inc di; contorul pt s1 si s2 creste
			mov bl, 0 ; registru pt incrementare low
			mov bh, 0; registru pt incrementare hight
		add si, 2 ;trecerea la cuvantul urmator(sir de cuvinte, fiecare cuvant are 2 octeti)
	 loop repeta
     mov ax,4C00h
     int 21h
	 
code ends
end start
