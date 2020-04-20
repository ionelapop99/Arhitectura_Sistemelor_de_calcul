; Sa se calculeze expresia aritmetica :
; z=(2+1/a)/(3+1/(b*b))-1/(c*c)

; Am considerat a,b,c - byte

; ne vor interesa doar caturile impartirilor
; rezultatul va fi de tip word

;varianta fara semn

assume cs:code,ds:data
data segment
a db 1
b db 6
c db 10
z dw ?
data ends
code segment
incepe:
mov ax,data
mov ds,ax
mov al,b
mul b ;ax=b*b word
mov bx,ax 
;bx=b*b
;
mov ax,1 ;ax=1 word
mov dx,0 ;cwd dx:ax=1 dw
div bx; ax cat dx restul
;dx:ax=1/(b*b)
;
add ax,3
; ax=(3+1/(b*b))
;
mov cx,ax
;cx=(3+1/(b*b))
;
mov bl,a
mov ax,1
div bl;ah rest, al cat
add al,2; byte
mov ah,0 ;cbw; ax=1/a+2 word
mov dx,0 ;cwd; dx:ax=1/a+2 dw
;
div cx; ax cat dx rest dx:ax=(2+1/a)/(3+1/(b*b))
;
mov bx,ax; bx cat (2+1/a)/(3+1/(b*b))
mov al,c;
mul c;; ax=c*c
mov cx,ax; cx=c*c
mov ax,1;ax=1;
mov dx,0 ;cwd;dx:ax=1
div cx;dx:ax=1/(c*c) ax rest dx cat
;
sub bx,ax;  word-word
mov z,bx;
;
;
mov ax, 4C00h
int 21h
code ends
end incepe


; Date de test: z=(2+1/a)/(3+1/(b*b))-1/(c*c)=(2+1/1)/(3+1/(6*6))-1/(10*10)=3/3-0=1
