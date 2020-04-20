;sa se citeasca un sir din fisier si sa se afiseze in fisier
assume cs:code, ds:data

data segment
	mesaj db 'Se citeste nume fisier: ','$'
	mesaj_citire db 'Se citeste sirul: ','$'
	eroare1 db 'Drumul catre fisier nu a fost gasit', '$'
	eroare2 db 'Nu exista nici un descriptor valabil', '$'
	eroare3 db 'Nu ai primit acces la fisier', '$' 
	numeFisier db 30,?,30 dup (?)
	sir db 35 dup (?)
	descriptor dw ?
	linieNoua db 10,13,'$'
	linieNF db 10,13
	dim dw ?
	
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	clc
	mov ah,09h
	mov dx, offset mesaj
	int 21h ;afisare mesaj pentru citires
	
	mov ah,0Ah
	mov dx, offset numeFisier
	int 21h ;citire nume(se da cu .txt)
	
	;---------------------transformare in ASCIIZ--------------------------------------
	mov al,byte ptr numeFisier[1]
	mov ah,0
	mov si,ax
	mov numeFisier[si+2],0;muta pe ultima pozitie a sirului 0
	;--------------------deschidere fisier-------------------------------------------
	mov ah,3Dh
	mov al,2
	mov dx,offset numeFisier[2]
	int 21h
	
	jc eroare
	
	mov descriptor,ax


	;-----------------------Citire din fisier---------------------------------------------
	mov ah,3Fh
	mov bx,descriptor
	mov cx,40
	mov dx,offset sir[1]
	int 21h
	;ax numar caractere citite
	mov si,ax
	mov sir[si+1],'$';muta pe ultima pozitie a sirului $
	
	mov dim,ax
	;------------------------afisare pe ecran---------------------------------------------
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset mesaj_citire
	int 21h ;afisare mesaj pentru afisare
	
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset sir
	int 21h ;afisare sir
	
	;-----------------------------scriere in fisier---------------------------------------------
	;daca sirul e citit de la tastatura si se scrie in fisier sirul nu mai trebuie prelucrat
	
	;nu merge linia noua in fisier, sorry :-((((
	;mov ah,40h
	;mov bx,descriptor
	;mov cx,1
	;mov dx, offset linieNF
	;int 21h
	
	mov ah,40h
	mov bx,descriptor
	mov cx,17
	mov dx, offset sir
	int 21h
	;-----INCHIDERE FISIER CREAT--------------------------------------------------------------
	mov bx, descriptor
	mov ah, 3Eh
	int 21h
	
	jmp dupa
	eroare:
		mov dx, offset eroare1
		mov ah, 09h
		int 21h
	dupa:
mov ax,4c00h
int 21h
code ends
end start
	