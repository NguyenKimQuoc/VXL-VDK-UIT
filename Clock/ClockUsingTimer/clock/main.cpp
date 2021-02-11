/*
 * clock.cpp
 *
 * Created: 3/25/2020 7:56:25 AM
 * Author : quang
 */ 
#define F_CPU 8000000UL
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
void Display(int hour,int minute,int second);
volatile long long int count=0;

int main(void){
    /* Replace with your application code */
	int gio=19;
	int phut=50;
	int giay=40;
	DDRC=0xff;
	DDRD=0xff;
	PORTC=0x00;
	PORTD=0x00;
	TCCR0=(1<<CS01)|(1<<CS00);
	TCNT0=130;
	TIMSK|=(1<<TOIE0);
	sei();
    while (1) {
		if(count>=1000){
			giay=giay+1;
			count=0;
		}
		if(giay==60){
			phut=phut+1;
			giay=0;
		}
		if(phut==60){
			gio=gio+1;
			phut=0;
		}
		if(gio==24){
			gio=0;
		}
		Display(gio,phut,giay);
    }
}
ISR(TIMER0_OVF_vect)
{
	TCNT0=130;
	count=count+1;
}
void Display(int hour,int minute,int second){
	int hour1=hour/10;
	int hour2=hour%10;
	int minute1=minute/10;
	int minute2=minute%10;
	int second1=second/10;
	int second2=second%10;
	PORTD=0b00000001;
	PORTC=hour1;
	_delay_ms(1);
	PORTD=0b00000010;
	PORTC=hour2;
	_delay_ms(1);
	PORTD=0b00000100;
	PORTC=minute1;
	_delay_ms(1);
	PORTD=0b00001000;
	PORTC=minute2;
	_delay_ms(1);
	PORTD=0b00010000;
	PORTC=second1;
	_delay_ms(1);
	PORTD=0b00100000;
	PORTC=second2;
	_delay_ms(1);
	
}

