;se citesc 2 siruri de la tastatura, sa se afiseze pe ecran
assume cs:code, ds:data

data segment
		mesaj_citire db 'Se citeste sirul: ','$'
		mesaj_afisare db 'Sirurile citite sunt:','$'
		sir1 db 30,?,30 dup (?)
		sir2 db 30,?,30 dup (?)
		linieNoua db 10,13,'$'
data ends

code segment
start:
	mov ax, data
	mov ds, ax
	
;----------------------citire siruri----------------------------------------
	mov ah,09h
	mov dx, offset mesaj_citire
	int 21h ;afisare mesaj pentru citire
	
	mov ah,0Ah
	mov dx, offset sir1
	int 21h ;citire sir
	
	mov al,byte ptr sir1[1]
	mov ah,0
	mov si,ax
	mov sir1[si+2],'$';muta pe ultima pozitie a sirului $
	
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset mesaj_citire
	int 21h ;afisare mesaj pentru citire
	
	mov ah,0Ah
	mov dx, offset sir2
	int 21h ;citire sir
	
	mov al,byte ptr sir2[1]
	mov ah,0
	mov si,ax
	mov sir2[si+2],'$';muta pe ultima pozitie a sirului $
	
;----------------------afisare siruri----------------------------------------
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset mesaj_afisare
	int 21h ;afisare mesaj pentru afisare
	
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset sir1[2]
	int 21h ;afisare sir1
	
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
	mov ah,09h
	mov dx, offset sir2[2]
	int 21h ;afisare sir1
	
	mov ah, 09h
	mov dx, offset linieNoua
	int 21h
	
mov ax,4c00h
int 21h
code ends
end start