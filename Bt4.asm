		ORG 	00H
LJMP	MAIN
		ORG		13H
LJMP	INT1_ISR
		ORG		0BH
LJMP	TF0_ISR
		ORG		23H
LJMP	SERIAL
		ORG		30H

MAIN:		MOV		TMOD, #22H	; mode 2 timer0, mode 2 timer1
		MOV		TH1, #0F3H	; baud rate 2400
		MOV		SCON, #40H	; mode 1 uart
		MOV		TH0, #06H	; set TH cua timer0
		MOV		IE, #96H	; enable interrupt
		MOV		PCON, #10000000B	; X2 baud rate => 4800
		SETB	PS			; set uu tien 1 cho serial interrupt
		SETB	IT1			; ngat canh xuong
		SETB	TR1
		
		MOV		R0,	#0	; counter to create 500HZ 
		MOV		R1, 	#0	; counter 250
		MOV		R2,	#0	; counter to set delay 10 second	
LOOP:		
		SJMP	LOOP			; infinite loop

SERIAL:						; ngat serial uart	
		CLR		TI
		RETI

INT1_ISR: 					; ngat INT1
		SETB		TR0		; enable timer 0
		MOV		A, #"1"		; send 18521310-NGUYENKIMQUOC
		MOV		SBUF, A	
		JNB		TI, $
		MOV		A, #"8"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"5"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"2"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"1"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"3"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"1"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"0"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"-"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"N"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"G"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"U"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"Y"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"E"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"N"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"K"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"I"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"M"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"Q"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"U"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"O"
		MOV		SBUF, A
		JNB		TI, $
		MOV		A, #"C"
		MOV		SBUF, A
		RETI
TF0_ISR:
		MOV		A, R0
		ADD		A, #1
		MOV		R0, A
		CLR		TR0
		CJNE		R0, #4, NEXT	; create 500Hz from 2KHz

		MOV		A, R1		;
		ADD		A, #1		;
		MOV		R1, A		;
		CJNE		R1, #250, NEXT1	;
		MOV		R1, #0		;
		MOV		A, R2		; Check 10 second
		ADD		A, #1		;
		MOV		R2, A		;
		CJNE		R2, #40, NEXT1	;
		MOV		R2, #0		
		CLR		TR0
		RETI
NEXT1:
		CPL		P1.1		; tao xung vuong
		MOV		R0, #0

NEXT:
		SETB	TR0
		RETI

END