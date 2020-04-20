;Sa se citeasca un sir de caractere de la tastatura.
;Dupa citirea sirului, concatenati sirul citit cu sirul ".txt" si creati fisierul cu numele obtinut.
;(exemplu: daca se citeste sirul "abc", se va crea fisierul cu numele "abc.txt")
;Trebuie sa se tina cont de cazurile de eroare.


assume cs:code, ds:data

data segment
		mesaj db 'Se citeste sirul ','$'
		eroare1 db 'Drumul catre fisier nu a fost gasit', '$'
		eroare2 db 'Nu exista nici un descriptor valabil', '$'
		eroare3 db 'Nu ai primit acces la fisier', '$' 
		numeFisier db 30,?,30 dup (?)
		extensie db '.txt',0
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	clc
	mov ah,09h
	mov dx, offset mesaj
	int 21h ;afisare mesaj pentru citire
	
	mov ah,0Ah
	mov dx, offset numeFisier
	int 21h ;citire sir
	
	;----CONCATENARE----
	mov si,0
	mov al, byte ptr numeFisier[1]
	mov ah, 0
	mov di, ax
	add di, 2
	repeta:
		mov al, extensie[si]
		mov numeFisier[di], al
		inc di
		inc si
	cmp si,4
	jne repeta
	
	;----CREARE FISIER----
	mov ah, 3CH
	mov cx,0
	mov dx, offset numeFisier[2]
	int 21h
	
	jc eroare
	jmp inchidere
	eroare:
		cmp ax, 3
		je er1
		jmp next
		er1: ;primul caz de eroare
			mov dx, offset eroare1
			jmp afisare
		next:
			cmp ax, 4
			je er2 ;al doilea caz de eroare
			er2:
				mov dx, offset eroare2
				jmp afisare
			jmp next2
		next2: ;ultimul caz de eroare
			mov dx, offset eroare3
		afisare:
			mov ah, 09h
			int 21h ;afisare mesaj de eroare
			jmp final
	inchidere:
		;-----INCHIDERE FISIER CREAT-----
		mov bx, ax
		mov ah, 3Eh
		int 21h
	final:
	mov ax,4c00h
	int 21h
code ends
end start