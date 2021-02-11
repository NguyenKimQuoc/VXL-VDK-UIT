	ORG 00h
LJMP	MAIN
	ORG	0Bh
LJMP	tf0_isr
	ORG 030h
MAIN:	MOV 	TMOD, #02H	; Timer 0 che do 2 8-bit
	MOV 	TH0, #0A4H	; 255 - 92 + 1 = 164 = A4h
	SETB	TR0
	MOV	IE, #082h
	MOV	R0, #01H
	MOV	P1, #0FEH	
LOOP:
	MOV	A, R0
	SUBB	A, P0
	CJNE	A, #0H, NEXT	;Neu P0 khac voi gia tri P0 truoc do thi nhay qua NEXT
	MOV	A, P0
	SUBB	A, R0
	CJNE	A, #0H, NEXT	
	SJMP	LOOP
NEXT:
	MOV	A, P1		;Lay gia tri truoc do
	MOV	B, P0		;Lay gia tri P0 hien tai
	CPL	A
	MUL	AB		; Nhan 2 cai lai
	CPL	A
	MOV	P1, A		; Luu gia tri P0 truoc do
	MOV	R0, P0		; Xuat KQ vua nhan dc
	SJMP	LOOP
tf0_isr: 
	CLR	TR0
	CPL	P2.1
	SETB	TR0
	RETI
END