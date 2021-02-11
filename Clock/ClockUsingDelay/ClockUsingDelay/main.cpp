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
void Display();
volatile long long int count=0;
int hour=19;
int minute=35;
int second=0;

int main(void){
    /* Replace with your application code */
	
	DDRC=0xff;
	DDRD=0xff;
	PORTC=0x00;
	PORTD=0x00;
    while (1) {	
		Display();
    }
}

void Display(){
	_delay_ms(34);
	count++;
	if(count==25){
		second++;
		count=0;
	}
	if(second==60){
		minute=minute+1;
		second=0;
	}
	if(minute==60){
		hour=hour+1;
		minute=0;
	}
	if(hour==24){
		hour=0;
	}
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

