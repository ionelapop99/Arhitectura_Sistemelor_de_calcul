;3.Sa se înlocuiasca primii trei biti ai cuvântului B cu ultimii trei biti ai octetului A.
assume cs:code, ds:data
data segment
  a db 10110010b
  b dw 0101011011001110b
data ends

code segment
start:
  mov ax, data ; incarcam adresa segmentului de date in resgistrul ds
  mov ds, ax

;mutare si izolare biti in ax
  mov al,a;
  mov ah,0;
  and al,11100000b;
  
  mov bx,b;mutare b in bx
  
;rotire a la stanga cu 5 poz 
  mov cl,5;
  ror ax,cl;
  
;stergere primii 3 biti din b
  and bx,1111111111111000b;
  
;mutare bitii izolati din ax in bx
  or bx,ax;
  mov b,bx;

  mov ax, 4c00h ; terminam programul
  int 21h
code ends
end start

;Date de test:
;1. pentru a=11100000b(E0) si b=0000000000111000b(38)
;						  =>b=0000000000111111b(3F)
;2.a=10110010(B2)
;  b= 101011011001110(56CE)
;=> b=101011011001101(56CD)